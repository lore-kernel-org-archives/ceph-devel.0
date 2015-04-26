From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Script to extract backports log
Date: Sun, 26 Apr 2015 21:52:08 +0530
Message-ID: <87k2wy7tcf.fsf@gmail.com>
References: <CAHJ4zokWQ0T5RTMvToTgS_YZxPgQV11XTxKGaUX+gnzj5u1B0g@mail.gmail.com> <55184827.1090603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36361 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbDZQYG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 12:24:06 -0400
Received: by pabsx10 with SMTP id sx10so102823027pab.3
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 09:24:05 -0700 (PDT)
In-reply-to: <55184827.1090603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Alistair Israel <aisrael@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi
Loic Dachary writes:

> Hi Alistair,
>
> On 29/03/2015 19:27, Alistair Israel wrote:
>> Hi, Lo=C3=AFc.
>>=20
>> Well, got some 'quality' coding time in over the weekend and managed
>> to hack this out:
>> https://gist.github.com/aisrael/b2b78d9dfdd176a232b9

I managed to hack this a little to cross reference the issue id from
the merge commits and pulling the tracker urls using the github
apis. This was based on the assumption that for backports we follow a
certain discipline wrt to pull requests where the corresponding issue is
either mentioned as a part of commit message or as a comment on the pull
request

https://gist.github.com/theanalyst/a0932d863a8f4b0d1b98

It is still not perfect, but kind of helped me cut down on the manual
work of tracking down issue urls when not mentioned in the commit
message.
>>=20
>> You'll need GitPython (pip install gitpython). I managed to get
>> hyperlinks to issues, to the commits themselves, and even snuck in the
>> names of the people who've signed off on the commit.
>
> It's going to be helpful to start with the release notes but it will need=
 manual editing.
>
>>=20
>> What I can't figure out is how to get the simple component or module
>> name. For example, from how to get from "common/buffer.cc" (#6003) to
>> "buffer".
>>=20
>
> I don't think it can be done automatically.
>
>> Also, using a related issue and commit, how to combine two related
>> ones. For example, #6614 is related to #6003, and in the release notes
>> both are listed as a single item.
>
> One idea would be to group commits that are in the same branch together ?=
 When a merge is found, git log xxx^1..xxx^2 will list the commits that bel=
ong to the branch that has been merged. All commits in this branch presumab=
ly relate to the same topic.
>
>> Finally, do you think I should exclude commits starting with "qa:" or
>> "test/...:"?
>
> Yes, they are not relevant ;-)
>
> I included your snippet in the HOWTO write the release notes at http://tr=
acker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_notes wh=
ich is linked from http://tracker.ceph.com/projects/ceph-releases/wiki/HOWT=
O.
>

Cheers
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVPRC7AAoJEPnwZB8bZe1ftB0IAJyx8/YwALHEeS67v7aZYrC5
IXRRpQ+21hDNI0czdTPLiaC79JBxVt3VBsWYTLOomjmF0Rbpg4t5VIB5NZYZ0z8R
sPfmYPW6QT4UfqP4Q7mzcg41U+fBofrMBZXvspDXMRpNe7MbW3TS7AIggiv0zpUS
4AJr/IPaPYcxw9UZK1eit8VpA7rmWdY/e82VmlIgxpomEq2r/K/8/gm6yUn2eeZE
BL54zBysk26uTOaOZzQQ5X/wKoPonHSi2i/Y9l5hNSR54XTyhssr4iwJCeAU/i5Z
+irOlBznBBG+rQ2BGYt7WF1cRmstRrUe0ULCTqF1nE1RQflFAuEa2jqXrgPtojU=
=SSUN
-----END PGP SIGNATURE-----
--=-=-=--
