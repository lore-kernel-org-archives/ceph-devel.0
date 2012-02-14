From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: Which SSD method is better for performance?
Date: Tue, 14 Feb 2012 10:39:34 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf4.mach.net.au ([74.55.157.90]:45451 "EHLO mf4.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab2BNBH3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 20:07:29 -0500
Received: from exch12.ad.mach.net.au (unknown [115.165.169.16])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mf4.mach.net.au (Postfix) with ESMTP id F2D882892F
	for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 10:39:40 +1000 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

G'day all

About to commence an R&D eval of the Ceph platform having been impressed with the momentum achieved over the past 12mths.

I have one question re design before rolling out to metal........

I will be using 1x SSD drive per storage server node (assume it is /dev/sdb for this discussion), and cannot readily determine the pro/con's for the two methods of using it for OSD-Journal, being:
#1. place it in the main [osd] stanza and reference the whole drive as a single partition; or
#2. partition up the disk, so 1x partition per SATA HDD, and place each partition in the [osd.N] portion

So if I were to code #1 in the ceph.conf file, it would be:
[osd]
osd journal = /dev/sdb

Or, #2 would be like:
[osd.0]
        host = ceph1
        btrfs devs = /dev/sdc
        osd journal = /dev/sdb5
[osd.1]
        host = ceph1
        btrfs devs = /dev/sdd
        osd journal = /dev/sdb6
[osd.2]
        host = ceph1
        btrfs devs = /dev/sde
        osd journal = /dev/sdb7
[osd.3]
        host = ceph1
        btrfs devs = /dev/sdf
        osd journal = /dev/sdb8

I am asking therefore, is the added work (and constraints) of specifying down to individual partitions per #2 worth it in performance gains? Does it not also have a constraint, in that if I wanted to add more HDD's into the server (we buy 45 bay units, and typically provision HDD's "on demand" i.e. 15x at a time as usage grows), I would have to additionally partition the SSD (taking it offline) - but if it were #1 option, I would only have to add more [osd.N] sections (and not have to worry about getting the SSD with 45x partitions)?

One final related question, if I were to use #1 method (which I would prefer if there is no material performance or other reason to use #2), then that specification (i.e. the "osd journal = /dev/sdb") SSD disk reference would have to be identical on all other hardware nodes, yes (I want to use the same ceph.conf file on all servers per the doco recommendations)? What would happen if for example, the SSD was on /dev/sde on a new node added into the cluster? References to /dev/disk/by-id etc are clearly no help, so should a symlink be used from the get-go? Eg something like "ln -s /dev/sdb /srv/ssd" on one box, and  "ln -s /dev/sde /srv/ssd" on the other box, so that in the [osd] section we could use this line which would find the SSD disk on all nodes "osd journal = /srv/ssd"?

Many thanks for any advice provided.

Cheers

Paul



