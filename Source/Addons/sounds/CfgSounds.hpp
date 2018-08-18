#define SOUND_CLASS(X,Y)	class X { \
	sound[] = {Y, 1, 1}; \
	name = ""; \
	titles[] = {0, ""}; \
}

class CfgSounds
{
	sounds[] = {};
	SOUND_CLASS(open_bolt,"\dzn_EJAM\sounds\BoltOpen.ogg");
	SOUND_CLASS(pull_bolt,"\dzn_EJAM\sounds\BoltPull.ogg");
	SOUND_CLASS(attach_mag,"\dzn_EJAM\sounds\MagAttach.ogg");
	SOUND_CLASS(detach_mag,"\dzn_EJAM\sounds\MagDetach.ogg");
	SOUND_CLASS(clear_chamber,"\dzn_EJAM\sounds\Fixing.ogg");
	SOUND_CLASS(remove_case,"\dzn_EJAM\sounds\Fixing.ogg");
	SOUND_CLASS(drop_mag,"\dzn_EJAM\sounds\MagDrop.ogg");
};