From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: ocf script for ceph quorum check and fs
Date: Wed, 7 Aug 2013 03:45:02 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E82AFA@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B62E74783@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:55333 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab3HGDpG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 23:45:06 -0400
Received: from bitcom1.int.sbss.com.au ([2001:388:e000:712:a5ca:4fd3:14f:ad5d])
	by smtp1.bendigoit.com.au with esmtp (Exim 4.69)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1V6ugT-0003ei-AQ
	for ceph-devel@vger.kernel.org; Wed, 07 Aug 2013 13:45:13 +1000
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E74783@BITCOM1.int.sbss.com.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> I want to mount ceph fs (using fuse) but /etc/fstab treats it as a local
> filesystem and so tries to mount it before ceph is started, or indeed before
> the network is even up.
> 
> Also, ceph tries to start before the network is up and fails because it can't
> bind to an address. I think this is because I'm using openvswitch which is
> starting later.
> 
> Anyway, controlling it all via pacemaker seems like a much smarter thing to
> do as I can ensure that ceph doesn't start until the network is up (which it will
> be when pacemaker has quorum), and then the fs doesn't mount until ceph
> is started and the ceph cluster has quorum and maybe until an mds is
> running.
> 
> So to do this I need ocf scripts for:
> 
> . starting components of ceph, which appears to be provided by ceph-
> resource-agents.deb, but I haven't tested yet
> . checking ceph quorum - I guess I'd need to write a script for this like existing
> ping check
> . checking mds is available - maybe part of the mount script
> . mount using ceph-fuse. Existing fs scripts make assumptions about fs types
> and parameters and don't work
> 
> Has anyone written a 'check_ceph_quorum' script? Or a fs mount script that
> is compatible with fuse? I don't want to re-invent any wheels!
> 

I have written a ceph_check RA that sets a value in the CIB if the ceph cluster has quorum, and another to mount the fuse fs, although I think maybe it would be better to fix the bug in the existing pacemaker RA to allow mounting fuse properly.

Is anyone interested enough for me to clean it up a bit and post it?

James
