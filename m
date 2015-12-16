From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 14:45:21 +0100
Message-ID: <56716AF1.5030800@digiware.nl>
References: <5670A8A9.3020708@digiware.nl>
 <CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
 <56712CC2.90507@digiware.nl>
 <CANE=7sU_R69V8cfUbZZFJiwE6YTd3LA_dLJHfK-n=5ymjwK4CA@mail.gmail.com>
 <56713C48.10009@digiware.nl>
 <CANE=7sUnSBUsNGFFURw+hOafAyop=nnUvXG3RYq211zbW5G3SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57706 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562AbbLPNpy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 08:45:54 -0500
In-Reply-To: <CANE=7sUnSBUsNGFFURw+hOafAyop=nnUvXG3RYq211zbW5G3SA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 16-12-2015 13:51, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
> Would you mind create an issue in http://tracker.ceph.com/ and tell m=
e
> how to reproduce the bug?

You are aware that that requires running FreeBSD?

I will enter a ticket into the tracker.

--WjW


> Thanks.
>
> 2015-12-16 18:26 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>> On 16-12-2015 10:40, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
>>>
>>> Because we use the new strategy for filejournal in master branch. t=
he
>>> write entry submit to writeq is aligned already.
>>> So if assert at this line, this strategy should have bug.
>>>
>>> I do not know why you have some heads #include, Maybe you modify th=
e
>>> logic in filejournal?
>>
>>
>> No, the adds I've done are to work around the fact that the linux_ve=
rsion
>> stuff
>> is not really going to work for FreeBSD. Not the test, nor the resul=
ting
>> code.
>>
>> So the header part of the file  now looks like:
>> #include "common/blkdev.h"
>> #if defined(__linux__)
>> #include "common/linux_version.h"
>> #endif
>>
>> #if defined(__FreeBSD__)
>> #include "common/freebsd_version.h"
>> #define O_DSYNC O_SYNC
>> #endif
>>
>> The remainder of the diffs are about locking when using aio, which i=
 do not
>> ATM.
>>
>> So never say never with software, but I think I've left the logic as=
 it
>> is/was.
>>
>> --WjW
>>
>>
>>>
>>> 2015-12-16 17:20 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>>>
>>>> On 16-12-2015 02:57, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
>>>>>
>>>>> You mean your ceph assert(0 =3D=3D "bl should be align"), right?
>>>>>
>>>>> But in master branch, the 1036 line is not assert(0 =3D=3D "bl sh=
ould be
>>>>> align").
>>>>
>>>>
>>>> Yes you are correct. I think I have some heade #includes why this =
moves
>>>> down in my file.
>>>>
>>>> None the less I still get trapped on that specific assert.
>>>>
>>>> Next question is of course why this code is what it is. Since once=
 the
>>>> assert triggers, the remainder does not get executed.
>>>> Unless compiled with NDEBUG, then only the warning gets printed.
>>>> But the other asserts never get triggered.
>>>>
>>>> So back to my original question, Why have this very stringent test=
 and
>>>> than in test/buffer.cc forgo the fact that this could/should be al=
igned.
>>>>
>>>> --WjW
>>>>
>>>>
>>>>> 2015-12-16 7:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I'm receiving traps when running the tests going with 'gmake che=
ck'
>>>>>> and on one of the tests it traps on:
>>>>>>
>>>>>> os/FileJournal.cc:1036
>>>>>> void FileJournal::align_bl(off64_t pos, bufferlist& bl)
>>>>>> {
>>>>>>     // make sure list segments are page aligned
>>>>>>     if (directio && (!bl.is_aligned(block_size) ||
>>>>>>                      !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZ=
E))) {
>>>>>>       assert(0 =3D=3D "bl should be align");
>>>>>>       if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0 |=
|
>>>>>>           (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0)
>>>>>>         dout(0) << "rebuild_page_aligned failed, " << bl << dend=
l;
>>>>>>       assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D=
 0);
>>>>>>       assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>>>>>     }
>>>>>> }
>>>>>>
>>>>>> And then I get confused with the following commit in other tests=
:
>>>>>> commit 8ed724222651812c2ee8cc3804dc1f54c973897d
>>>>>> Author: Kefu Chai <kchai@redhat.com>
>>>>>> Date:   Fri Sep 4 01:23:31 2015 +0800
>>>>>>
>>>>>>       test/bufferlist: do not expect !is_page_aligned() after un=
aligned
>>>>>> rebuild
>>>>>>
>>>>>>       if the size of a bufferlist is page aligned we allocate pa=
ge
>>>>>> aligned
>>>>>>       memory chunk for it when rebuild() is called. otherwise we=
 just
>>>>>> call
>>>>>>       the plain new() to allocate new memory chunk for holding t=
he
>>>>>> continuous
>>>>>>       buffer. but we should not expect that `new` allocator alwa=
ys
>>>>>> returns
>>>>>>       unaligned memory chunks. instead, it *could* return page a=
ligned
>>>>>>       memory chunk as long as the allocator feels appropriate. s=
o, the
>>>>>>       `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()`=
 call is
>>>>>>       removed.
>>>>>>
>>>>>>       Signed-off-by: Kefu Chai <kchai@redhat.com>
>>>>>>
>>>>>> Could these 2 be related, and do I have an alignment problem whe=
n
>>>>>> allocating buffers and bufferlists....
>>>>>>
>>>>>> Note that I also have not solved the illegal writes to _len in
>>>>>> bufferlists when running unittest_erasure_code_shec_arguments.
>>>>>>
>>>>>> So any suggestions as to where to look at for this, are welcome.
>>>>>>
>>>>>> --WjW
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
