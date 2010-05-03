From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: mkcephfs 0.20 failure on debian: FAILED assert(r == 0)
Date: Mon, 3 May 2010 06:18:42 +0000 (UTC)
Message-ID: <hrlps2$bk3$1@dough.gmane.org>
References: <hrhh53$gf3$2@dough.gmane.org>
	<Pine.LNX.4.64.1005021501240.32001@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56177 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab0ECGS5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 May 2010 02:18:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1O8ozV-0001Ax-RA
	for ceph-devel@vger.kernel.org; Mon, 03 May 2010 08:18:53 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 May 2010 08:18:53 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 May 2010 08:18:53 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi sage

> It sounds like the osd journal file exists, but is 0 bytes.  You can
> include
> 
> 	osd journal size = 100    ; measured in MB
> 
> to your ceph.conf and it will be resized during mkfs (iff it is 0
> bytes). Or use 'dd'.  Or (better yet) point it at a raw block device.
> 

ok, this worked.



> I'm fixing up the error handling to return an error instead of
> asserting.
> 
>> .. and what happend to the ceph-kclient-source package?
> 
> Well, I'm not sure if we should keep building that package.  The kernel
> client versioning is somewhat divorced from the server side now that the
> client is in the mainline kernel (and releases are dictated by kernel
> releases).  But I take it people use that package?  I suppose as long as
> there is some 'stable' release that coincides with the final kernel
> release (e.g., v0.20.1 for v2.6.34 in a few weeks, in this case).

debian squeeze will be released with kernel 2.6.32 - so it won't have the 
upstream ceph module. 

the kvm project releases "kvm-kmod" source tarballs numberd like the 
kernel for use with older kernels. something like that would be nice. 

even more nice would be a dkms* package. maybe i get the time this week 
to try creating one. 

- Thomas

* http://linux.die.net/man/8/dkms

