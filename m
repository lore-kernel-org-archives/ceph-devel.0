From: Mark Nelson <mnelson@redhat.com>
Subject: Re: BlueStore and maximum number of objects per PG
Date: Tue, 21 Feb 2017 20:53:33 -0600
Message-ID: <7d98cbf5-97e5-f09a-9b1e-b4fa6668c104@redhat.com>
References: <1002796178.10638.1487707472256@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbdBVCxk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Feb 2017 21:53:40 -0500
In-Reply-To: <1002796178.10638.1487707472256@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Wido,

On 02/21/2017 02:04 PM, Wido den Hollander wrote:
> Hi,
>
> I'm about to start a test where I'll be putting a lot of objects into BlueStore and see how it holds.
>
> The reasoning behind is that I have a customer which has 165M objects in it's cluster which results in some PGs having 900k objects.
>
> For FileStore with XFS this is quite heavy. A simple scrub takes ages.
>
> The problem is that we can't simply increase the number of PGs since that will overload the OSDs as well.
>
> On the other hand we could add hardware, but that also takes time.
>
> So just for the sake of testing I'm looking at trying to replicate this situation using BlueStore from master.
>
> Is there anything I should take into account? I'll probably be just creating a lot (millions) of 100 byte objects in the cluster with just a few PGs.

Couple of general things:

I don't anticipate you'll run into the same kind of pg splitting 
slowdowns that you see with filestore, but you still may see some 
slowdown as the object count increases since rocksdb will have more 
key/value pairs to deal with.  I expect you'll see a lot of metadata 
movement between levels as it tries to keep things organized.  One thing 
to note is that it's possible you may see rocksdb bottlenecks as the OSD 
volume size increases.  This is one of the things the guys at Sandisk 
were trying to tackle with Zetascale.

If you can put the rocksdb DB and WAL on SSDs that will likely help, but 
you'll want to be mindful of how full the SSDs are getting.  I'll be 
very curious to see how your tests go, it's been a while since we've 
thrown that many objects on a bluestore cluster (back around the 
newstore timeframe we filled bluestore with many 10s of millions of 
objects and from what I remember it did pretty well).

Mark

>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
