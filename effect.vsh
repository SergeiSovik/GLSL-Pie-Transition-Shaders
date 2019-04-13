precision mediump float;

attribute vec2 aVertex;
uniform mat3 uViewMatrix;
uniform vec2 uOffset;
uniform vec2 uSize;
varying vec2 vPos;
varying vec2 vTexture;
varying vec2 vSize;
varying float vScale;

void main() {
	vSize = uSize;
	vTexture = aVertex;
	vec2 v = aVertex * uSize;
	gl_Position = vec4(uViewMatrix * vec3(v + uOffset, 1.), 1.);
	vPos = v;
	vScale = log2(vSize.x);
}
