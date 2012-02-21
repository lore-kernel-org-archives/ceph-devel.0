From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: RE: Which SSD method is better for performance?
Date: Tue, 21 Feb 2012 10:44:36 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF7B4@exch10>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
 <4F3A5786.7060006@widodh.nl>
 <81C477727102DA4E9B2605AC748C495407E36DF792@exch10>
 <Pine.LNX.4.64.1202191911060.31319@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf2.mach.net.au ([115.165.172.4]:35667 "EHLO mf2.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779Ab2BUAot convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 19:44:49 -0500
In-Reply-To: <Pine.LNX.4.64.1202191911060.31319@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage

So following through by two examples, to confirm my understanding........

HDD SPECS:
8x 2TB SATA HDD's able to do sustained read/write speed of 138MB/s each
1x SSD able to do sustained read/write speed of 475MB/s

CASE1
(not using SSD)
8x OSD's each for the SATA HDD's
Therefore able to parallelise IO operations
Sustained write sent to Ceph of very large file say 500GB (therefore caches all used up and bottleneck becomes SATA IO speed) 
Gives 8x 138MB/s = 1,104 MB/s

CASE 2
(using 1x SSD)
SSD partitioned into 8x separate partitions, 1x for each OSD
Sustained write (with OSD-Journal to SSD) sent to Ceph of very large file (say 500GB)
Write spilt across 8x OSD-Journal partitions on the single SSD = limited to aggregate of 475MB/s

ANALYSIS:
If my examples are how Ceph operates, then it is necessary to not exceed a ratio of 3SATA:1SSD, if 4 or more SATA's are used then the SSD becomes the bottleneck.

Is this analysis accurate? Are there other benefits that SSD provide (including in non-sustained peak write performance use case) that would otherwise justify their usage? What ratios are other users sticking to when deciding for their design?

Many thanks all - this is all being rolled up into a new "Ceph SSD" wiki page I will be offering to Sage to include in the main Ceph wiki site.

Paul



-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Monday, 20 February 2012 1:16 PM
To: Paul Pettigrew
Cc: Wido den Hollander; ceph-devel@vger.kernel.org
Subject: RE: Which SSD method is better for performance?

On Mon, 20 Feb 2012, Paul Pettigrew wrote:
> And secondly, should the SSD Journal sizes be large or small?  Ie, is 
> say 1G partition per paired 2-3TB SATA disk OK? Or as large an SSD as 
> possible? There are many forum posts that say 100-200MB will suffice.
> A quick piece of advice will save us hopefully sever days of 
> reconfiguring and benchmarking the Cluster :-)

ceph-osd will periodically do a 'commit' to ensure that stuff in the journal is written safely to the file system.  On btrfs that's a snapshot, on anything else it's a sync(2).  When the journals hits 50% we trigger a commit, or when a timer expires (I think 30 seconds by default).  There is some overhead associated with the sync/snapshot, so less is generally better.

A decent rule of thumb is probably to make the journal big enough to consume sustained writes for 10-30 seconds.  On modern disks, that's probably 1-3GB?  If the journal is on the same spindle as the fs, it'll be probably half that...
</hand waving>

sage



> 
> Thanks
> 
> Paul
> 
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den 
> Hollander
> Sent: Tuesday, 14 February 2012 10:46 PM
> To: Paul Pettigrew
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Which SSD method is better for performance?
> 
> Hi,
> 
> On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
> > G'day all
> >
> > About to commence an R&D eval of the Ceph platform having been impressed with the momentum achieved over the past 12mths.
> >
> > I have one question re design before rolling out to metal........
> >
> > I will be using 1x SSD drive per storage server node (assume it is /dev/sdb for this discussion), and cannot readily determine the pro/con's for the two methods of using it for OSD-Journal, being:
> > #1. place it in the main [osd] stanza and reference the whole drive 
> > as a single partition; or
> 
> That won't work. If you do that all OSD's will try to open the journal. 
> The journal for each OSD has to be unique.
> 
> > #2. partition up the disk, so 1x partition per SATA HDD, and place 
> > each partition in the [osd.N] portion
> 
> That would be your best option.
> 
> I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf
> 
> the VG "data" is placed on a SSD (Intel X25-M).
> 
> >
> > So if I were to code #1 in the ceph.conf file, it would be:
> > [osd]
> > osd journal = /dev/sdb
> >
> > Or, #2 would be like:
> > [osd.0]
> >          host = ceph1
> >          btrfs devs = /dev/sdc
> >          osd journal = /dev/sdb5
> > [osd.1]
> >          host = ceph1
> >          btrfs devs = /dev/sdd
> >          osd journal = /dev/sdb6
> > [osd.2]
> >          host = ceph1
> >          btrfs devs = /dev/sde
> >          osd journal = /dev/sdb7
> > [osd.3]
> >          host = ceph1
> >          btrfs devs = /dev/sdf
> >          osd journal = /dev/sdb8
> >
> > I am asking therefore, is the added work (and constraints) of specifying down to individual partitions per #2 worth it in performance gains? Does it not also have a constraint, in that if I wanted to add more HDD's into the server (we buy 45 bay units, and typically provision HDD's "on demand" i.e. 15x at a time as usage grows), I would have to additionally partition the SSD (taking it offline) - but if it were #1 option, I would only have to add more [osd.N] sections (and not have to worry about getting the SSD with 45x partitions)?
> >
> 
> You'd still have to go for #2. However, running 45 OSD's on a single machine is a bit tricky imho.
> 
> If that machine fails you would loose 45 OSD's at once, that will put a lot of stress on the recovery of your cluster.
> 
> You'd also need a lot of RAM to accommodate those 45 OSD's, at least 48GB of RAM I guess.
> 
> A last note, if you use a SSD for your journaling, make sure that you align your partitions which the page size of the SSD, otherwise you'd run into the write amplification of the SSD, resulting in a performance loss.
> 
> Wido
> 
> > One final related question, if I were to use #1 method (which I would prefer if there is no material performance or other reason to use #2), then that specification (i.e. the "osd journal = /dev/sdb") SSD disk reference would have to be identical on all other hardware nodes, yes (I want to use the same ceph.conf file on all servers per the doco recommendations)? What would happen if for example, the SSD was on /dev/sde on a new node added into the cluster? References to /dev/disk/by-id etc are clearly no help, so should a symlink be used from the get-go? Eg something like "ln -s /dev/sdb /srv/ssd" on one box, and  "ln -s /dev/sde /srv/ssd" on the other box, so that in the [osd] section we could use this line which would find the SSD disk on all nodes "osd journal = /srv/ssd"?
> >
> > Many thanks for any advice provided.
> >
> > Cheers
> >
> > Paul
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html




