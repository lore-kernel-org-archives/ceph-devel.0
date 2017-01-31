From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: RGW Indexing-in-PostgreSQL?
Date: Tue, 31 Jan 2017 11:53:47 +0200
Message-ID: <CABo9giQhBLCA5iAPokcAag6drxBdWe=wsRfB_8JHZsh2nmfzRw@mail.gmail.com>
References: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38473 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750804AbdAaJza (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2017 04:55:30 -0500
Received: by mail-wm0-f52.google.com with SMTP id r141so71283624wmg.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2017 01:53:49 -0800 (PST)
In-Reply-To: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On Tue, Jan 31, 2017 at 1:56 AM, Martin Millnert <martin@millnert.se> wrote:
> Hi,
>
> we're running RGW with indexes placed on fast pools, whereas the data is
> placed on slow pools. The write throughput is approximately 10% of rados
> bench and I guess we're experiencing some locking/syncronization
> feature, because parallelisation doesn't really speed it up.

This is very low, I would guess it is a configuration issue.
What is the workload you are using (large/small object sizes)?
Are you using multipart upload? How many parallel uploads?
How many RGW instances?
How many Civetweb threads are configured?
How many objects you have in the bucket and how many shards?
We recommend around 100K object per shard for good performance.

Also can you provides information about your pools setup (pg_num,
chunk size ...)?

> I've seen the sharding option, and the indexless option, but neither one
> of these seems like /the/ fix to me.
> My limited knowledge of the RGW code makes me guess it's due to the
> indexes, and possibly even additional metadata that RGW keeps
> up-to-date?
>

First we need to understand what is causing the bad performance, you
will need to provide more details so we can understand the problem.

indexless bucket is used for very large buckets (with millions of
objects)  it means you cannot list the objects in the buckets or use
geo-replication.  It depends on your what workload needs in the end.

> Assuming that the index objectes must be downloaded, rewritten, and
> re-uploaded to the index pools by RGW (and that this should be
> locking?), the thought that I've had for a while now is:

That is not the case at all,
indexes are rados omap object (key/value) that support key/value operations.
They are optimized for those kinds of operations.
We need sharding in case the buckets contains lots of objects (100K is
the recommend limit per shard).
Each index shard is one rados object. Those object allow efficient
key/value updates.
We use Rocksdb for the key/value store in Ceph.

> How hard is it to abstract these index operations and add support for
> actually using PostgreSQL as a backend?
The abstraction is done in the OSD level so my guess quite hard.
We need to replicate and distrbute the index object so multiple
instances of RGW can access it concorrently. Rados does that for us.
PostgreSQL is not the right backend as we need key/value operations
SQL is a lot more than that.

Orit

> I don't mean to say bad words vis-a-vis a completely self-contained data
> management system, etc, but (more) right(*) (optional) tool for the job has some
> quality to it too. :-)
>
> I'd be willing to take a look at it, I guess.
>
> Thoughts?
>
> Best,
> Martin
>
> (* Latency/HA/etc tradeoffs may vary based on use-case and
> requirements.)
