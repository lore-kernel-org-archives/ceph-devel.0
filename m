From: sellers <cgseller@gmail.com>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Wed, 12 Mar 2014 18:48:24 +0000 (UTC)
Message-ID: <loom.20140312T194731-555@post.gmane.org>
References: <loom.20120826T033818-148@post.gmane.org> <503A2142.2000505@inktank.com> <loom.20120827T063044-980@post.gmane.org> <loom.20120829T153702-223@post.gmane.org> <503E1E25.6060704@smart-weblications.de> <loom.20120830T055024-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47279 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaCLTAG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Mar 2014 15:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1WNoNn-0006VM-MC
	for ceph-devel@vger.kernel.org; Wed, 12 Mar 2014 20:00:04 +0100
Received: from arbor.net ([50.16.207.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 20:00:03 +0100
Received: from cgseller by arbor.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 20:00:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ramu eppa <ramu.freesystems <at> gmail.com> writes:

> 
> Hi Wiessner,
> 
>    Actually I created zpool and this is mounted to /dev/sdb and then set a 
> mountpint to osd.The space showing is 144GB.But the osd's are going down
after 
> rbd image is while running.
> 
> Thanks,
> Ramu.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


I found I get a similar message if I have allocated an iscsi target device
pre-partitioned with a primary partition using the entire device.   If I
left some space and created an extended partition, it worked fine.  

YMMV

