# Face

Class for 2-faces to use as facets of polyhedrons.
Also called a "polygonal face".


## Installation

```sh
npm install --save @datatypes/face
```


## Usage

```js
import Point from '@datatypes/point'
import Face from '@datatypes/face'

const vertices = [
	new Point(1, 0, 0),
	new Point(0, 1, 0),
	new Point(0, 0, 1)
]

const face = new Face(vertices)
	.calculateNormal()
	.calculateSurfaceArea()

console.log(face.toObject())
```

Output:

```shell
{
	vertices: [
		{x: 1, y: 0, z: 0},
		{x: 0, y: 1, z: 0},
		{x: 0, y: 0, z: 1}
	],
	normal: {
		x: 0.5773502691896258,
		y: 0.5773502691896258,
		z: 0.5773502691896258
	},
	surfaceArea: 0.8660254037844386
}
```

For a more detailed listing of available features
check out [the tests](./test/main.coffee).
