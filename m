From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next hammer release v0.94.6
Date: Sun, 7 Feb 2016 21:15:57 -0800
Message-ID: <CAJ4mKGbAGpQDsscd5uin26yrQVQ3TDLWetK_wK=2D09wS=S=dw@mail.gmail.com>
References: <56B18773.6000304@dachary.org>
	<CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
	<56B2E523.9030104@dachary.org>
	<56B80EF0.1080000@dachary.org>
	<CAJ4mKGZx3q840YkZjege0z+OAAm3qHjJTd_PuzGnR2aeLyY-gw@mail.gmail.com>
	<56B8233A.5050207@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36499 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcBHFP6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 00:15:58 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so97199594wmp.1
        for <ceph-devel@vger.kernel.org>; Sun, 07 Feb 2016 21:15:58 -0800 (PST)
In-Reply-To: <56B8233A.5050207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Yeah.

On Sun, Feb 7, 2016 at 9:10 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> I will run a single job with https://github.com/ceph/ceph/pull/7501 t=
o verify it does work before merging it. Will that be enough ?
>
> Cheers
>
> On 08/02/2016 10:44, Gregory Farnum wrote:
>> Yes, just wanted those two fixes we discussed. :)
>>
>> On Sun, Feb 7, 2016 at 7:43 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> Hi Greg,
>>>
>>> Do you think the hammer branch is ready for QE to start their own r=
ound of testing ?
>>>
>>> Cheers
>>>
>>> On 04/02/2016 12:44, Loic Dachary wrote:
>>>> Hi Greg,
>>>>
>>>> On 03/02/2016 16:23, Gregory Farnum wrote:
>>>>> On Tue, Feb 2, 2016 at 8:52 PM, Loic Dachary <loic@dachary.org> w=
rote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> The next hammer release as found at https://github.com/ceph/ceph=
/tree/hammer passed the fs suite (http://tracker.ceph.com/issues/13356#=
note-25). A more recent run showed 3 failures and I'm not sure how to i=
nterpret them ( http://pulpito.ceph.com/loic-2016-01-29_03:02:05-fs-ham=
mer---basic-multi/ ).
>>>>>>
>>>>>> Do you think the hammer branch is ready for QE to start their ow=
n round of testing ? Or should the above errors be investigated first ?
>>>>>
>>>>> Well, one of them looks to be an infrastructure issue of some kin=
d.
>>>>> You appear to have figured out the fsstress one
>>>>> (http://tracker.ceph.com/issues/14584#change-65185), and the fsx =
one
>>>>> is http://tracker.ceph.com/issues/14384. I'd get that quick backp=
ort
>>>>
>>>> Thanks for the pointer :-) (and to Nathan for backporting).
>>>>
>>>>> in as well (it's just a change to the qa script to point at a wor=
king
>>>>> version of the repo).
>>>>
>>>> Do you think the hammer branch is ready for QE to start their own =
round of testing ?
>>>>
>>>> Cheers
>>>>
>>>>> -Greg
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
