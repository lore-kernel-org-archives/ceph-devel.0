From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-mds jewel backports leak
Date: Thu, 7 Jul 2016 13:52:49 +0200
Message-ID: <577E4291.1070700@dachary.org>
References: <577CE2B4.6010505@dachary.org>
 <CALe9h7fc55ukYR0fPhWwbJ+894S4D2HLBkSmELcC4Bff=EtfLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42856 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcGGLwz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 07:52:55 -0400
In-Reply-To: <CALe9h7fc55ukYR0fPhWwbJ+894S4D2HLBkSmELcC4Bff=EtfLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

On 07/07/2016 12:54, John Spray wrote:
> On Wed, Jul 6, 2016 at 11:51 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi John,
>>
>> While testing the CephFS jewel backports found in the jewel-backport=
s branch, we ran into a memory leak that consistently happen:
>>
>> http://pulpito.ceph.com/loic-2016-06-16_02:28:14-fs-jewel-backports-=
--basic-smithi/263842
>=20
> The client leak is a false positive, I'm not sure what is triggering
> it (it seems to only happen on centos nodes, and not be silenced by
> the suppression that we have in the valgrind config).
> http://tracker.ceph.com/issues/14794

Thanks for that, I'm relieved :-)

> Is it definitely not happening on the jewel branch, or is it possible
> that the jewel run just wasn't executing that test on centos nodes?

http://pulpito.ceph.com/loic-2016-06-28_23:43:39-fs-jewel---basic-smith=
i/282493/ is indeed running on Ubuntu

>=20
> The MDS leaks are currently ignored in the ceph.py task (yuck!) so
> they're probably happening everywhere else too and you can ignore
> them.

And the reason why it show on jewel is probably because the ceph.py tas=
k in ceph-qa-suite jewel branch does not ignore leaks. I took notes so =
we remember it's a false positive http://tracker.ceph.com/issues/16344#=
note-9

Thanks !

> John
>=20
>> and that is not present in the jewel branch
>>
>> http://pulpito.ceph.com/loic-2016-06-28_23:43:39-fs-jewel---basic-sm=
ithi/282493/
>>
>> Meaning one of the backports is doing something wrong. Or there is a=
 backport fixing the leak that is missing.
>>
>> This one looks interesting to me
>>
>> https://github.com/ceph/ceph/commit/37b7b09ee19ad64362c2faf63461353c=
03a36ada
>>
>> There also are related to leaks but I'm not so sure.
>>
>> https://github.com/ceph/ceph/commit/89f74c98ea43df46291c8bec890b3a75=
c7ce38b4
>> https://github.com/ceph/ceph/commit/4c52bf9ed47d52510536ebc34bd6c56a=
dba1df53
>>
>> If you have ideas on how to approach this and save random exploratio=
n time, it would be most welcome. If not, I'll get it eventually, no wo=
rries :-)
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
