omni = Manipulators.Sensable.PhantomOmni{
	forces = true,
	scale = 5.0 -- default is 20
}

remote = VRPNRemoteBase(omni, 0, 0, "ErrorCommand@localhost")


addManipulator(remote)