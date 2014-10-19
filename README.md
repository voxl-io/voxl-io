# Edifice
A voxel tower simulation game by Edifice Systems

## Game Premise
A cross between SimCity & SimTower, Minecraft & Anno 2070, this browser-based game allows a player to create and simulate a thriving self-sustaining community within the confines of a vertical structure-- an Edifice-class Colony.

## Gameplay
Edifice takes place in a post-apocalyptic Earth, and starts the player in a hostile environment of their choosing. They must use their equipment to create, develop, and engineer resources into a colony. The Edifice-class Colony is intended to be a single structure, built in all three dimensions. Because the environment is so hostile, great care must be taken to balance resources and be as self-sufficient as possible. All resources have material usage cycles, and have associated economic value.

A major portion of the game centers around the editing of blocks-based components, objects, and structures, using a seamless 3D (2.5D) editor.

The game's perspective will resemble that of SimCity 4, but the internals of buildings and structures will be displayed much as in SimTower. Resource management will be similar to SimIsle or Tropico, in that you will need to process materials into equipment and structures with a complex resource management system. All this will be functionally displayed and be interacted with by the player in an isometric voxel/block-style game area, which will lend to the game's characteristic art technique.

Edifice assets will be accessed in a manner similar to the sorting mechanisms available in SimCity Societies, however, each assembly can be customized by the player with tools easy enough to use that there's no need for Spore-esque procedural handlers.

Later, Real-Time Strategy and multiplayer elements will be developed, which take advantage of the game's Meteor development platform.

## Assemblies
Assemblies are artistic assets that also have associated gameplay value. They are composed of individual voxel points with color and functionality attributes. The Edifice Engine precomputes user-specified inputs and outputs, as well as transformations that take place within the assembly. Assemblies could be equipment, pipes, and rooms.

## Graphics & Engine
  - Three.js, Voxel.js libraries, and Meteor.
  - A reactive, event-driven rendering system.
  - Voxels are stored as documents within collections, and delivered to the client reactively. The JSON data structures lend themselves to excellent persistence, MongoDB provides scalability, and can be used for serverside processing.

## Gameplay
Structure efficiency, resource input and production output, worker population, and other structure attributes are analyzed and computed once the player completes design of the structure. If the attributes suit the player's needs, the player can then set the construction of the structure, piece-by-piece by his construction workers. By doing this, not all rooms will need to be analyzed on each game cycle; instead, structures will act as nodes in a graph which computes their attributes and flow of resources.

## Setting
The fact that everything is displayed in voxel blocks is explained to the player as that they are an AI, they have limited detail of the world they're observing and manipulating.

A brutal war over resources and politics escalated to put into motion a collective global war machine, relentless in pursuing mutually-assured destruction. In the year 2099, we, as the remaining survivors of humanity, look down to Earth from our geostationary SkyHaven to face the aftermath of our reckless destruction. We have destroyed over 90% of the earth's surface in a war using biological, nanotechnological, and nuclear weapons. A task force has been organized across the remaining SkyHavens to land upon the planet below in order to put right our transgressions against our planet.

## Controls & Interface
There will be a 'slicing' mechanism to display parts of a structure or block object, which, in effect, creates a cutaway view of the object in the window. There will be GUI arrows along the edges of the hexagonal display focus, in addition to keyboard controls (Left/Right arrows for X-axis, Up-Down for Y-axis) as well as the mouse wheel for the Z-axis. The Z-axis control would be used more often in gameplay because it moves the player up floors.

As with prior Sim games, there will be quick-access toolbars on the left-hand side of the screen. The primary, most important functions will allow the player to use:
  - Tools menu
    - Deconstruct -- Self-explanatory; Becomes a Recycle button once modern recycling facilities are created
    - Ascend/Descend Level -- Moves your cross-section of the tower up or down, so you can see different floors; floor exteriors beneath the current level will be displayed, but not above
    - Zoom -- Three levels of zoom, just like in Yoot Tower
    - Rotate Left/Right -- Rotates the view of the tower 90 degrees
    - Exterior View --
  - Construction Menu
    - Structure -- Common Areas, Floors, Skybridge
    - Residential -- Accommodations, Dwellings
    - Commercial -- Shops, Offices
    - Industrial -- Power, Materials, Remediation
    - Support -- Medical, Security
    - Special -- Dependent on Environment chosen, includes such structures as Botanic Gardens & an Airport
  - Mini-map --  Map goes on the center

## Components
Game objects are first built from scratch using bricks. Those bricks can then be grouped in blocks that correspond to tiles on the Deck. Blocks can consist of multiple tiles, but cannot be smaller than one tile. Once an object is built, it is stored and displayed in concatenated form, outside of the editor.

  - Voxels: Zoomed-in view, using small, voxels that allow the user to build custom bricks.
  - Bricks: Small, basic building bricks ~(1,1)
    - Brick Colors: There will be two views; a crosshatch-shaded view to display functionality, and a color-shaded view to display block colors.
  - Blocks: Groups of bricks that can be positioned over tiles, spread over the area of the block ~(10, 10, 10)
  - Decks:  Group of blocks; a deck can be the size of one room, or many rooms, spread across a story. A Deck can be grouped and packaged into a single unit, but Decks that are copied are not immediately constructed, and must be edited and approved for final integration into the structure. ~(100, 100, 10)
  - Structure: A structure cannot be duplicated. ~(1000, 1000, 1000)

## Editor

## Marketplace
Players may not always be willing to design every object, room, and vehicle they will use, or may wish to use the work of others.

Market credits will be used by the player as a currency to buy objects other players have created, and add them to their personal repertoire.

Market credits can be earned through the sale of objects.

Market credits can also be bought with money using Google Checkout. A substantial amount of credits are yielded, enough to be around a month's supply. The player's mileage may vary.

There will also be a small, daily government stipend that is automatically added to a player's account. This will encourage older players to pick their account up again if they lose interest, and help get back into the game.

People will be able to join an organization with a set common goal. They can also develop and sell their assembly.

## Environments
Each setting will have two different technological progressions, and a crowning achievement for either. Crowning achievements will be based on population goals (such as in SimCity) as well as evaluated goals (such as in SimTower).

In version 1.0 of this project, the following environments will be available to the player to construct their community.

  - Sprawling Suburbs - Demolish existing, aging tract housing in desperate need of the green architecture only you can provide.
    - Scenario Challenges: As the player expands construction horizontally, they will find sites such as industrial complexes that will require remediation, else your environmental score drops. This will necessitate the development of new technologies that are unlocked only as you expand and meet goals.
    - Crowning Achievement: Botanic Gardens (organic), or Cathedral (minerals)

  - Ocean Platform (Seastead) - Assemble ocean platforms that are either mobile (benefiting tourism) or stationary (benefiting industry).
    - Scenario Challenges: Being based on the sea, it will be expensive to import materials, as well as having to build certain support structures as tethers to limit movement, or systems to promote movement.
    - Crowning Achievement: Space Elevator (stationary) or Airport (mobile)

  - Biosphere Enclosure - An enclosed habitat for natural remediation within a nuclear crater.
    - Scenario Challenges: Nuclear remediation, and create and nurture wildlife.
    - Crowning Achievement: Fully-Enclosed Wildlife Sanctuary

## Economy
  - Desirability - The higher you build your tower, a modifier comes into play for height.

## Ecosystem
  - Carbon Sequestration and Environmental Remediation
  - Clean & Renewable Energy Economic Directive (CREED)
  - Renewable Energy -- Many varieties of solar power can provide heating and electricity.
  - Renewable Materials

## Resources
  - Surrounding tower area will can be 'zoned' for production of resources. Resources include:
    - Algae (on water or in ponds) - Produces organic raw materials such as hydrocarbons and polymers.
    - Garbage & E-Waste imported from other regions to be decomposed into component materials and reused in construction
    - Processing of surrounding mineral features through various methods, including automatic low-impact drilling; also, thermal vents, when located on the ocean
    - Roads and other zone infrastructure automatically constructed; the player needs to concern themselves only with zoning-- what's built. Some structures enhance the output of others, such as a source of carbon that can be piped to an algae farm.

## Population
A simulated population will have various statistics that can be monitored on an individual basis, as well as in a demographic overview.

As in the game Tropico, simulated individuals will have certain ideological priorities. Individuals will be attracted to certain aspects of your tower. A list of some of these ideologies:

  - Environment - Democracy, Terraforming/Remediation, and Conservation are emphasized
  - Production - Communism, Manufacturing, and Productivity are emphasized
  - Commerce - Capitalism, Tourism, and Efficiency are emphasized

None of these ideologies conflict, and can be implemented in various combinations. while others compliment each other. It is possible to have a combination of socialized services in a capital-based system established with democratic organizational responsiveness. It is possible to remediate the surrounding environment into parks for tourists, and produce products for those tourists. It is possible to produce as much as is necessary for the population, while not making excess, and do this in an optimized manner.

Of course, it may be desirous to focus on only one set of ideologies to make a more focused tower, which, in the same vein as SimCity Societies, will develop its own character, including that of graphics sprites as well as the appearance of individuals.

There is no global setting for these ideologies. Instead, they are governed by the player's actions in construction.

## Social Gameplay
The player begins the game by creating an Engineer from the headquarters of the Edifice.

Players will have the choice of starting locations. Initially players will only be able to play on land, however, they can choose whether they want to be further away from other players, thus benefiting industry & expansion, or choose to form a more social aspect to benefit commerce & cooperation.
