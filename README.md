# GLSL-Pie-Transition-Shaders
OpenGL Shaders For Transition Effect Between RECT(W,H,StartX,RangeX) to PIE(X,Y,R,Angle)

![Example](PieZoomSlowmo.gif)

## Example Usage EnPie Shader
It translates Rectangle texture space to Pie space

```
void draw(float l, float t, float r, float b, int texture, float zoomStartX, float zoomRangeX, float pieX, float pieY, float pieRadius, float power, float angle, FloatBuffer buffer, float[] matrix) {
		glUseProgram(shader.program);

		glUniformMatrix3fv(uViewMatrix, 1, false, matrix, 0);
		glUniform2f(uOffset, l, t);

		float width = r - l;
		glUniform2f(uSize, width, b - t);

		float zoomStart = (zoomStartX - l) / width;
		float zoomRange = zoomRangeX / width;
		zoomStart = zoomStart * power;
		zoomRange = (1.f - zoomRange) * (1.f - power) + zoomRange;
		glUniform2f(uZoom, zoomStart, zoomRange);
		glUniform2f(uCenter, pieX - l, pieY - t);
		glUniform1f(uRadius, pieRadius);
		glUniform1f(uPower, power);
		glUniform1f(uAngle, angle);

		glActiveTexture(GL_TEXTURE0);
		glBindTexture(GL_TEXTURE_2D, texture);
		glUniform1i(uTexture, 0);

		glEnableVertexAttribArray(aVertex);
		glVertexAttribPointer(aVertex, 2, GL_FLOAT, false, 0, buffer);
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

		glBindTexture(GL_TEXTURE_2D, GL_NONE);
		glDisableVertexAttribArray(aVertex);
		glUseProgram(0);
}
```
## Example Usage DePie Shader
It translates Pie texture space to Rectangle space

```
void draw(float l, float t, float r, float b, int texture, float zoomStartX, float zoomRangeX, float pieX, float pieY, float pieRadius, float power, float angle, FloatBuffer buffer, float[] matrix) {
		glUseProgram(shader.program);

		glUniformMatrix3fv(uViewMatrix, 1, false, matrix, 0);
		glUniform2f(uOffset, l, t);

		float width = r - l;
		glUniform2f(uSize, width, b - t);

		float zoomStart = (zoomStartX - l) / width;
		float zoomRange = zoomRangeX / width;
		float enZoomStart = zoomStart * power;
		float enZoomRange = (1.f - zoomRange) * (1.f - power) + zoomRange;

		float x1 = (zoomStart - enZoomStart) / enZoomRange;
		float x2 = ((zoomStart + zoomRange) - enZoomStart) / enZoomRange;

		glUniform2f(uZoom, x1, x2);
		glUniform2f(uCenter, pieX - l, pieY - t);
		glUniform1f(uRadius, pieRadius);
		glUniform1f(uPower, power);
		glUniform1f(uAngle, angle);

		glActiveTexture(GL_TEXTURE0);
		glBindTexture(GL_TEXTURE_2D, texture);
		glUniform1i(uTexture, 0);

		glEnableVertexAttribArray(aVertex);
		glVertexAttribPointer(aVertex, 2, GL_FLOAT, false, 0, buffer);
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

		glBindTexture(GL_TEXTURE_2D, GL_NONE);
		glDisableVertexAttribArray(aVertex);
		glUseProgram(0);
}
```
