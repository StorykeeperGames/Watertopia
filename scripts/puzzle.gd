extends Node

@onready var door: StaticBody3D = $door

@onready var switch1: StaticBody3D = $switch1
@onready var switch2: StaticBody3D = $switch2
@onready var switch3: StaticBody3D = $switch3
@onready var switch4: StaticBody3D = $switch4
@onready var switch5: StaticBody3D = $switch5

@onready var pipe1: CSGMesh3D = $Pipe1
@onready var pipe2: CSGMesh3D = $Pipe2
@onready var pipe3: CSGMesh3D = $Pipe3
@onready var pipe4: CSGMesh3D = $Pipe4
@onready var pipe5: CSGMesh3D = $Pipe5

@onready var pipe1_engaged: bool = false
@onready var pipe2_engaged: bool = true
@onready var pipe3_engaged: bool = false
@onready var pipe4_engaged: bool = true
@onready var pipe5_engaged: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if switch1:
		switch1.interact_triggered.connect(_on_interact_triggered)
	if switch2:
		switch2.interact_triggered.connect(_on_interact_triggered)
	if switch3:
		switch3.interact_triggered.connect(_on_interact_triggered)
	if switch4:
		switch4.interact_triggered.connect(_on_interact_triggered)
	if switch5:
		switch5.interact_triggered.connect(_on_interact_triggered)
	if pipe1:
		pipe1.pipe_toggled.connect(_on_pipe_toggle)
	if pipe2:
		pipe2.pipe_toggled.connect(_on_pipe_toggle)
	if pipe3:
		pipe3.pipe_toggled.connect(_on_pipe_toggle)
	if pipe4:
		pipe4.pipe_toggled.connect(_on_pipe_toggle)
	if pipe5:
		pipe5.pipe_toggled.connect(_on_pipe_toggle)
	
	_initiate_pipe_states()


func _on_interact_triggered(message: String, switchName: StringName) -> void:
	print("Puzzle received signal! Message: ", message, switchName)
	if switchName == "switch1":
		if pipe1:
			pipe1.Toggle()
			pipe2.Toggle()
	if switchName == "switch2":
		if pipe2:
			pipe1.Toggle()
			pipe2.Toggle()
			pipe3.Toggle()
	if switchName == "switch3":
		if pipe3:
			pipe2.Toggle()
			pipe3.Toggle()
			pipe4.Toggle()
	if switchName == "switch4":
		if pipe4:
			pipe3.Toggle()
			pipe4.Toggle()
			pipe5.Toggle()
	if switchName == "switch5":
		if pipe5:
			pipe4.Toggle()
			pipe5.Toggle()
			
	print("pipes engaged:")
	print(pipe1_engaged)
	print(pipe2_engaged)
	print(pipe3_engaged)
	print(pipe4_engaged)
	print(pipe5_engaged)
	
	if pipe1_engaged and pipe2_engaged and pipe3_engaged and pipe4_engaged and pipe5_engaged:
		print("Game won!")
		
		if switch1:
			switch1.interact_triggered.disconnect(_on_interact_triggered)
		if switch2:
			switch2.interact_triggered.disconnect(_on_interact_triggered)
		if switch3:
			switch3.interact_triggered.disconnect(_on_interact_triggered)
		if switch4:
			switch4.interact_triggered.disconnect(_on_interact_triggered)
		if switch5:
			switch5.interact_triggered.disconnect(_on_interact_triggered)
			
		if door:
			door.Open()

func _on_pipe_toggle(pipeName: StringName, engaged: bool) -> void:
	print("toggling ", pipeName)
	if pipeName == "Pipe1":
		#pipe1.Toggle()
		pipe1_engaged = engaged
	elif pipeName == "Pipe2":
		#pipe2.Toggle()
		pipe2_engaged = engaged
	elif pipeName == "Pipe3":
		#pipe3.Toggle()
		pipe3_engaged = engaged
	elif pipeName == "Pipe4":
		#pipe4.Toggle()
		pipe4_engaged = engaged
	elif pipeName == "Pipe5":
		#pipe5.Toggle()
		pipe5_engaged = engaged

func _initiate_pipe_states() -> void:
	if pipe1:
		pipe1.Initialize(pipe1_engaged)
	if pipe2:
		pipe2.Initialize(pipe2_engaged)
	if pipe3:
		pipe3.Initialize(pipe3_engaged)
	if pipe4:
		pipe4.Initialize(pipe4_engaged)
	if pipe5:
		pipe5.Initialize(pipe5_engaged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
