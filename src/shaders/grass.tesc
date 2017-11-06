#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
// https://stackoverflow.com/questions/20726441/passing-data-through-tessellation-shaders-to-the-fragment-shader
layout(location = 0) in vec4 tesc_v1[];
layout(location = 1) in vec4 tesc_v2[];
layout(location = 2) in vec4 tesc_up[];
layout(location = 3) in vec4 tesc_bitangent[];
layout(location = 4) in vec4 tesc_color[];

layout(location = 0) patch out vec4 tese_v1;
layout(location = 1) patch out vec4 tese_v2;
layout(location = 2) patch out vec4 tese_up;
layout(location = 3) patch out vec4 tese_bitangent;
layout(location = 4) patch out vec4 tese_color;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	tese_v1 = tesc_v1[gl_InvocationID];
	tese_v2 = tesc_v2[gl_InvocationID];
	tese_up = tesc_up[gl_InvocationID];
	tese_color = tesc_color[gl_InvocationID];
	//tese_orientationAndWidth = tesc_orientationAndWidth[gl_InvocationID];
	tese_bitangent = tesc_bitangent[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0; // 1 horizontal slice
    gl_TessLevelInner[1] = 4.0; // 4 vertical slices
    gl_TessLevelOuter[0] = 4.0; // left edge: 4 slices
    gl_TessLevelOuter[1] = 1.0; // top edge: 1 slice
    gl_TessLevelOuter[2] = 4.0; // right edge: 4 slices
    gl_TessLevelOuter[3] = 1.0; // bottom edge: 1 slices
}
