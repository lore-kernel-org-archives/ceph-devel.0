From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Throughput increase by LACP bonding
Date: Tue, 3 Jul 2012 06:56:24 -0400
Message-ID: <20120703105624.GA10864@hmsreliant.think-freely.org>
References: <loom.20120703T093148-928@post.gmane.org>
 <4FF2A834.3080400@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35398 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab2GCK4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 06:56:37 -0400
Content-Disposition: inline
In-Reply-To: <4FF2A834.3080400@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Madhusudhana U <madhusudhana.u.acharya@gmail.com>, ceph-devel@vger.kernel.org

On Tue, Jul 03, 2012 at 10:07:16AM +0200, Wido den Hollander wrote:
> 
> 
> On 03-07-12 09:42, Madhusudhana U wrote:
> >Hi all,
> >I am trying to increase the throughput in the cluster by enabling
> >LACP on both in clients and all ceph cluster nodes. Each client and
> >ceph nodes has two 1G Ethernet interface which I want to aggregate
> >and make it 2G. LACP has been configured at switch side too. But even after
> >the configuration, I am not seeing any through put increase in ceph tell osd
> >bench command and also dd. They are taking the same amount as earlier. I am
> >constantly seeing around 100MB/sec throughput in both DD and ceph bench
> >commands. Can someone suggest me how i can increase the throughput of the
> >cluster ? Below are my configurations.
> 
> Can you verify if both NIC's are actually doing something? Use
> bwm-ng for example?
> 
> Wido
> 
I would imagine they aren't, as the output hash function for 802.3ad trunking is
based on source and destination address, so if your test just writes from a
single client to a single OSD, it will just use one link.
Neil

> >
> >	No of OSD's 	: 5
> >	No of MON's 	: 3
> >	No of MDS's	: 2
> >	Linux Kernel	: 3.4.4
> >	Ceph version	: 0.47.3
> >         Hard disks      : 2x160G SAS drives (raid 0 configuration)
> >         CPU             : Intel(R) Xeon(R) Quad CPU E5506  @ 2.13GHz
> >         Memory          : 6G
> >
> >Thanks
> >__M
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
