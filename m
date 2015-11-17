From: Sage Weil <sage@newdream.net>
Subject: Re: [CEPH] OSD daemons running with a large number of threads
Date: Tue, 17 Nov 2015 05:40:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511170539010.7964@cobra.newdream.net>
References: <17751_1447748936_564AE548_17751_8310_3_B9C8EFBF13B1354DB5FA000660D66DD00D64D8A0@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59921 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbKQNkq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Nov 2015 08:40:46 -0500
In-Reply-To: <17751_1447748936_564AE548_17751_8310_3_B9C8EFBF13B1354DB5FA000660D66DD00D64D8A0@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 17 Nov 2015, ghislain.chevalier@orange.com wrote:
> Hi,
> 
> Context:
> Firefly 0.80.9
> Ubuntu 14.04.1
> Almost a production platform  in an openstack environment
> 176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 servers in 2 rooms, 3 monitors on openstack controllers
> Usage: Rados Gateway for object service and RBD as back-end for Cinder and Glance
> 
> Issue:
> We are currently running performances tests on this cluster before turning it to production.
> We created cinder volumes (attached to Ceph Back End) on virtual machines and we use FIO to stress the cluster.
> A very large number of threads are created per OSD daemon (about 1000).

This is normal.  The init scripts set the max open files ulimit to a high 
value (usually 4194304 to avoid any possibility of hitting it) but you may 
need to set /proc/sys/kernel/pid_max to something big if your cluster is 
large.

sage
