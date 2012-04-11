From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 12:42:32 +0000 (UTC)
Message-ID: <loom.20120411T143907-211@post.gmane.org>
References: <loom.20120411T093935-734@post.gmane.org> <4F853882.8010001@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54377 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824Ab2DKMpI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Apr 2012 08:45:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SHwv1-000192-Px
	for ceph-devel@vger.kernel.org; Wed, 11 Apr 2012 14:45:03 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 14:45:03 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 14:45:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Stefan Kleijkers <stefan <at> unilogicnetworks.net> writes:

> 
> Hello,
> 
> Yes that's no problem. I'm using that configuration for some time now. 
> Just generate a config with multiple OSD clauses with the same node/host.
> 
> With the newer ceph version mkcephfs is smart enough to detect the osd's 
> on the same node and will generate a crushmap whereby the objects get 
> replicated to different nodes.
> 
> I didn't see any impact on the performance (if you have enough 
> processing power, because you need more of that).
> 
> I wanted to use just a few OSD's per node with mdraid, so I could use 
> RAID6. This way I could swap a faulty disk without bringing the node 
> down. But I couldn't get it stable with mdraid.
> 
This is how my OSD part in ceph.conf looks like

[osd.0]
        host = ceph-node-1
        btrfs devs = /dev/sda6

[osd.1]
        host = ceph-node-2
        btrfs devs = /dev/sda6

[osd.2]
        host = ceph-node-3
        btrfs devs = /dev/sda6

[osd.3]
        host = ceph-node-4
        btrfs devs = /dev/sda6



Can you please help me how I can add multiple OSD in the same machine 
considering that i have 4 partition created for OSD ?

I have powerful machines having 6 quad core Intel Xeon with 48G of RAM







