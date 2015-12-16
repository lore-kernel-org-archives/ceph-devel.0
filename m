From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 11:26:16 +0100
Message-ID: <56713C48.10009@digiware.nl>
References: <5670A8A9.3020708@digiware.nl>
 <CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
 <56712CC2.90507@digiware.nl>
 <CANE=7sU_R69V8cfUbZZFJiwE6YTd3LA_dLJHfK-n=5ymjwK4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:22386 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932888AbbLPK0Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 05:26:25 -0500
In-Reply-To: <CANE=7sU_R69V8cfUbZZFJiwE6YTd3LA_dLJHfK-n=5ymjwK4CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 16-12-2015 10:40, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
> Because we use the new strategy for filejournal in master branch. the
> write entry submit to writeq is aligned already.
> So if assert at this line, this strategy should have bug.
>
> I do not know why you have some heads #include, Maybe you modify the
> logic in filejournal?

No, the adds I've done are to work around the fact that the=20
linux_version stuff
is not really going to work for FreeBSD. Not the test, nor the resultin=
g=20
code.

So the header part of the file  now looks like:
#include "common/blkdev.h"
#if defined(__linux__)
#include "common/linux_version.h"
#endif

#if defined(__FreeBSD__)
#include "common/freebsd_version.h"
#define O_DSYNC O_SYNC
#endif

The remainder of the diffs are about locking when using aio, which i do=
=20
not ATM.

So never say never with software, but I think I've left the logic as it=
=20
is/was.

--WjW

>
> 2015-12-16 17:20 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>> On 16-12-2015 02:57, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
>>> You mean your ceph assert(0 =3D=3D "bl should be align"), right?
>>>
>>> But in master branch, the 1036 line is not assert(0 =3D=3D "bl shou=
ld be align").
>>
>> Yes you are correct. I think I have some heade #includes why this mo=
ves
>> down in my file.
>>
>> None the less I still get trapped on that specific assert.
>>
>> Next question is of course why this code is what it is. Since once t=
he
>> assert triggers, the remainder does not get executed.
>> Unless compiled with NDEBUG, then only the warning gets printed.
>> But the other asserts never get triggered.
>>
>> So back to my original question, Why have this very stringent test a=
nd
>> than in test/buffer.cc forgo the fact that this could/should be alig=
ned.
>>
>> --WjW
>>
>>
>>> 2015-12-16 7:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>>> Hi,
>>>>
>>>> I'm receiving traps when running the tests going with 'gmake check=
'
>>>> and on one of the tests it traps on:
>>>>
>>>> os/FileJournal.cc:1036
>>>> void FileJournal::align_bl(off64_t pos, bufferlist& bl)
>>>> {
>>>>    // make sure list segments are page aligned
>>>>    if (directio && (!bl.is_aligned(block_size) ||
>>>>                     !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE))=
) {
>>>>      assert(0 =3D=3D "bl should be align");
>>>>      if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0 ||
>>>>          (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0)
>>>>        dout(0) << "rebuild_page_aligned failed, " << bl << dendl;
>>>>      assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0=
);
>>>>      assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>>>    }
>>>> }
>>>>
>>>> And then I get confused with the following commit in other tests:
>>>> commit 8ed724222651812c2ee8cc3804dc1f54c973897d
>>>> Author: Kefu Chai <kchai@redhat.com>
>>>> Date:   Fri Sep 4 01:23:31 2015 +0800
>>>>
>>>>      test/bufferlist: do not expect !is_page_aligned() after unali=
gned
>>>> rebuild
>>>>
>>>>      if the size of a bufferlist is page aligned we allocate page =
aligned
>>>>      memory chunk for it when rebuild() is called. otherwise we ju=
st call
>>>>      the plain new() to allocate new memory chunk for holding the =
continuous
>>>>      buffer. but we should not expect that `new` allocator always =
returns
>>>>      unaligned memory chunks. instead, it *could* return page alig=
ned
>>>>      memory chunk as long as the allocator feels appropriate. so, =
the
>>>>      `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()` ca=
ll is
>>>>      removed.
>>>>
>>>>      Signed-off-by: Kefu Chai <kchai@redhat.com>
>>>>
>>>> Could these 2 be related, and do I have an alignment problem when
>>>> allocating buffers and bufferlists....
>>>>
>>>> Note that I also have not solved the illegal writes to _len in
>>>> bufferlists when running unittest_erasure_code_shec_arguments.
>>>>
>>>> So any suggestions as to where to look at for this, are welcome.
>>>>
>>>> --WjW
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
