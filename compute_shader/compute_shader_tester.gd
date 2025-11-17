extends Node3D


func conpute_the_shatder() -> void:
	var rd : RenderingDevice = RenderingServer.create_local_rendering_device()
	
	var shader_file : RDShaderFile = load("res://compute_shader/compute_example.glsl")
	var shader_spirv: RDShaderSPIRV = shader_file.get_spirv()
	var shader : RID = rd.shader_create_from_spirv(shader_spirv)
	
	var input : PackedFloat32Array = PackedFloat32Array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
	var input_bytes : PackedByteArray = input.to_byte_array()
	var buffer := rd.storage_buffer_create(input_bytes.size(), input_bytes)
	
	var uniform : RDUniform = RDUniform.new()
	uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_STORAGE_BUFFER
	uniform.binding = 0
	uniform.add_id(buffer)
	var uniform_set : RID = rd.uniform_set_create([uniform], shader, 0)
	
	
	var pipeline : RID = rd.compute_pipeline_create(shader)
	var compute_list := rd.compute_list_begin()
	rd.compute_list_bind_compute_pipeline(compute_list, pipeline)
	rd.compute_list_bind_uniform_set(compute_list, uniform_set, 0)
	rd.compute_list_dispatch(compute_list, 5, 1, 1)
	rd.compute_list_end()
	
	rd.submit()
	rd.sync()
	
	var output_bytes : PackedByteArray = rd.buffer_get_data(buffer)
	var output : PackedFloat32Array = output_bytes.to_float32_array()
	print("Input: ", input)
	print("Output: ", output)

func _ready() -> void:
	call_deferred("conpute_the_shatder")
