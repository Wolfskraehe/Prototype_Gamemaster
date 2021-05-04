## Prototype for a turnbased system
Currently consisting of four classes (scenes)
GameMaster, House, Character, Action

GameMaster is the main class and main scene that loads and instanced everything
House keeps the information about the different players or ai
Character keeps track of the different characters a house can have, currently only used for the leader of the house
Action is a template to implement different actions a player or ai can perform each turn

Actions are divided in instant and long term. Instant action are executed imidially. Long term actions are stored
into a queue. After the player end his turn, the ai executes its turn and can also queue long term actions. At the end all
actions from the queue gets resolved.


