"""
E4MC Discord bot that updates its status based on the server's state.

Modules:
    discord: Provides the Discord API.
    asyncio: Provides support for asynchronous programming.
    aiofiles: Provides support for asynchronous file operations.
"""

import os
import logging
import sys
import re
import discord
import asyncio
import aiofiles
from enum import Enum

# Set up logging
DEBUG_MODE = os.getenv('DEBUG_MODE', 'False').lower() in ('true', '1', 't')
logging.basicConfig(
    level=logging.DEBUG if DEBUG_MODE else logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Discord bot settings
TOKEN = os.getenv('DISCORD_TOKEN')
CHANNEL_ID = os.getenv('DISCORD_CHANNEL_ID')

# Ensure token and channel ID are provided
if not TOKEN or not CHANNEL_ID:
    logging.error("Discord token or channel ID not provided.")
    sys.exit(1)

CHANNEL_ID = int(CHANNEL_ID)

# Get the log file path from command-line arguments
if len(sys.argv) < 2:
    logging.error("Log file path not provided.")
    sys.exit(1)

LOG_FILE_PATH = sys.argv[1]

# Discord client setup
intents = discord.Intents.default()
client = discord.Client(intents=intents)

class ServerState(Enum):
    OFFLINE = 'OFFLINE'
    HOSTED = 'ONLINE hosted'
    ERROR = 'ERROR'

async def set_bot_status(state, domain=None):
    """
    Set the bot's status on Discord.

    Args:
        state (ServerState): The state of the server.
        domain (str, optional): The domain if the server is hosted. Defaults to None.
    """
    status = domain if domain else state.value
    activity = discord.Game(name=f"{status}")
    await client.change_presence(activity=activity)
    logging.info(f'Updated bot status to: {status}')

async def monitor_minecraft_chat(log_file_path):
    """
    Monitor the Minecraft log file for specific events and update the bot's status accordingly.

    Args:
        log_file_path (str): The path to the Minecraft log file.
    """
    logging.info(f'Starting to monitor Minecraft log file: {log_file_path}')
    async with aiofiles.open(log_file_path, 'r') as log_file:
        await log_file.seek(0, os.SEEK_END)
        while True:
            line = await log_file.readline()
            if not line:
                await asyncio.sleep(0.1)
                continue
            logging.debug(f'Read line: {line.strip()}')
            if "Stopping server" in line:
                await handle_server_stop(log_file_path)
            elif (match := re.search(r'\[CHAT\] Local game hosted on domain \[(.*\.e4mc\.link)\]', line)):
                await set_bot_status(ServerState.HOSTED, match.group(1))
            elif "[FastQuit] Finished saving" in line:
                await handle_server_stop(log_file_path)

async def handle_server_stop(log_file_path):
    """
    Handle the event when the Minecraft server stops.

    Args:
        log_file_path (str): The path to the Minecraft log file.
    """
    logging.info('Detected server stop.')
    await set_bot_status(ServerState.OFFLINE)
    await asyncio.sleep(1)  # Brief delay before restarting monitoring
    await monitor_minecraft_chat(log_file_path)

async def check_initial_state(log_file_path):
    """
    Check the initial state of the Minecraft server from the log file.

    Args:
        log_file_path (str): The path to the Minecraft log file.

    Returns:
        ServerState or str: The initial state of the server or the domain if hosted.
    """
    logging.info(f'Checking initial state of Minecraft log file: {log_file_path}')
    async with aiofiles.open(log_file_path, 'r') as log_file:
        lines = await log_file.readlines()
        for line in reversed(lines):
            logging.debug(f'Initial check line: {line.strip()}')
            if "Stopping server" in line:
                return ServerState.OFFLINE
            if (match := re.search(r'\[CHAT\] Local game hosted on domain \[(.*\.e4mc\.link)\]', line)):
                return match.group(1)
    return None

@client.event
async def on_ready():
    """
    Event handler for when the bot is ready.
    """
    logging.info(f'Logged in as {client.user}')
    initial_state = await check_initial_state(LOG_FILE_PATH)
    if initial_state:
        await set_bot_status(initial_state if isinstance(initial_state, ServerState) else ServerState.HOSTED, initial_state if not isinstance(initial_state, ServerState) else None)
    await monitor_minecraft_chat(LOG_FILE_PATH)

if __name__ == "__main__":
    client.run(TOKEN)
