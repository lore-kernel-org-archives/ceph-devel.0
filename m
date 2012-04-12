From: Martin Mailand <martin@tuxadero.com>
Subject: wip-librbd-caching
Date: Thu, 12 Apr 2012 21:30:16 +0200
Message-ID: <4F872D48.6070801@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:40051 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761550Ab2DLTaX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 15:30:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>

Hi,

today I tried the wip-librbd-caching branch. The performance improvement 
is very good particular for small writes.
I tested from within a vm with fio:

rbd_cache_enabled=1

fio -name iops -rw=write -size=10G -iodepth 1 -filename /tmp/bigfile 
-ioengine libaio -direct 1 -bs 4k

I get over 10k iops

With an iodepth 4 I get over 30k iops

In comparison with the rbd_writebackwindow I get around 5k iops with an 
iodepth of 1.

So far the whole cluster is running stable for over 12 hours.

But there is also a downside.
My typical vm are 1Gb in size, the default cache size is 200Mb, which is 
20% more memory usage. Maybe 50Mb or less will be enough?
I am going to test that.

The other point is, that the cache is not KSM enabled, therefore 
identical pages will not be merged, could that be changed, what would be 
the downside?

So maybe we could reduce the memory footprint of the cache, but keep 
it's performance.

-martin
