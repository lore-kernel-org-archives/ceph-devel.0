From: Sage Weil <sage@newdream.net>
Subject: Re: CEPH_OSD_TMAP_SET in librados.h
Date: Thu, 27 May 2010 11:50:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005271150070.27661@cobra.newdream.net>
References: <AANLkTinw76aIGD2pH67r-KDxSScAWJ7cRvrPliDnYl09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44622 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0E0Sus (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 May 2010 14:50:48 -0400
In-Reply-To: <AANLkTinw76aIGD2pH67r-KDxSScAWJ7cRvrPliDnYl09@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 May 2010, Christian Brunner wrote:
> while preparing the next qemu patch I realized that you need
> ceph-unstable now to build the qemu-rbd driver.
> 
> This is because CEPH_OSD_TMAP_SET is only defined in librados.h
> unstable. Could you please apply the patch in testing, too?
> 
> I guess I'm to late for 0.20.2, but I would like to state in my mail
> to the qemu list that it will work with 0.20.3.

Whoops, sorry about that.  I cherry-picked it into the testing branch and 
it'll be in 0.20.3.

sage
