From: Daniel Swarbrick <daniel.swarbrick@profitbricks.com>
Subject: Re: All-Flash Ceph cluster and journal
Date: Mon, 23 Nov 2015 19:39:28 +0100
Message-ID: <n2vmh0$b9p$1@ger.gmane.org>
References: <564DB2A1.9080603@gmail.com> <564DDDE3.9050409@redhat.com>
 <564EF916.5020101@gmail.com>
 <72f50d73f18d4749a6d37748abe03752@R01UKEXCASM115.r01.fujitsu.local>
 <3649A15A2562B54294DE14BCE5AC79120B8FA54F@FMSMSX119.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32987 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbbKWSkd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Nov 2015 13:40:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1a0w1t-0007LO-VJ
	for ceph-devel@vger.kernel.org; Mon, 23 Nov 2015 19:39:58 +0100
Received: from 62.217.45.26 ([62.217.45.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 19:39:57 +0100
Received: from daniel.swarbrick by 62.217.45.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 19:39:57 +0100
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B8FA54F@FMSMSX119.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Simple but clever way of ensuring that NVMe's deep queues aren't starved
of work to do. But doesn't this suggest that Ceph needs optimizing or
tuning for NVMe? Could you not have tweaked OSD parameters to ensure
more threads / IO operations in parallel and have the same effect?

On 23/11/15 18:37, Blinick, Stephen L wrote:
> This link points to a presentation we did a few weeks back where we used NVMe devices for both the data and journal.  We partitioned the devices multiple times to co-locate multiple OSD's per device.  The configuration data on the cluster is in the backup.
> 
> http://www.slideshare.net/Inktank_Ceph/accelerating-cassandra-workloads-on-ceph-with-allflash-pcie-ssds
> 
> Thanks,
> 
> Stephen
> 


