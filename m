From: Gregory Farnum <greg@inktank.com>
Subject: Re: cephfs set_layout - tuning
Date: Wed, 14 Aug 2013 13:47:06 -0700
Message-ID: <CAPYLRzjXcO_zk4yJwWB5Qs_5Nd9xOXqzjp__Mv7KUdKTRV9f8w@mail.gmail.com>
References: <20130809074457.GA27330@oder.mch.fsc.net>
	<20130809090350.GB27330@oder.mch.fsc.net>
	<CAPYLRzj2bisxFcATOt66tCfr5jnUU3eZ23kDiDA0sN_+50Am+Q@mail.gmail.com>
	<20130814203801.GA27534@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47020 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004Ab3HNUrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 16:47:07 -0400
Received: by mail-wi0-f175.google.com with SMTP id hq12so2465941wib.14
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 13:47:06 -0700 (PDT)
In-Reply-To: <20130814203801.GA27534@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 14, 2013 at 1:38 PM, Kasper Dieter
<dieter.kasper@ts.fujitsu.com> wrote:
> On Wed, Aug 14, 2013 at 10:17:24PM +0200, Gregory Farnum wrote:
>> On Fri, Aug 9, 2013 at 2:03 AM, Kasper Dieter
>> <dieter.kasper@ts.fujitsu.com> wrote:
>> > OK,
>> > I found this nice page: http://ceph.com/docs/next/dev/file-striping/
>> > which explains "--stripe_unit --stripe_count --object_size"
>> >
>> > But still I'm not sure about
>> > (1) what is the equivalent command on cephfs to 'rbd create --order 16' ?
>>
>> There's not a direct one; CephFS lets you specify arbitrary sizes
>> (--stripe-unit) while rbd restricts you to powers of two. If you want
>> a new file to use a 64KB object size you can just set the object_size
>> to be 64KB.
>>
>> > (2) how to use those parameters to achieve different optimized layouts on CephFS directories
>> >     (e.g. for streaming, small sequential IOs, small random IOs)
>>
>> If (as Yan suspects) you mean specifying how the directory is laid out
>> on disk, you can't ? CephFS directories aren't maintained that way and
>> it wouldn't make any sense. If you're talking about making all the
>> files underneath it use a new layout, you can specify a directory
>> layout which is applied to all new descendent files the same way as
>> you specify the layout on an individual file.
> Thank you Greg,
>
> my question was which parameters of "--stripe_unit --stripe_count --object_size"
> would be optimal for new descendent files under directories
> /mnt/cephfs/streaming
> /mnt/cephfs/seq-IOs
> /mnt/cephfs/rand-IOs
>
> e.g.
> cephfs /mnt/cephfs/streaming set_layout -p 3 -s 4194304 -u 4194304 -c 1
> cephfs /mnt/cephfs/seq-IOs   set_layout -p 3 -s 4194304 -u   65536 -c 8
> cephfs /mnt/cephfs/rand-IOs  set_layout -p 3 -s   65536 -u   65536 -c 1

Ah. That will depend a lot on what your specific usage scenario looks
like. The stripe unit is going to cap the size of an individual IO, so
for large sequential IOs you'll want that to be large. The stripe
count determines how many objects are involved over a specific number
of stripes (eg, 64KB stripe units with a stripe count of 10 means the
first 640KB of a file will all be on separate objects, before wrapping
around to the first one).
You might find that under certain benchmarking patterns your
sequential IO will go up if you use smaller stripe units and stripe
them across many objects, but if you've got a writeback cache in the
way I suspect it will be fairly pointless since the cache can
aggregate those into a single larger IO (which is preferable).
For random IO you probably (depending on your macro workload) want to
use smaller stripe units with a fairly wide stripe count, but perhaps
increase the size of the objects (reducing the number of inodes the
OSDs need to keep track of).

But really you just need to experiment; the aggregate performance of
different workloads against different striping policies is still not a
very well-researched area in Ceph or elsewhere.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
