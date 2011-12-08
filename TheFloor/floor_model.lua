-- Load a big flat object, that is fixed and not selectable,
-- as a physically-modeled floor so the parts have something to
-- fall on to when dropped.
theFloor = addObject{
	voxelsize = 0.05,
	position = {1.0, 0, -1.0},
	fixed = true,
	selectable = false,
	Transform{
		scale = 15.0,
		Model("models/floor/floor.osg")
	}
}
