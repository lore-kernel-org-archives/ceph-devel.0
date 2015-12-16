From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 17:40:33 +0800
Message-ID: <CANE=7sU_R69V8cfUbZZFJiwE6YTd3LA_dLJHfK-n=5ymjwK4CA@mail.gmail.com>
References: <5670A8A9.3020708@digiware.nl>
	<CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
	<56712CC2.90507@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36724 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbbLPJke convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 04:40:34 -0500
Received: by mail-oi0-f44.google.com with SMTP id o62so16648053oif.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 01:40:34 -0800 (PST)
In-Reply-To: <56712CC2.90507@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Because we use the new strategy for filejournal in master branch. the
write entry submit to writeq is aligned already.
So if assert at this line, this strategy should have bug.

I do not know why you have some heads #include, Maybe you modify the
logic in filejournal?

2015-12-16 17:20 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
> On 16-12-2015 02:57, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
>> You mean your ceph assert(0 =3D=3D "bl should be align"), right?
>>
>> But in master branch, the 1036 line is not assert(0 =3D=3D "bl shoul=
d be align").
>
> Yes you are correct. I think I have some heade #includes why this mov=
es
> down in my file.
>
> None the less I still get trapped on that specific assert.
>
> Next question is of course why this code is what it is. Since once th=
e
> assert triggers, the remainder does not get executed.
> Unless compiled with NDEBUG, then only the warning gets printed.
> But the other asserts never get triggered.
>
> So back to my original question, Why have this very stringent test an=
d
> than in test/buffer.cc forgo the fact that this could/should be align=
ed.
>
> --WjW
>
>
>> 2015-12-16 7:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>> Hi,
>>>
>>> I'm receiving traps when running the tests going with 'gmake check'
>>> and on one of the tests it traps on:
>>>
>>> os/FileJournal.cc:1036
>>> void FileJournal::align_bl(off64_t pos, bufferlist& bl)
>>> {
>>>   // make sure list segments are page aligned
>>>   if (directio && (!bl.is_aligned(block_size) ||
>>>                    !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE))) =
{
>>>     assert(0 =3D=3D "bl should be align");
>>>     if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0 ||
>>>         (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0)
>>>       dout(0) << "rebuild_page_aligned failed, " << bl << dendl;
>>>     assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>>     assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>>   }
>>> }
>>>
>>> And then I get confused with the following commit in other tests:
>>> commit 8ed724222651812c2ee8cc3804dc1f54c973897d
>>> Author: Kefu Chai <kchai@redhat.com>
>>> Date:   Fri Sep 4 01:23:31 2015 +0800
>>>
>>>     test/bufferlist: do not expect !is_page_aligned() after unalign=
ed
>>> rebuild
>>>
>>>     if the size of a bufferlist is page aligned we allocate page al=
igned
>>>     memory chunk for it when rebuild() is called. otherwise we just=
 call
>>>     the plain new() to allocate new memory chunk for holding the co=
ntinuous
>>>     buffer. but we should not expect that `new` allocator always re=
turns
>>>     unaligned memory chunks. instead, it *could* return page aligne=
d
>>>     memory chunk as long as the allocator feels appropriate. so, th=
e
>>>     `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()` call=
 is
>>>     removed.
>>>
>>>     Signed-off-by: Kefu Chai <kchai@redhat.com>
>>>
>>> Could these 2 be related, and do I have an alignment problem when
>>> allocating buffers and bufferlists....
>>>
>>> Note that I also have not solved the illegal writes to _len in
>>> bufferlists when running unittest_erasure_code_shec_arguments.
>>>
>>> So any suggestions as to where to look at for this, are welcome.
>>>
>>> --WjW
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>



--=20
Regards,
Xinze Chi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
