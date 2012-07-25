From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Clusters and pools
Date: Wed, 25 Jul 2012 17:02:24 +0200
Message-ID: <50100A80.2020301@widodh.nl>
References: <F5955DC568F9AF4DB00BE0F7E950BE0C0E903140@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:52101 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964773Ab2GYPC0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 11:02:26 -0400
In-Reply-To: <F5955DC568F9AF4DB00BE0F7E950BE0C0E903140@BLUPRD0411MB438.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 07/25/2012 06:34 AM, Ryan Nicholson wrote:
> I'm running a cluster based on 4 hosts that each have 3 fast, SCSI osd's, and 1 very large SATA osd, meaning, 12 fast osd's and 4 slow osd's total. I wish to segregate these into 2 pools, that operate independently. The goal is to use the faster disks as an area to hold rbd based VM's, and the larger area to host rbd-base large volumes (to start), and possibly have that become just a big cephfs area once, the fs side of things is considered more stable.
>
> Now, I've been thrown a couple options, and am still unsettled. Which is best?:
> - Create 2 independent clusters; one with the 12 SCSI osd's and the other with just the 4 large OSD's on the same hosts. This seems to be more complex from a scripting and boot time standpoint, but easier for my head.
> - Create a single cluster and use CRUSH rules to separate the two. This one STILL has me lost, as I'm having trouble understanding the crushmap syntax, the Crushmap import/export commands, and the other mkpool or otherwise commands from the docs in order to "make rbd's come from this faster pool", while "cephfs, you come from this slower pool". I really would like to entertain this path, however, as this allows ceph to handle the entire situation, and, it would seem more elegant.
>
> I'm also open to other options as well.

The "easiest" way to approach this:

Set up the cluster with the 12 fast OSD's first en leave the other 4 out 
of the configuration.

Get everything up and running and play with it.

Then, add the 4 remaining OSD's to the cluster:
1. Add them to ceph.conf
2. Increment max_osd
3. Add them to the keyring
4. Format the OSD's
5. Start the OSD's

Now they should show up in your "ceph -s" output, but no data will go to 
them.

The next step is to export your current crushmap:

$ ceph osd getcrushmap -o crushmap
$ crushtool -d crushmap -o crushmap.txt

You should now add 4 new hosts to the crushmap, something like 
"hostA-slow" and add one OSD under each of them.

Now you can add a new rack called "slowrbd" for example, add a new pool 
and a new rule afterwards.

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
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
