From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next hammer release v0.94.6
Date: Mon, 8 Feb 2016 12:10:18 +0700
Message-ID: <56B8233A.5050207@dachary.org>
References: <56B18773.6000304@dachary.org>
 <CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
 <56B2E523.9030104@dachary.org> <56B80EF0.1080000@dachary.org>
 <CAJ4mKGZx3q840YkZjege0z+OAAm3qHjJTd_PuzGnR2aeLyY-gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60249 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcBHFK1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 00:10:27 -0500
In-Reply-To: <CAJ4mKGZx3q840YkZjege0z+OAAm3qHjJTd_PuzGnR2aeLyY-gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Hi,

I will run a single job with https://github.com/ceph/ceph/pull/7501 to =
verify it does work before merging it. Will that be enough ?

Cheers

On 08/02/2016 10:44, Gregory Farnum wrote:
> Yes, just wanted those two fixes we discussed. :)
>=20
> On Sun, Feb 7, 2016 at 7:43 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Greg,
>>
>> Do you think the hammer branch is ready for QE to start their own ro=
und of testing ?
>>
>> Cheers
>>
>> On 04/02/2016 12:44, Loic Dachary wrote:
>>> Hi Greg,
>>>
>>> On 03/02/2016 16:23, Gregory Farnum wrote:
>>>> On Tue, Feb 2, 2016 at 8:52 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>> Hi Greg,
>>>>>
>>>>> The next hammer release as found at https://github.com/ceph/ceph/=
tree/hammer passed the fs suite (http://tracker.ceph.com/issues/13356#n=
ote-25). A more recent run showed 3 failures and I'm not sure how to in=
terpret them ( http://pulpito.ceph.com/loic-2016-01-29_03:02:05-fs-hamm=
er---basic-multi/ ).
>>>>>
>>>>> Do you think the hammer branch is ready for QE to start their own=
 round of testing ? Or should the above errors be investigated first ?
>>>>
>>>> Well, one of them looks to be an infrastructure issue of some kind=
=2E
>>>> You appear to have figured out the fsstress one
>>>> (http://tracker.ceph.com/issues/14584#change-65185), and the fsx o=
ne
>>>> is http://tracker.ceph.com/issues/14384. I'd get that quick backpo=
rt
>>>
>>> Thanks for the pointer :-) (and to Nathan for backporting).
>>>
>>>> in as well (it's just a change to the qa script to point at a work=
ing
>>>> version of the repo).
>>>
>>> Do you think the hammer branch is ready for QE to start their own r=
ound of testing ?
>>>
>>> Cheers
>>>
>>>> -Greg
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
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
