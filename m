From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] mkcephfs: Actually do a mkfs.btrfs
Date: Thu, 14 Apr 2011 11:39:16 -0700
Message-ID: <20110414183916.GE30604@dreamer>
References: <1301594380-27512-1-git-send-email-wido@widodh.nl>
 <Pine.LNX.4.64.1103311139430.28788@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55108 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab1DNSjQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 14:39:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103311139430.28788@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Thu, Mar 31, 2011 at 11:39:46AM -0700, Sage Weil wrote:
> Ha!  Applied.  :)
> sage
> 
> 
> On Thu, 31 Mar 2011, Wido den Hollander wrote:
> > -    echo mkfs.btrfs $btrfs_devs
> > +    mkfs.btrfs $btrfs_devs

Apparently, this got lost somewhere. Now it's in master,
as commit 08e9855dcdca097f524b9c5fc48ee79a54b9a8ec.

-- 
:(){ :|:&};:
