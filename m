From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Let's Not Destroy the World in 2038
Date: Wed, 23 Dec 2015 14:16:27 -0500
Message-ID: <20151223191627.GA27953@ultraspiritum.redhat.com>
References: <20151222201039.GA24590@ultraspiritum.redhat.com>
 <CAJ4mKGbmA=gpagHLa23TKEVDsqdJGitv+1GA51QL3PST3a-5UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48134 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647AbbLWTQ2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Dec 2015 14:16:28 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 568C58EA39
	for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 19:16:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbmA=gpagHLa23TKEVDsqdJGitv+1GA51QL3PST3a-5UA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/12/2015, Gregory Farnum wrote:
[snip]
> So I think we're stuck with creating a new utime_t and incrementing
> the struct_v on everything that contains them. :/
[snip]
> We'll also then need the full feature bit system to make
> sure we send the old encoding to clients which don't understand the
> new one, and to prevent a mid-upgrade cluster from writing data on a
> new node that gets moved to a new node which doesn't understand it.

That is my understanding. I have the impression that network communication
get feature bits for the other nodes and on-disk structures are explicitly
versioned. If I'm mistaken, please hurl corrections at me.

> Given that utime_t occurs in a lot of places, and really can't change
> *again* after this, we probably shouldn't set up the new version with
> versioned encoding?

You're overly pessimistic. I'm hoping our post-human descendents store
their unfathomably alien, reconstructed minds in some galaxy spanning
descendent of Ceph and need more than a 64-bit second count.

However, I agree that the time value itself should not have an encoded
version tag.

To my intuition, the best way forward would be to:

(1) Add non-defaulted feature parameters on encode/decode of utime_t and
    ceph::real_time. This will break everything that uses them.

(2) Add explicit encode_old/encode_new functions. that way when we KNOW whi=
ch
    one we want at compile time we don't have to pay for a runtime check.

(3) When we have feature bits, pass them in.

(4) When we have a version, bump it. For new versions, explicitly call
    encode_new. When we know we want old, call old.

(5) If there are classes that we encode that have neither feature bits nor
    versioning available, see what uses them and act accordingly. Hopefully=
 the
    special cases will be few.

Does that seem reasonable?

I thank you.

And all hypothetical post-huamn Ceph users thank you.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWevMCXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jxbsIAK9kwQBDZneCEi68EjviEZh5
CSH96ZNIN612KEKoHQwramCMmS4GmN0sVzc5MglWe9db/0FuXD/eALJc6Ejz2T1K
Vgfm/uK1Uhmi09365JDYX27/emWnvhOn/H3bPZoZWNZ/wSduxeupsq+CSZHKbKvi
DL2JwCPwluigbgLNnGKAo7zYv8icsAOEgz16coOolg/ab/XByWlInv5DW7bqYwmp
UbJw/aDP/nk0FDB/wkTXA7guZbMiriB3aCWuTLVZJlazisv/Ruh1H4lhomamRB7A
gSu9ljj8BOlCGJir7cb6/eX060rIZ0+L+Hi8NEDgG7tey3Kbr4ecN+bBLI8TbCA=
=hztC
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
