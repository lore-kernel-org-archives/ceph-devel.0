From: huang jun <hjwsm1989@gmail.com>
Subject: Re: 0.94.9 assert
Date: Mon, 21 Nov 2016 16:02:54 +0800
Message-ID: <CABAwU-Y1GBTHU4ht+FQQjW6hFo7XvLLUnk6dHBxycvYFSoZD2g@mail.gmail.com>
References: <CAAWNVq9aJ_yPXX4V=8Q8zy-eJ9mVhoKR_hp2pa5ikFGU0oV2wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35375 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbcKUIC4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2016 03:02:56 -0500
Received: by mail-qk0-f173.google.com with SMTP id n204so340507374qke.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2016 00:02:55 -0800 (PST)
In-Reply-To: <CAAWNVq9aJ_yPXX4V=8Q8zy-eJ9mVhoKR_hp2pa5ikFGU0oV2wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Gervai <grin@grin.hu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

seems like a disk error, you can check your dmesg output,

2016-11-21 15:33 GMT+08:00 Peter Gervai <grin@grin.hu>:
> Hello,
>
> This is Hammer(LTS), this may have been already fixed, maybe not, but
> you have asked me to write to you, so I do.
>
> osd repeatedly failing (online for 2-3 days), with the same assert:
>
> 2016-11-21 02:20:26.115902 7f1756cb9700 -1 os/FileStore.cc: In
> function 'virtual int FileStore::read(coll_t, const ghobject_t&,
> uint64_t, size_t, ceph::bufferlist&, uint32_t, bool)' thread
> 7f1756cb9700 time 2016-11-21 02:20:26.039891
> os/FileStore.cc: 2854: FAILED assert(allow_eio ||
> !m_filestore_fail_eio || got != -5)
>
>  ceph version 0.94.9 (fe6d859066244b97b24f09d46552afc2071e6f90)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x76) [0xc0f196]
>  2: (FileStore::read(coll_t, ghobject_t const&, unsigned long,
> unsigned long, ceph::buffer::list&, unsigned int, bool)+0xcc2)
> [0x911012]
>  3: (ReplicatedBackend::be_deep_scrub(hobject_t const&, unsigned int,
> ScrubMap::object&, ThreadPool::TPHandle&)+0x31c) [0xa2268c]
>  4: (PGBackend::be_scan_list(ScrubMap&, std::vector<hobject_t,
> std::allocator<hobject_t> > const&, bool, unsigned int,
> ThreadPool::TPHandle&)+0x2ca) [0x8d33fa]
>  5: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool,
> unsigned int, ThreadPool::TPHandle&)+0x1fa) [0x7dfdda]
>  6: (PG::chunky_scrub(ThreadPool::TPHandle&)+0x3be) [0x7e835e]
>  7: (PG::scrub(ThreadPool::TPHandle&)+0x1d7) [0x7e9a67]
>  8: (OSD::ScrubWQ::_process(PG*, ThreadPool::TPHandle&)+0x19) [0x6b6ab9]
>  9: (ThreadPool::worker(ThreadPool::WorkThread*)+0xa77) [0xbff747]
>  10: (ThreadPool::WorkThread::entry()+0x10) [0xc00810]
>  11: (()+0x80a4) [0x7f17794870a4]
>  12: (clone()+0x6d) [0x7f17779df62d]
>
> I have the full event log on request. My problem is that I see no
> other related log (with "perror" for example, as I have briefly seen
> in the source, though I don't know where was it supposed to go), so I
> don't know whether it's a disk error, a file format error or else. I
> try to poke the osd with a 'ceph osd repair', and see what happens.
>
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thank you!
HuangJun
