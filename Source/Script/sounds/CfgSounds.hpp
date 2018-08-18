#define SOUND_CLASS(X,Y)	class X { \
	sound[] = {Y, 1, 1}; \
	name = ""; \
	titles[] = {0, ""}; \
}

class CfgSounds
{
	sounds[] = {};
	SOUND_CLASS(open_bolt,"sounds\BoltOpen.ogg");
	SOUND_CLASS(pull_bolt,"sounds\BoltPull.ogg");
	SOUND_CLASS(attach_mag,"sounds\MagAttach.ogg");
	SOUND_CLASS(detach_mag,"sounds\MagDetach.ogg");
	SOUND_CLASS(clear_chamber,"sounds\Fixing.ogg");
	SOUND_CLASS(remove_case,"sounds\Fixing.ogg");
	SOUND_CLASS(drop_mag,"sounds\MagDrop.ogg");
};