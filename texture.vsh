precision mediump float;

attribute vec2 aVertex;
uniform mat3 uViewMatrix;
uniform vec2 uOffset;
uniform vec2 uSize;
varying vec2 vPos;
varying vec2 vTexture;

void main() {
	vTexture = aVertex;
	vec2 v = aVertex * uSize + uOffset;
	gl_Position = vec4(uViewMatrix * vec3(v, 1.), 1.);
	vPos = v;
}