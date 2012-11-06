From: Denis Fondras <ceph@ledeuns.net>
Subject: Cleaning up CephFS pool
Date: Tue, 06 Nov 2012 20:21:03 +0100
Message-ID: <5099631F.6090802@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:1443 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2KFTVI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 14:21:08 -0500
Received: from [IPv6:2001:7a8:b5ad::10:10] (denis.ledeuns.net [IPv6:2001:7a8:b5ad::10:10])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 8143993264
	for <ceph-devel@vger.kernel.org>; Tue,  6 Nov 2012 20:21:04 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I noticed that removing files on CephFS doesn't reclaim free space using 
ceph version 0.52(commit:e48859474c4944d4ff201ddc9f5fd400e8898173)

I created 2 500GB files on CephFS (mounted with ceph-fuse) and then 
removed them. Now "rados df -p data" shows a 1GB usage :
--8<----------------
pool name       category                 KB      objects       clones 
   degraded      unfound           rd        rd KB           wr        wr KB
data            -                 1048580595       257696            0 
           0           0            0            0       628853   1629192870
--8<----------------

Is there a way to clean it up ? "rados cleanup" needs a prefix I don't 
know...
Of course, I could "rm" every objects but what if I had other files that 
I don't want to remove from CephFS ?

Thanks in advance,
Denis
