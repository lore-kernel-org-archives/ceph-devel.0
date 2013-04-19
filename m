From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 17:47:05 -0700
Message-ID: <14614113-DA4A-4091-904A-5D0A8DA39245@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com>
 <506B76E2-8814-45C8-8700-C4316E96FE30@inktank.com>
 <alpine.DEB.2.00.1304181425070.10005@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_7CB68A5F-0B73-4E63-AD1D-56461809C9BC_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.emailarray.com ([65.39.216.14]:61799 "EHLO
	smtp1.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967687Ab3DSArN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 20:47:13 -0400
In-Reply-To: <alpine.DEB.2.00.1304181425070.10005@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org, danm@annaisystems.com

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_7CB68A5F-0B73-4E63-AD1D-56461809C9BC_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-18, at 14.26 PDT(-0700), someone claiming to be S=
age Weil scribed:

> On Thu, 18 Apr 2013, Noah Watkins wrote:
>> On Apr 18, 2013, at 2:08 PM, Josh Durgin <josh.durgin@inktank.com> wro=
te:
>>
>>> I talked to some folks interested in doing a more limited form of thi=
s
>>> yesterday. They started a blueprint [1]. One of their ideas was to ha=
ve
>>> erasure coding done by a separate process (or thread perhaps). It wou=
ld
>>> use erasure coding on an object and then use librados to store the
>>> rasure-encoded pieces in a separate pool, and finally leave a marker =
in
>>> place of the original object in the first pool.
>>
>> This sounds at a high-level similar to work out of Microsoft:
>>
>> https://www.usenix.org/system/files/conference/atc12/atc12-final181_0.=
pdf
>>
>> The basic idea is to replicate first, then erasure code in the backgro=
und.
>
> FWIW, I think a useful (and generic) concept to add to rados would be a=

> redirect symlink sort of thing that says "oh, this object is over there=
 is
> that other pool", such that client requests will be transparently
> redirected or proxied.  This will enable generic tiering type operation=
s,
> and probably simplify/enable migration without a lot of additional
> complexity on the client side.

More to come, but I'm starting to think of a union mount of a fuse "re-di=
recting" overlay.  The quick idea.

On the "hot" pool, the OSD's would write to the host FS as usual.  Howeve=
r, that FS is actually a light-weight fuse (at least for prototype) fs th=
at passes almost everything right down to the file system.  As the OSD hi=
ts a capacity HWM, a watcher (asynchronous process), starts "evicting" ob=
jects from the OSD.  It does that by using a modified ceph client that ca=
lls zfec and uses CRUSH to place the resulting shards in the "cool" pool.=
  Once those are committed, it replaces the object in the "hot" OSD with =
a special token. This is repeated until a LWM is reached.  When the OSD g=
ets a read request for that object, when the fuse shim sees the token, it=
 knows to actually do a modified client fetch from the "cool" pool.  It r=
eturns the resulting object to the original requester and (potentially) s=
tores the object back in the "hot" OSD (if you want a cache-like performa=
nce), replacing the token.  If necessary, some other object may get, in t=
urn, evicted if the HWM is again breached.

We would also need to modify the repair mechanism for the deep scrub in t=
he "cool" pool to account for the repair being a re-constitution of an in=
valid shard, rather than a copy (as there is only one copy of a given sha=
rd).

I'll get a bit more of a write-up today, hopefully, in the wiki.

	Christopher

>
> sage


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_7CB68A5F-0B73-4E63-AD1D-56461809C9BC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRcJQJAAoJEGmx2Mt/+Iw/CogH/2yFqNXtjBOjut7HZQSs/c0E
fM8zBHt9okSZ4N1LYJ7L6USK6Ffv2uC8O1k3Y2Y9ZcdFy8iJzOUVfjcN4B3+FI8c
NAmrsZN+QvaF5O6GPyeP2wjKwe+cbzV5OahvEt6hB/ij0ZQINT19hE4LcFRwKxeX
KM7CBNcKu/tPREsG3kYeBRtMCSj30utKo8YH7clgK1jJnYXjV2Gk43GXNVAhJAwl
u4zBQiCJ128U9GXr83POmtBBQ7RriG5W6XwbUxJFmnb/94V8y3nmMYr1/vlDkfx5
rm6OWDG8Ih5WkxaCMSlqSa2LdRbf1gM3QAANp7yQ20VC6HGTL5ZMJtf++jNu8yc=
=jP6+
-----END PGP SIGNATURE-----

--=_MailMate_7CB68A5F-0B73-4E63-AD1D-56461809C9BC_=--
