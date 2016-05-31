From: Loic Dachary <loic@dachary.org>
Subject: Re: dependency on parted: just ceph-osd, or more?
Date: Wed, 1 Jun 2016 00:06:43 +0200
Message-ID: <574E0AF3.30501@dachary.org>
References: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
 <574E0581.3030705@dachary.org>
 <CAJ4mKGYBY9e-mC5EcgnKUsp3Wno7BpvxkfrzWdWK8LvdpQ-_zA@mail.gmail.com>
 <5bd661c7-9b72-2a6b-44c0-0f90228e3019@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49460 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcEaWG4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 18:06:56 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 4512247B410
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2016 00:06:48 +0200 (CEST)
In-Reply-To: <5bd661c7-9b72-2a6b-44c0-0f90228e3019@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

On 01/06/2016 00:04, Mark Nelson wrote:
> Even the OSD doesn't really need parted since it'll happily run on an=
y compliant filesystem.  it's only really ceph-disk itself that needs i=
t to prepare the partition and eventually the filesystem for the OSD.

Good point. I'm not sure there are plans to release ceph-disk as a sepa=
rate package though. It would make sense though but it would require no=
n trivial work.

Cheers

>=20
> Mark
>=20
> On 05/31/2016 04:55 PM, Gregory Farnum wrote:
>> On Tue, May 31, 2016 at 2:43 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Ken,
>>>
>>> On 31/05/2016 23:06, Ken Dreyer wrote:
>>>> Hi Loic, is there anything in ceph outside of the ceph-osd package
>>>> that requires parted?
>>>>
>>>> I'm wondering if we can move the parted dependency to the ceph-osd
>>>> sub-package, http://tracker.ceph.com/issues/16095
>>>>
>>>> Among other things, this would make Mon and MDS containers lighter=
=2E
>>>
>>> I'm sure the mon do not need parted. I'd be surprised if mds need i=
t but I'm only 99% sure ;-)
>>
>> I'm pretty sure as well. This is for the local disk shenanigans,
>> right? MDS definitely doesn't do anything there. :)
>> -Greg
>>
>>>
>>> Cheers
>>>
>>>>
>>>> - Ken
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --=20
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
