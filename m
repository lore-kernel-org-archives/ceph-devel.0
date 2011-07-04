From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Servers with 40+ disks : to group or not to group ?
Date: Mon, 04 Jul 2011 19:46:51 +0200
Message-ID: <1309801611.2518.9.camel@wido-laptop.pcextreme.nl>
References: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48843 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab1GDRqy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 13:46:54 -0400
In-Reply-To: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Sat, 2011-07-02 at 15:30 +0200, Wilfrid Allembrand wrote:
> Hi everyone,
> 
> I'm trying to figure out what is the best OSD solution with an
> infrastructure made up of servers with a lot a disks in each. Say, for
> exemple you have 4+ nodes like Sun Fire X4500 (code-named Thumper).
> Each node is 48 disks.
> 
> What are the pros and cons to build a ceph cluster with btrfs on that
> kind of high density hardware, considering the different scenarios for
> each server :
> - 1 OSD daemon per disk, so 48 osd daemons per server

That would be the best option in terms of available storage, you would
get the maximum available storage, but you would need a LOT of RAM and
CPU power.

I'm running 10 nodes with 4 OSD's each on Atoms with 4GB of RAM, that is
pretty heavy for those machines, especially when you start to have a lot
of PGs (Placement Groups) and objects. Recovery then start to take a lot
of time and memory.

> - make 3 btrfs pools of 16 disks, so 3 osd daemons per server
> - make 3 raid 5 or 6 volumes, so 3 osd daemons per server

You could try making btrfs pools of 12 or 16 disks, whatever you like,
but you would then add a SPoF, if for some reason btrfs fails (bugs or
so) you could loose a lot of data, recovering that could saturate the
rest of your cluster.

Using software RAID is a second option, but still, adding even an extra
layer?

Running less OSD's would mean less memory overhead, but if it really
matters? I'm not sure. The more data and PGs you start to add, the more
it will start to stress your OSDs.

The number of PGs is influenced by the number of OSDs, so running less
OSDs means less PGs, but how much of a difference it makes? Not sure.


> 
> From a performance and management point of view, will you recommand a
> lot of small servers of a few numbers of thumper's like servers ?

From what I know, get a lot of small machines with lets say 4 to 8
disks. If one fails the impact on the cluster will be much smaller and
recovery will take less time.

Think about it, you have 3 "thumpers" with each 48TB of storage and one
fails, that is going to be a heavy recovery.

Wido

> 
> All the best,
> Wilfrid
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


