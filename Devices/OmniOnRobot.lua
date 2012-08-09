omni = Manipulators.Sensable.PhantomOmni{
	forces = true,
	scale = 5.0 -- default is 20
}

remote = VRPNRemoteBase(omni, 0, 0, "ErrorCommand@localhost")

-- you can run the following command (and similar ones) to change the computer-side gain at runtime.
remote.gain = 1

addManipulator(remote)