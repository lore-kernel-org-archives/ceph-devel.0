From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Some thoughts regarding the new store
Date: Wed, 27 May 2015 17:46:03 +0800
Message-ID: <CACJqLyZzw+2ZbX6zDN_x6SZ4kCk+NJ6bty_yu+s_6gCACYRvww@mail.gmail.com>
References: <55658320.3060907@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34869 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbE0JqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 05:46:04 -0400
Received: by pdea3 with SMTP id a3so7466894pde.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 02:46:03 -0700 (PDT)
In-Reply-To: <55658320.3060907@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 27, 2015 at 4:41 PM, Li Wang <liwang@ubuntukylin.com> wrote:
> I have just noticed the new store development, and had a
> look at the idea behind it (http://www.spinics.net/lists/ceph-
> devel/msg22712.html), so my understanding, we wanna avoid the
> double-write penalty of WRITE_AHEAD_LOGGING journal mechanism,
> the straightforward thought is to optimize CREATE, APPEND and
> FULL-OBJECT-OVERWRITE by writing into new files directly,
> then update the metadata in a transaction. Other changes include:
> move the object metadata from filesystem extend attrbutes into
> key value database; map an object into possibly multiple files.
>
> If my understanding is correct, then it seems there follows some issues,
>
> 1 Garbage collection is needed to reclaim orphan files generated
> from crashing;

Yes, but still now we haven't dive into this problem. Because
currently newstore only allow one object one file.

Anyway I guess GC isn't a big problem. journal keys should be help, is
something I missed here?

>
> 2 On spinning disks, it loses the advantages that journal makes random
>  writes into sequential writes, then commits them in groups and
> leverages another disk to hide the committing delay.
>

We need to clarify something here, for small random write workload,
newstore still need journal to make durable and shorter latency.

Although filejournal make use of write ahead to improve performance,
but journal is far away from data location in disk(partition or
preallocation file). We always need to write data to disk and the seek
distance is long I think. For newstore, actually in my best wish
journal and data could be in one allocation group in local filesystem
concept(it may be difficult though), just like a ideal fragment
implementation as expected. In other word, fragment should be
something to aggregate small writes, but we haven't make it done as
expected.

Although now newstore's random write performance is bad than
filestore, I think it's not related to design. We still have lots of
things could be apply to improve.

> 3 OVERWRITE theoretically does not benefit from this design, and the
> introducing of fragment, increases the object metadata overhead. The
> possibly mapping of multiple files may also slow down the object
> read/write performance. OVERWRITE is the major scenario for RBD,
> consequently, for cloud environment.

yes, we need to handle this thing. Actually for one object mapping to
multi file, we doesn't have a design(@sage yes? or I missed?). We may
could think of a solution to make tradeoff  :-)


>
> 4 By mapping an object into multiple files, potentially we can optimize
> OVERWRITE by turning it also into APPEND by using small fragments,
> that, actually mimic Btrfs. However, for many small writes, it may
> leave many small files in the backend local file system, that may slow
> down the object read/write performance, especially on spinning
> disk. More importantly, I think it, to some extent, against the
> philosophy of object storage, which uses a big object to store data to
> reduce the metadata cost, and leaves the block management for local
> file system. For a local file system, big file performance is generally
> better than small file. If we introduce fragment, it looks like the
> object storage self cares about the object data allocation now.
>
> What is the community's option?

Anyway, I think the core idea is we make newstore better than
filestore in most of workloads.

>
> Cheers,
> Li Wang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
