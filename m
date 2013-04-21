From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure coding (sorry)
Date: Sun, 21 Apr 2013 04:37:28 +0200
Message-ID: <517350E8.1080600@dachary.org>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com> <alpine.DEB.2.00.1304181425070.10005@cobra.newdream.net> <14614113-DA4A-4091-904A-5D0A8DA39245@asgaard.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD9C3983C68FBC014473E2384"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47823 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3DUChe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Apr 2013 22:37:34 -0400
In-Reply-To: <14614113-DA4A-4091-904A-5D0A8DA39245@asgaard.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher LILJENSTOLPE <cdl@asgaard.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9C3983C68FBC014473E2384
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

I would like to offer my help on this blueprint. In

http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as=
_a_storage_backend

you wrote=20

"At this time, Annai is more than willing to help with this, but we don't=
 have the resources (including ceph coders) to materially contribute code=
=2E "

and I can work on the coding part.

Cheers

On 04/19/2013 02:47 AM, Christopher LILJENSTOLPE wrote:
> Supposedly, on 2013-Apr-18, at 14.26 PDT(-0700), someone claiming to be=
 Sage Weil scribed:
>=20
>> On Thu, 18 Apr 2013, Noah Watkins wrote:
>>> On Apr 18, 2013, at 2:08 PM, Josh Durgin <josh.durgin@inktank.com> wr=
ote:
>>>
>>>> I talked to some folks interested in doing a more limited form of th=
is
>>>> yesterday. They started a blueprint [1]. One of their ideas was to h=
ave
>>>> erasure coding done by a separate process (or thread perhaps). It wo=
uld
>>>> use erasure coding on an object and then use librados to store the
>>>> rasure-encoded pieces in a separate pool, and finally leave a marker=
 in
>>>> place of the original object in the first pool.
>>>
>>> This sounds at a high-level similar to work out of Microsoft:
>>>
>>> https://www.usenix.org/system/files/conference/atc12/atc12-final181_0=
=2Epdf
>>>
>>> The basic idea is to replicate first, then erasure code in the backgr=
ound.
>>
>> FWIW, I think a useful (and generic) concept to add to rados would be =
a
>> redirect symlink sort of thing that says "oh, this object is over ther=
e is
>> that other pool", such that client requests will be transparently
>> redirected or proxied.  This will enable generic tiering type operatio=
ns,
>> and probably simplify/enable migration without a lot of additional
>> complexity on the client side.
>=20
> More to come, but I'm starting to think of a union mount of a fuse "re-=
directing" overlay.  The quick idea.
>=20
> On the "hot" pool, the OSD's would write to the host FS as usual.  Howe=
ver, that FS is actually a light-weight fuse (at least for prototype) fs =
that passes almost everything right down to the file system.  As the OSD =
hits a capacity HWM, a watcher (asynchronous process), starts "evicting" =
objects from the OSD.  It does that by using a modified ceph client that =
calls zfec and uses CRUSH to place the resulting shards in the "cool" poo=
l.  Once those are committed, it replaces the object in the "hot" OSD wit=
h a special token. This is repeated until a LWM is reached.  When the OSD=
 gets a read request for that object, when the fuse shim sees the token, =
it knows to actually do a modified client fetch from the "cool" pool.  It=
 returns the resulting object to the original requester and (potentially)=
 stores the object back in the "hot" OSD (if you want a cache-like perfor=
mance), replacing the token.  If necessary, some other object may get, in=
 turn, evicted if the HWM is again breached.
>=20
> We would also need to modify the repair mechanism for the deep scrub in=
 the "cool" pool to account for the repair being a re-constitution of an =
invalid shard, rather than a copy (as there is only one copy of a given s=
hard).
>=20
> I'll get a bit more of a write-up today, hopefully, in the wiki.
>=20
> 	Christopher
>=20
>>
>> sage
>=20
>=20
> --
> =E6=9D=8E=E6=9F=AF=E7=9D=BF
> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> Check my calendar availability: https://tungle.me/cdl

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--------------enigD9C3983C68FBC014473E2384
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlFzUOoACgkQ8dLMyEl6F234LACfRcYhIiR58uAqj+6FsJ+lPxdQ
0wMAoKGd4zPJtgSOIFcGHCdoAeAAwfVF
=o+Sm
-----END PGP SIGNATURE-----

--------------enigD9C3983C68FBC014473E2384--
