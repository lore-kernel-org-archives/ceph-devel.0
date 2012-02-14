From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Which SSD method is better for performance?
Date: Tue, 14 Feb 2012 13:45:58 +0100
Message-ID: <4F3A5786.7060006@widodh.nl>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39164 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab2BNMqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 07:46:04 -0500
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
> G'day all
>
> About to commence an R&D eval of the Ceph platform having been impressed with the momentum achieved over the past 12mths.
>
> I have one question re design before rolling out to metal........
>
> I will be using 1x SSD drive per storage server node (assume it is /dev/sdb for this discussion), and cannot readily determine the pro/con's for the two methods of using it for OSD-Journal, being:
> #1. place it in the main [osd] stanza and reference the whole drive as a single partition; or

That won't work. If you do that all OSD's will try to open the journal. 
The journal for each OSD has to be unique.

> #2. partition up the disk, so 1x partition per SATA HDD, and place each partition in the [osd.N] portion

That would be your best option.

I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf

the VG "data" is placed on a SSD (Intel X25-M).

>
> So if I were to code #1 in the ceph.conf file, it would be:
> [osd]
> osd journal = /dev/sdb
>
> Or, #2 would be like:
> [osd.0]
>          host = ceph1
>          btrfs devs = /dev/sdc
>          osd journal = /dev/sdb5
> [osd.1]
>          host = ceph1
>          btrfs devs = /dev/sdd
>          osd journal = /dev/sdb6
> [osd.2]
>          host = ceph1
>          btrfs devs = /dev/sde
>          osd journal = /dev/sdb7
> [osd.3]
>          host = ceph1
>          btrfs devs = /dev/sdf
>          osd journal = /dev/sdb8
>
> I am asking therefore, is the added work (and constraints) of specifying down to individual partitions per #2 worth it in performance gains? Does it not also have a constraint, in that if I wanted to add more HDD's into the server (we buy 45 bay units, and typically provision HDD's "on demand" i.e. 15x at a time as usage grows), I would have to additionally partition the SSD (taking it offline) - but if it were #1 option, I would only have to add more [osd.N] sections (and not have to worry about getting the SSD with 45x partitions)?
>

You'd still have to go for #2. However, running 45 OSD's on a single 
machine is a bit tricky imho.

If that machine fails you would loose 45 OSD's at once, that will put a 
lot of stress on the recovery of your cluster.

You'd also need a lot of RAM to accommodate those 45 OSD's, at least 
48GB of RAM I guess.

A last note, if you use a SSD for your journaling, make sure that you 
align your partitions which the page size of the SSD, otherwise you'd 
run into the write amplification of the SSD, resulting in a performance 
loss.

Wido

> One final related question, if I were to use #1 method (which I would prefer if there is no material performance or other reason to use #2), then that specification (i.e. the "osd journal = /dev/sdb") SSD disk reference would have to be identical on all other hardware nodes, yes (I want to use the same ceph.conf file on all servers per the doco recommendations)? What would happen if for example, the SSD was on /dev/sde on a new node added into the cluster? References to /dev/disk/by-id etc are clearly no help, so should a symlink be used from the get-go? Eg something like "ln -s /dev/sdb /srv/ssd" on one box, and  "ln -s /dev/sde /srv/ssd" on the other box, so that in the [osd] section we could use this line which would find the SSD disk on all nodes "osd journal = /srv/ssd"?
>
> Many thanks for any advice provided.
>
> Cheers
>
> Paul
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

