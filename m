From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Wed, 13 Apr 2016 11:29:30 +0900
Message-ID: <20160413112930.49906f15@batzmaru.gol.ad.jp>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<570C9D03.6020701@speedpartner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:53015 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470AbcDMC3j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 22:29:39 -0400
In-Reply-To: <570C9D03.6020701@speedpartner.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com
Cc: Michael Metz-Martini | SpeedPartner GmbH <metz@speedpartner.de>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com


Hello,

On Tue, 12 Apr 2016 09:00:19 +0200 Michael Metz-Martini | SpeedPartner
GmbH wrote:

> Hi,
> 
> Am 11.04.2016 um 23:39 schrieb Sage Weil:
> > ext4 has never been recommended, but we did test it.  After Jewel is
> > out, we would like explicitly recommend *against* ext4 and stop
> > testing it.
> Hmmm. We're currently migrating away from xfs as we had some strange
> performance-issues which were resolved / got better by switching to
> ext4. We think this is related to our high number of objects (4358
> Mobjects according to ceph -s).
> 
It would be interesting to see on how this maps out to the OSDs/PGs.
I'd guess loads and loads of subdirectories per PG, which is probably where
Ext4 performs better than XFS.

> 
> > Recently we discovered an issue with the long object name handling
> > that is not fixable without rewriting a significant chunk of
> > FileStores filename handling.  (There is a limit in the amount of
> > xattr data ext4 can store in the inode, which causes problems in
> > LFNIndex.)
> We're only using cephfs so we shouldn't be affected by your discovered
> bug, right?
> 
I don't use CephFS, but you should be able to tell this yourself by doing
a "rados -p <poolname> ls" on your data and metadata pools and see the
resulting name lengths.
However since you have so many objects, I'd do that on a test cluster, if
you have one. ^o^
If CephFS is using the same/similar hashing to create object names as it
does with RBD images I'd imagine you're OK.

Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
