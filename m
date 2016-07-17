From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: Re: bluestore allocator performance testing
Date: Sun, 17 Jul 2016 01:09:21 -0400
Message-ID: <CAPLK-i_wJp2p14MdUJO8BN=ubt7sPhoWP880Yg5uBxzfcUs7Hw@mail.gmail.com>
References: <a42b6dd8-ea3e-a635-7af2-74f024f3ee1a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34919 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcGQFJX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Jul 2016 01:09:23 -0400
Received: by mail-yw0-f175.google.com with SMTP id l125so135268698ywb.2
        for <ceph-devel@vger.kernel.org>; Sat, 16 Jul 2016 22:09:22 -0700 (PDT)
In-Reply-To: <a42b6dd8-ea3e-a635-7af2-74f024f3ee1a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

Thanks for these results, could you please share the benchmarks? Also,
since the main reason for implementing bitmap allocator was to reduce
memory footprint, perhaps a benchmark measuring the memory usage or
performance under memory constrained environments would help better
estimate the advantages of bitmap allocator.

On Sat, Jul 16, 2016 at 10:28 AM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi All,
>
> Yesterday I ran through some quick tests looking at bluestore with stupid
> allocator and bitmap allocator, then compared with some existing jewel
> filestore benchmark results:
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZRWg2MTFhSk85b2M/view?usp=sharing
>
> Both allocators resulted in similar read performance characteristics (not
> shown as I wanted to focus on writes).  For writes they were quite
> different.  Stupid allocator was faster than bitmap allocator for sequential
> writes, while bitmap allocator was faster than stupid allocator for most
> sizes of random writes.  Bluestore in general was faster than filestore for
> large writes (due to the avoidance of journal writes), but was slower to
> varying degrees at small IO sizes.  bitmap allocator appears to result in
> very good random write behavior down to ~32K IO sizes, so small IO
> performance may improve as better locking behavior and Allen's encode/decode
> proposal are implemented.
>
> I think it would probably be worth spending a bit of time to understand why
> the sequential write performance with bitmap allocator is so much slower
> than stupid allocator.
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shehbaz Jaffer
First Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineering
University of Toronto
