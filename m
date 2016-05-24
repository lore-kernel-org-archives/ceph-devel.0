From: Loic Dachary <loic@dachary.org>
Subject: Re: parted behavior change between 3.1 and 3.2
Date: Wed, 25 May 2016 00:30:42 +0200
Message-ID: <5744D612.6050905@dachary.org>
References: <5742B42C.7050000@dachary.org>
 <5ba70630-84af-f7b6-802c-933b1a26f273@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60934 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbcEXWat (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2016 18:30:49 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 6F91A47A43F
	for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 00:30:47 +0200 (CEST)
In-Reply-To: <5ba70630-84af-f7b6-802c-933b1a26f273@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Phil Susi <psusi@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


Hi Phil,

On 24/05/2016 19:16, Phil Susi wrote:
> On 5/23/2016 3:41 AM, Loic Dachary wrote:
>> Hi Philip,
>>
>> In the context of the Ceph ( http://ceph.com/ ) project, I'm trying
>> to figure out why parted 3.2 fixes a problem that shows in 3.1 [1].
>> In a nutshell, calling partprobe sometime fails with "device busy"
>> with 3.1 and when using 3.2 that never happens (all things are the
>> same, only parted changes). I took a look at the commits in
>> http://git.savannah.gnu.org/cgit/parted.git/log/ but I didn't see a
>> commit that would explain such a behavior change.
>>
>> Any pointer or idea you may have would be greatly appreciated :-)
>=20
> An strace would help, but if I had to guess, one significant change
> between 3.1 and 3.2 was the addition of the ability to resize mounted
> partitions, so it could be that partprobe is adjusting the size of a
> changed partition, and it used to not be able to do that if it is mou=
nted.
>=20

That's an interesting lead, I'll double check if that could be the caus=
e. Thanks very much for the hint !

I'll let you know how it evolves.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
