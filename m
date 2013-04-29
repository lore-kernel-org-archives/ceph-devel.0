From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: mount.ceph: modprobe failed
Date: Mon, 29 Apr 2013 06:49:45 -0500
Message-ID: <def4bfdc122665143a614f7487f0b553@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:59864 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab3D2Ltq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Apr 2013 07:49:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

Hello List!


I'd like to report the following bug.

# ceph -v
ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)

Mount.ceph command still attempts to load the ceph (ceph fs) kernel 
module even though it has been compiled into the kernel.  I would 
recommend that the command check /proc/filesystems for the presence of 
the 'ceph' file system, and then only attempt to load the module if it 
isn't present.


The confusing part of the whole bug is that despite the nasty 'modprobe 
failed, exit status 1' message, the command still succeeds to mount the 
ceph fs.  This caught me by surprise.


-- 
Thanks,
Dyweni
