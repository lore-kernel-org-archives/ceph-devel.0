From: NeilBrown <neilb@suse.de>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Wed, 30 Jul 2014 07:17:35 +1000
Message-ID: <20140730071735.21ab7ca6@notabene.brown>
References: <CANP1eJEVnH2w7t6r8g1ow07UNWRA8bPduwD-FezqCBKB_J_=XQ@mail.gmail.com>
	<CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
	<20140721164044.2845f3fd@notabene.brown>
	<29057.1406650354@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/eMpB/gnYZUA0ir5qD7Ft4GX"; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <29057.1406650354@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
List-Id: ceph-devel.vger.kernel.org

--Sig_/eMpB/gnYZUA0ir5qD7Ft4GX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2014 17:12:34 +0100 David Howells <dhowells@redhat.com> wrot=
e:

> Milosz Tanski <milosz@adfin.com> wrote:
>=20
> > That's the same thing exact fix I started testing on Saturday. I found =
that
> > there already is a wait_event_timeout (even without your recent changes=
). The
> > thing I'm not quite sure is what timeout it should use?
>=20
> That's probably something to make an external tuning knob for.
>=20
> David

Ugg.  External tuning knobs should be avoided wherever possible, and always
come with detailed instructions on how to tune them  </rant>

In this case I think it very nearly doesn't matter *at all* what value is
used.

If you set it a bit too high, then on the very very rare occasion that it
would currently deadlock, you get a longer-than-necessary wait.  So just ma=
ke
sure that is short enough that by the time the sysadmin notices and starts
looking for the problem, it will be gone.

And if you set it a bit too low, then it will loop around to find another
page to deal with before that one is finished being written out, and so may=
be
do a little bit more work than is needed (though it'll be needed eventually=
).

So the perfect number is somewhere between the typical response time for
storage, and the typical response time for the sys-admin.  Anywhere between
100ms and 10sec would do.  1 second is the geo-mean.

(sorry I didn't reply earlier - I missed you email somehow).

NeilBrown

--Sig_/eMpB/gnYZUA0ir5qD7Ft4GX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU9gPbznsnt1WYoG5AQK+5BAAtiEKeMmzXnjHGMCbzlhP7z9AgZ/HJ9PU
RnClbxR9JjrEaw5Sx42yIyQdpwkDUACztWaM04eyIziZIuf2C1Qz/RL2IM4ge7FD
JJ1KT0VaSIAVwOIibGdLURePW3dbTXmZEMf5/R4ciP7XjGeUuwrteExwkkUEf/0E
hsRalKRSDcTDXRlUKXpIrzhgo7SOwXK8aEtI+y/cAqeBIp9UH1FZwaxPZK3T2hc0
M/pmbuTx4FulPyZTMV65MBic4r5iu6yRl8+AMkosNypSqrT0SrPxUuH1VAjqYum+
XuNt5GYAyrpOp1v+64lnsIZ1+EtUDUsDYFW+c0rdJR0PA3OVvFpy3rgmE0umAGJn
SkcRrUATLk/NvNGDvMUGvX3s3D6AhjYE9qtRb493zs2ZTMxff8VUuG0HN0/ORQ7m
5VdURMWz06yleAjB3KT4l1Arcxo+vKz9WqAgBym4YYDO+BL+2h94OoJpLCK3wovw
N0wymywMiL0drmUamc79Ujpl41CfNzANdfCeGhtXfLW1PVVIBAIafwBBfUPm5M9h
0TU2EOQ/PtrkQhnuo1FpGdm8raumE4gg6kMhaLSAwOlAOQRaBmVfnjNoWV6fGUvp
yoUNO/3XOOawdIje89gghuBYExLraeSMmXuqFF1gzOhWhFUqFfyuJSlNaGGGU043
+5Y3277Ak+c=
=5nat
-----END PGP SIGNATURE-----

--Sig_/eMpB/gnYZUA0ir5qD7Ft4GX--
