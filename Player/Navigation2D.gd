extends Navigation2D


onready var navmap = $NavigationPolygonInstance


func set_navigation_polygon(navMeshList = []):
	navmap.get_navigation_polygon().clear_outlines()
	navmap.get_navigation_polygon().clear_polygons()
	
	for i in navMeshList:
		navmap.get_navigation_polygon().add_outline(i.polygon)

	navmap.get_navigation_polygon().make_polygons_from_outlines()
	navmap.enabled = false
	navmap.enabled = true
