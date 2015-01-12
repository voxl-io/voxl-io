voxl.io
=======

An accessible means of visually modeling processes and systems.

# Purpose
voxl.io aims to provide a virtual platform for easily and interactively modeling complex ideas and concepts about real-world processes and dynamic systems. To do this, voxels, a standard unit of volume, is used to approximate the state of substances.

# Technologies
Voxels are used to represent discrete volumes with quantifiable properties. Each voxel is kept as a document in a MongoDB collection, easily referenced by its Cartesian coordinates, as well as its relative scale, in addition to the world and user it belongs to.

Meteor is used to rapidly develop an interactive online system.

Three.js was chosen, not for performance, but ease-of-use.

Various voxel-oriented MIT-licensed NPM packages related to the [Voxel.js](http://voxeljs.com/) project may also be referred to.

# Voxels
Voxels are kept as documents, and rendered in Three.js. For example, to find a voxel document within a MongoDB document store, the following properties are needed:

  - User ID
  - World ID
  - Absolute, Origin-Normalized Cartesian Coordinates (`x, y, z`)
  - Relative World Scale

## Properties
  There is a discrete and constant dimension for volume at each level of scale. Volumes can be described in detail, and their properties averaged over the dimension of the next higher level of scale.

  - Substance
    - Collection of chemical references
  - Quantity
    - Density
    - Mass
  - State
    - State of Matter
    - Temperature

## Events
Events are propagated recursively outwards, expanding to neighboring voxels, radiating outwards until a threshold of diminished effect is reached.

  - Inverse Square Law
  - Contact events
    - Determine what happens when two voxels collide? Not speaking of Newtonian physics, but of the properties of both involved voxels.

# Components
A collection of related voxels that perform a task might be kept as a component. We seek to model component inputs and outputs from each component. A library of components can be kept and shared.
