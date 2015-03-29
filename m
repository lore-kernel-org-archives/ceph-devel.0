From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Status update for the last Giant release 0.87.2
Date: Sun, 29 Mar 2015 10:12:11 +0530
Message-ID: <87y4mg2z4s.fsf@gmail.com>
References: <55168C18.9060307@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36112 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbC2En6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 00:43:58 -0400
Received: by padcy3 with SMTP id cy3so134687033pad.3
        for <ceph-devel@vger.kernel.org>; Sat, 28 Mar 2015 21:43:58 -0700 (PDT)
In-reply-to: <55168C18.9060307@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Loic Dachary writes:

> Hi Abhishek,
>
> Looking at the last two issues marked as needing backport to giant:
>
> http://tracker.ceph.com/projects/ceph/issues?query_id=3D68
>
> (this link is at the top of http://tracker.ceph.com/projects/ceph-release=
s/wiki/HOWTO) I'm not sure what to do about http://tracker.ceph.com/issues/=
10643. The problem is that it consistently shows up when testing upgrades t=
hat involve giant. We want to be sure Giant can be upgraded to Hammer, ther=
efore we need to keep testing the upgrades at least for a month or two afte=
r Hammer is released to catch border cases. I think issue 10643 needs to be=
 fixed and included in 0.87.2 so that we can have clean upgrade tests, othe=
rwise it will mean more work for people watching over the upgrade suites (I=
 mean Yuri here ;-). And wif 10643 is included we can squeeze http://tracke=
r.ceph.com/issues/10153 in as well, I think.
>
> Once this is dealt with and you're done with http://tracker.ceph.com/issu=
es/11259 that you found when running the rgw suite at http://tracker.ceph.c=
om/issues/11153#rgw, 0.87.2 should be good, from our point of view (the poi=
nt of view of backporters) and we can move to the "asking approval" step of=
 the workflow ( http://tracker.ceph.com/issues/11153#Workflow ).=20

For this issue, I haven't been able to find out the cause yet, there
seemed to be only one patch that landed in giant related to quotas,
however the test seemed to have failed even before that. I've updated
the tracker with this.
>
> What do you think ?

Overall sounds good.=20
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVF4KtAAoJEPnwZB8bZe1foeUH/itfWqO6cgxa4mXEiqKpFuEC
i872bxs2kkl6yaV9/Bbhauwi1vL90FTV7ZCbMgdcX+rbLMztNBXvzABtAtVzQldt
FlcvAZlk+J8zDOn0DtNctUj4iqer/jYI+QWcc56v+4dRsVACcOqCmtikcjUw8zbD
40oXFr3Fr2qN6OaEWWOB5pFiF6N7qAflnzGbK+yWfvCjNjJzuc3k/9y4EIuUJc4M
e/vEQ1Dv+Wi+y2lUNJN7sxiun3hc3eb6M45Hgsx9ROnRSYRhfGibzrweyQzTb9p5
9LTfV7E3hoOmY8wHnTOMm1Wi5SaVhkG3cEhYw1eiGKyUKvQ9wo6rioLeo/TOLlI=
=OFE9
-----END PGP SIGNATURE-----
--=-=-=--
