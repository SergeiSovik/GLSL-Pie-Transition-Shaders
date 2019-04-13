precision highp float;

const float PI05 = 1.5707963267948966192313216916398;
const float PI = 3.1415926535897932384626433832795;
const float PI2 = 6.283185307179586476925286766559;

uniform sampler2D uTexture;
varying vec2 vTexture;
varying vec2 vPos;
varying vec2 vSize;
varying float vScale;

uniform vec2 uZoom;
uniform vec2 uCenter;
uniform float uRadius;
uniform float uPower;
uniform float uAngle;

void main() {
	float dist;
	float angle;
	float p = uPower * 2.;

	vec2 o1 = vec2((vPos.x - vSize.x) / vSize.x, (vPos.y * 2. - vSize.y) / vSize.y);

	vec2 map;

	float r = uRadius * uPower;
	vec2 o = abs(vPos - uCenter);
	vec2 range1 = ((uRadius - vSize * .5) * uPower + vSize * .5);
	if ((o.x > range1.x) || (o.y > range1.y)) discard;

	vec2 range2 = range1 - r;
    if ((o.x > range2.x) && (o.y > range2.y)) {
    	dist = length(o - range2);
    	if (dist > r) discard;
	}

	if (p < 1.) {
		dist = length(o1);
	    angle = mod(PI2 - atan(o1.y, o1.x), PI2);
	    angle = ((angle - PI) * 2. + PI);
	    map = (vec2(1. - dist, angle / PI2) - vTexture) * p + vTexture;
    } else {
		vec2 o2 = (vPos - uCenter) / uRadius;
		vec2 o3 = (o2 - o1) * (p - 1.) + o1;

    	dist = length(o3);
    	angle = mod(atan(-o3.y, o3.x) + uAngle * (p - 1.), PI2);
		angle = ((angle - PI) * (3. - p) + PI);
    	map = vec2(1. - dist, angle / PI2);
    }

    map.x = map.x * uZoom[1] + uZoom[0];

	gl_FragColor = texture2D(uTexture, map);
}
