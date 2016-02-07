runTest = require 'ava'
clone = require 'clone'
Vector = require '@datatypes/vector'
Point = require '@datatypes/point'
Face = require '../index'

vertex1 = new Point 1, 0, 0
vertex2 = new Point 0, 1, 0
vertex3 = new Point 0, 0, 1
vertices = [vertex1, vertex2, vertex3]
normal = new Vector 0.5773502691896258, 0.5773502691896258, 0.5773502691896258


runTest 'Instantiates a new face', (test) ->
	face = new Face()
	test.same face.toObject(), {vertices: []}


runTest 'Instantiates a new face from an array of vertices', (test) ->
	face = Face.fromVertexArray clone vertices

	test.same(
		face.toObject(),
		{
			vertices: clone(vertices).map (vertex) -> vertex.toObject()
		}
	)


runTest 'Instantiates a new face from an plain javascript object', (test) ->
	face = Face.fromObject {
		vertices: clone vertices
		normal: clone normal
	}

	test.same(
		face.toObject(),
		{
			vertices: clone(vertices).map (vertex) -> vertex.toObject()
			normal: clone(normal).toObject()
		}
	)


runTest 'Creates a face by adding vertices', (test) ->
	face = new Face()
		.addVertex clone vertex1
		.addVertex clone vertex2
		.addVertex clone vertex3

	test.same face.toObject(), {
		vertices: clone(vertices).map (vertex) -> vertex.toObject()
	}


runTest 'Removes a vertex', (test) ->
	face = new Face clone vertices
		.removeVertex 1

	test.same face.toObject(), {
		vertices: clone vertices
			.filter (vertex, index) -> index isnt 1
			.map (vertex) -> vertex.toObject()
	}


runTest 'Calculate the normal', (test) ->
	face = Face
		.fromVertexArray clone vertices
		.calculateNormal()

	test.same face.toObject(), {
		vertices: clone(vertices).map (vertex) -> vertex.toObject()
		normal: clone(normal).toObject()
	}


runTest 'Get the normal', (test) ->
	normal = Face
		.fromVertexArray clone vertices
		.getNormal()
	test.same normal, clone normal


runTest 'Calculates surface area', (test) ->
	face = Face
		.fromVertexArray clone vertices
		.calculateSurfaceArea()

	test.same face.toObject(), {
		vertices: clone(vertices).map (vertex) -> vertex.toObject()
		surfaceArea: 0.8660254037844386
	}


runTest 'Get the surface area', (test) ->
	surfaceArea = Face
		.fromVertexArray clone vertices
		.getSurfaceArea()
	test.same surfaceArea, 0.8660254037844386


runTest 'Convert to JSON', (test) ->
	face = new Face clone(vertices), clone(normal)
	jsonString =
		'{"vertices": [
			{"x":1,"y":0,"z":0},
			{"x":0,"y":1,"z":0},
			{"x":0,"y":0,"z":1}
		],
		"normal": {
			"x":0.5773502691896258,
			"y":0.5773502691896258,
			"z":0.5773502691896258}
		}'
	test.same JSON.stringify(face), jsonString.replace(/\s/g, '')
