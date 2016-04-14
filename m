From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Thu, 14 Apr 2016 09:57:00 +0900
Message-ID: <20160414095700.0905a422@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<570C9D03.6020701@speedpartner.de>
	<20160413112930.49906f15@batzmaru.gol.ad.jp>
	<alpine.DEB.2.11.1604130829000.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:39974 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcDNA5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 20:57:07 -0400
In-Reply-To: <alpine.DEB.2.11.1604130829000.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-users@ceph.com, Michael Metz-Martini | SpeedPartner GmbH <metz@speedpartner.de>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On Wed, 13 Apr 2016 08:30:52 -0400 (EDT) Sage Weil wrote:

> On Wed, 13 Apr 2016, Christian Balzer wrote:
> > > > Recently we discovered an issue with the long object name handling
> > > > that is not fixable without rewriting a significant chunk of
> > > > FileStores filename handling.  (There is a limit in the amount of
> > > > xattr data ext4 can store in the inode, which causes problems in
> > > > LFNIndex.)
> > > We're only using cephfs so we shouldn't be affected by your
> > > discovered bug, right?
> > > 
> > I don't use CephFS, but you should be able to tell this yourself by
> > doing a "rados -p <poolname> ls" on your data and metadata pools and
> > see the resulting name lengths.
> > However since you have so many objects, I'd do that on a test cluster,
> > if you have one. ^o^
> > If CephFS is using the same/similar hashing to create object names as
> > it does with RBD images I'd imagine you're OK.
> 
> All of CephFS's object names are short, like RBD's.
> 
Sweet!

> For RBD, there is only one object per image that is long: rbd_id.$name.  
> As long as your RBD image names are "short" (a max length of 256 chars
> is enough to make ext4 happy) you'll be fine.
> 
No worries there, ganeti definitely creates them way shorter than that and
IIRC so do Open(Stack/Nebula).

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
