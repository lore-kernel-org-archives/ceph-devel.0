From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: Clusters and pools
Date: Fri, 27 Jul 2012 01:25:14 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C0E9053A5@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <F5955DC568F9AF4DB00BE0F7E950BE0C0E903140@BLUPRD0411MB438.namprd04.prod.outlook.com>
 <50100A80.2020301@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:18408
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab2G0BkY convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Jul 2012 21:40:24 -0400
In-Reply-To: <50100A80.2020301@widodh.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks, Wido, for your help. Here's another question for the group:

I've created 2 new rados pools;

SCSI and
Large
I've also REMOVED 'data' from the pools. <--not sure if this is an issue.

How do I setup mountpoints? I wish to mount SCSI as CephFS, or, LaCie as CephFS. My goal is, from the client's perspective to treat these two entities as separate. In production, only RBD's will be on SCSI, and CephFS stuff would live on Large but I do want to learn how to configure this before I take the system out of testing.

I wasn't sure if there was an option for mount.ceph that allowed me to select the pool? Say, x.x.x.x:6789:??:/ or otherwise.

Thanks!

Ryan


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den Hollander
Sent: Wednesday, July 25, 2012 10:02 AM
To: Ryan Nicholson
Cc: ceph-devel@vger.kernel.org
Subject: Re: Clusters and pools



On 07/25/2012 06:34 AM, Ryan Nicholson wrote:
> I'm running a cluster based on 4 hosts that each have 3 fast, SCSI osd's, and 1 very large SATA osd, meaning, 12 fast osd's and 4 slow osd's total. I wish to segregate these into 2 pools, that operate independently. The goal is to use the faster disks as an area to hold rbd based VM's, and the larger area to host rbd-base large volumes (to start), and possibly have that become just a big cephfs area once, the fs side of things is considered more stable.
>
> Now, I've been thrown a couple options, and am still unsettled. Which is best?:
> - Create 2 independent clusters; one with the 12 SCSI osd's and the other with just the 4 large OSD's on the same hosts. This seems to be more complex from a scripting and boot time standpoint, but easier for my head.
> - Create a single cluster and use CRUSH rules to separate the two. This one STILL has me lost, as I'm having trouble understanding the crushmap syntax, the Crushmap import/export commands, and the other mkpool or otherwise commands from the docs in order to "make rbd's come from this faster pool", while "cephfs, you come from this slower pool". I really would like to entertain this path, however, as this allows ceph to handle the entire situation, and, it would seem more elegant.
>
> I'm also open to other options as well.

The "easiest" way to approach this:

Set up the cluster with the 12 fast OSD's first en leave the other 4 out of the configuration.

Get everything up and running and play with it.

Then, add the 4 remaining OSD's to the cluster:
1. Add them to ceph.conf
2. Increment max_osd
3. Add them to the keyring
4. Format the OSD's
5. Start the OSD's

Now they should show up in your "ceph -s" output, but no data will go to them.

The next step is to export your current crushmap:

$ ceph osd getcrushmap -o crushmap
$ crushtool -d crushmap -o crushmap.txt

You should now add 4 new hosts to the crushmap, something like "hostA-slow" and add one OSD under each of them.

Now you can add a new rack called "slowrbd" for example, add a new pool and a new rule afterwards.

Compile crushmap.txt back again to "crushmap" and load it into the cluster.

You can now create a new pool with a specific crushrule.

All the data in that pool will go onto those 4 slower OSD's.

Wido

>
> Thanks!
>
> Ryan Nicholson
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


