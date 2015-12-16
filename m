From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: FreeBSD is receiving traps on os/FileJournal.cc:1036
Date: Wed, 16 Dec 2015 09:57:31 +0800
Message-ID: <CANE=7sVrbvQehnuq5B=hE0Yo0BhDvr0xQV5DMAA_iph0T-0r-Q@mail.gmail.com>
References: <5670A8A9.3020708@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35088 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965348AbbLPB5c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 20:57:32 -0500
Received: by mail-ob0-f173.google.com with SMTP id 18so22022640obc.2
        for <ceph-devel@vger.kernel.org>; Tue, 15 Dec 2015 17:57:32 -0800 (PST)
In-Reply-To: <5670A8A9.3020708@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

You mean your ceph assert(0 == "bl should be align"), right?

But in master branch, the 1036 line is not assert(0 == "bl should be align").

2015-12-16 7:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
> Hi,
>
> I'm receiving traps when running the tests going with 'gmake check'
> and on one of the tests it traps on:
>
> os/FileJournal.cc:1036
> void FileJournal::align_bl(off64_t pos, bufferlist& bl)
> {
>   // make sure list segments are page aligned
>   if (directio && (!bl.is_aligned(block_size) ||
>                    !bl.is_n_align_sized(CEPH_MINIMUM_BLOCK_SIZE))) {
>     assert(0 == "bl should be align");
>     if ((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) != 0 ||
>         (pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) != 0)
>       dout(0) << "rebuild_page_aligned failed, " << bl << dendl;
>     assert((bl.length() & (CEPH_MINIMUM_BLOCK_SIZE - 1)) == 0);
>     assert((pos & (CEPH_MINIMUM_BLOCK_SIZE - 1)) == 0);
>   }
> }
>
> And then I get confused with the following commit in other tests:
> commit 8ed724222651812c2ee8cc3804dc1f54c973897d
> Author: Kefu Chai <kchai@redhat.com>
> Date:   Fri Sep 4 01:23:31 2015 +0800
>
>     test/bufferlist: do not expect !is_page_aligned() after unaligned
> rebuild
>
>     if the size of a bufferlist is page aligned we allocate page aligned
>     memory chunk for it when rebuild() is called. otherwise we just call
>     the plain new() to allocate new memory chunk for holding the continuous
>     buffer. but we should not expect that `new` allocator always returns
>     unaligned memory chunks. instead, it *could* return page aligned
>     memory chunk as long as the allocator feels appropriate. so, the
>     `EXPECT_FALSE(bl.is_page_aligned())` after the `rebuild()` call is
>     removed.
>
>     Signed-off-by: Kefu Chai <kchai@redhat.com>
>
> Could these 2 be related, and do I have an alignment problem when
> allocating buffers and bufferlists....
>
> Note that I also have not solved the illegal writes to _len in
> bufferlists when running unittest_erasure_code_shec_arguments.
>
> So any suggestions as to where to look at for this, are welcome.
>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Xinze Chi
