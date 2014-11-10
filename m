From: Loic Dachary <loic@dachary.org>
Subject: Re: Pull requests : speed up the reviews
Date: Mon, 10 Nov 2014 20:50:55 +0100
Message-ID: <5461171F.8080401@dachary.org>
References: <545E53B5.3070600@dachary.org> <CAC6JEv_xbv54VoFfU+6rOKS7ytR7TbzJM3NZSk_sVKjpDEyQFA@mail.gmail.com> <alpine.DEB.2.00.1411101116110.24475@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rmeu1MUjC3dHcbQATF7KBqGpOW5tC8FuG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34443 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750923AbaKJTu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 14:50:58 -0500
In-Reply-To: <alpine.DEB.2.00.1411101116110.24475@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rmeu1MUjC3dHcbQATF7KBqGpOW5tC8FuG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> On Mon, 10 Nov 2014, Gregory Farnum wrote:
>> I suppose one way of handling this might be to ask everybody to
>> dedicate a small amount of time to reviews (as you suggest), but to
>> emphasize PR management as much as doing the actual review.
>>
>> 1) If you don't have assigned PRs, look at the unassigned PRs from
>> oldest to newest, and based on the target area assign it to the person=

>> you think most appropriate.after doing basic due diligence for issues
>> that you can handle (ie, the feature is something you don't know is
>> inappropriate; skimming the code doesn't make you cry; etc)
>>
>> 2) Manage any reviews assigned to you:
>>   2a) if you're the wrong target, assign it to somebody more appropria=
te
>>   2b) If you're the right target but are trying to get somebody else
>> acquainted with the code base, maybe assign it to them
>>   2c) assign priorities based on importance and age
>>
>> 3) review PRs in appropriate order at the level they deserve, and then=

>> either merge or assign it back to the author

I'll do as you suggest.

>> In particular, this clearly assigns responsibility for a PR to an
>> individual. It lets people offload as necessary, and gives feedback to=

>> contributors quickly even if that feedback is just "we appreciate your=

>> submission and it is in somebody's queue". It lets people contribute
>> to the PR process even if there isn't something they feel qualified to=

>> review directly. And it doesn't emphasize the time spent reviewing so
>> much as the act of moving a PR through the stages of merging. (A
>> 15-minute timebox might sound great, but trust me we have lots of PRs
>> that would never make it into the code base if they were done in
>> 15-minute chunks.)

I see what you mean. However there are few pull requests of that kind in =
the queue, or am I understimating most of them ?

>> Obviously this is also not a very formal process, but I think maybe if=

>> we start approaching things this way it will help move stuff through
>> the pipeline faster. Based on Sage's sudden enthusiasm for assigning
>> PR owners I think he might agree...?

+1

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--rmeu1MUjC3dHcbQATF7KBqGpOW5tC8FuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRhFx8ACgkQ8dLMyEl6F20QKwCgopUWLtg+0sMsPdJE2lb/zme1
QRsAn3HB9H4R4k1xbLwMRo97rF2KT+i3
=JTwO
-----END PGP SIGNATURE-----

--rmeu1MUjC3dHcbQATF7KBqGpOW5tC8FuG--
