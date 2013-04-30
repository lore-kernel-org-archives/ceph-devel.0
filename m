From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: kernel 3.9 / new networking options for RADOS
Date: Tue, 30 Apr 2013 09:52:28 +0200
Message-ID: <20130430075228.GA11012@oder>
References: <alpine.DEB.2.00.1304290837260.644@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:42972 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab3D3HxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 03:53:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304290837260.644@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>

What are the options for RADOS to make use of the new
networking feature in Kernel 3.9 ?

http://www.h-online.com/open/features/What-s-new-in-Linux-3-9-1845705.html

TCP and UDP sockets now support a SO_REUSEPORT option that allows multiple
sockets to listen on the same port. This enables, for example, multiple
web server processes or threads to open individual sockets to listen
on port 80; any connections that come in on this port will be evenly
distributed across the sockets by the kernel.

This approach aims to improve the way workloads are distributed across the
available processor cores. (...) this extension can help avoid bottlenecks
that appear in certain situations when only one thread accepts new
connections and then distributes them across other threads. (...)


Kind Regards,
-Dieter
