From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 10:20:02 +0100
Message-ID: <56712CC2.90507@digiware.nl>
References: <5670A8A9.3020708@digiware.nl>
 <CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:16270 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbbLPJ3q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 04:29:46 -0500
In-Reply-To: <CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 16-12-2015 02:57, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
> You mean your ceph assert(0 =3D=3D "bl should be align"), right?
>=20
> But in master branch, the 1036 line is not assert(0 =3D=3D "bl should=
 be align").

Yes you are correct. I think I have some heade #includes why this moves
down in my file.

None the less I still get trapped on that specific assert.

Next question is of course why this code is what it is. Since once the
assert triggers, the remainder does not get executed.
Unless compiled with NDEBUG, then only the warning gets printed.
But the other asserts never get triggered.

So back to my original question, Why have this very stringent test and
than in test/buffer.cc forgo the fact that this could/should be aligned=
=2E

--WjW


> 2015-12-16 7:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>> Hi,
>>
>> I'm receiving traps when running the tests going with 'gmake check'
>> and on one of the tests it traps on:
>>
>> os/FileJournal.cc:1036
>> void FileJournal::align_bl(off64_t pos, bufferlist& bl)
>> {
>>   // make sure list segments are page aligned
>>   if (directio && (!bl.is_aligned(block_size) ||
>>                    !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE))) {
>>     assert(0 =3D=3D "bl should be align");
>>     if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0 ||
>>         (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) !=3D 0)
>>       dout(0) << "rebuild_page_aligned failed, " << bl << dendl;
>>     assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>     assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) =3D=3D 0);
>>   }
>> }
>>
>> And then I get confused with the following commit in other tests:
>> commit 8ed724222651812c2ee8cc3804dc1f54c973897d
>> Author: Kefu Chai <kchai@redhat.com>
>> Date:   Fri Sep 4 01:23:31 2015 +0800
>>
>>     test/bufferlist: do not expect !is_page_aligned() after unaligne=
d
>> rebuild
>>
>>     if the size of a bufferlist is page aligned we allocate page ali=
gned
>>     memory chunk for it when rebuild() is called. otherwise we just =
call
>>     the plain new() to allocate new memory chunk for holding the con=
tinuous
>>     buffer. but we should not expect that `new` allocator always ret=
urns
>>     unaligned memory chunks. instead, it *could* return page aligned
>>     memory chunk as long as the allocator feels appropriate. so, the
>>     `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()` call =
is
>>     removed.
>>
>>     Signed-off-by: Kefu Chai <kchai@redhat.com>
>>
>> Could these 2 be related, and do I have an alignment problem when
>> allocating buffers and bufferlists....
>>
>> Note that I also have not solved the illegal writes to _len in
>> bufferlists when running unittest_erasure_code_shec_arguments.
>>
>> So any suggestions as to where to look at for this, are welcome.
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
