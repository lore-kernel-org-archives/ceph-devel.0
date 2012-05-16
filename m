From: madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Re: issue with mounting ceph cluster over NFS
Date: Wed, 16 May 2012 11:23:53 +0000 (UTC)
Message-ID: <loom.20120516T131311-8@post.gmane.org>
References: <loom.20120515T173030-954@post.gmane.org> <4FB3588D.60502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967412Ab2EPLYJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 May 2012 07:24:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SUcKr-0003dC-JH
	for ceph-devel@vger.kernel.org; Wed, 16 May 2012 13:24:05 +0200
Received: from 202.164.25.5 ([202.164.25.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 13:24:05 +0200
Received: from madhusudhana.u.acharya by 202.164.25.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 13:24:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


> Is only one MDS active?
Yes only one MDS is active

> Does the build work on ceph-fuse without nfs?
I can't run build without NFS on ceph-fuse because, the build runs on a
cluster (we use LSF for it) where each machine mounts the directory. The 
build is spit into many small jobs [around 800 in number] and dispatched 
to LSF. LSF master host allocates different machines for a bunch of small
jobs. So, in order to successfully complete the build, each LSF host needs
to mount the ceph cluster in the same name( i.e, same mount point name, like
/home/madhusudhana_ceph). So, to get this work, I NFS exported ceph cluster 
from ceph-node-15 using autofs. Each node in LSF cluster has auto mounter map 
replicated used NIS.

> Ceph inodes are always 64-bit. The only exception is ceph-fuse on a
> 32-bit machine, which won't work in general due to the restricted inode
> size.
All my machines are 64b with centos 6.2 running on them. 



