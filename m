From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch won't come online
Date: Thu, 15 Apr 2010 14:49:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004151420100.15369@cobra.newdream.net>
References: <1271354193.3520.6.camel@wido-laptop.pcextreme.nl>
 <Pine.LNX.4.64.1004151101460.15369@cobra.newdream.net>
 <1271365867.3520.7.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48437 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293Ab0DOVrc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 17:47:32 -0400
In-Reply-To: <1271365867.3520.7.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

On Thu, 15 Apr 2010, Wido den Hollander wrote:
> Hi Sage,
> 
> I tried "debug filestore = 20" but it didn't seem to change much, see
> that attached log.
> 
> I also attach my ceph.conf, any errors on my side?

Ok, the problem is that snap_1 already exists (probably others, too).  I 
just pushed a fix to unstable that makes the osd more carefully remove old 
directories or subvols it finds during the mkfs process which should fix 
your problem.  Alternatively, you can mkfs.btrfs beforehand to make sure 
there's nothing old in the osd data dir, or pass --mkbtrfs to mkcephfs and 
let it do the mkfs.btrfs for you.

sage
