From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: v0.56.1 released
Date: Tue, 08 Jan 2013 06:15:04 +0100
Message-ID: <50EBAB58.4090407@conversis.de>
References: <alpine.DEB.2.00.1301072052180.20676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:60353 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3AHFPH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 00:15:07 -0500
In-Reply-To: <alpine.DEB.2.00.1301072052180.20676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

FYI I just updated from 0.56 to 0.56.1 using the RPMs for CentOS 6 (osd and
mon only) and everything went perfectly fine. Thanks!

Regards,
  Dennis

On 01/08/2013 05:53 AM, Sage Weil wrote:
> We found a few critical problems with v0.56, and fixed a few outstanding 
> problems. v0.56.1 is ready, and we're pretty pleased with it!
> 
> There are two critical fixes in this update: a fix for possible data loss 
> or corruption if power is lost, and a protocol compatibility problem that 
> was introduced in v0.56 (between v0.56 and any other version of ceph).
> 
>  * osd: fix commit sequence for XFS, ext4 (or any other non-btrfs) to 
>    prevent data loss on power cycle or kernel panic
>  * osd: fix compatibility for CALL operation
>  * osd: process old osdmaps prior to joining cluster (fixes slow startup)
>  * osd: fix a couple of recovery-related crashes
>  * osd: fix large io requests when journal is in (non-default) aio mode
>  * log: fix possible deadlock in logging code
> 
> This release will kick off the bobtail backport series, and will get a 
> shiny new URL for it's home.
> 
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.56.1.tar.gz
>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

