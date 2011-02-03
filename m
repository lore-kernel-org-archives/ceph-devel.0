From: Chris Dunlop <chris@onthe.net.au>
Subject: Hard links (was: Fixing NFS)
Date: Thu, 3 Feb 2011 23:09:18 +0000 (UTC)
Message-ID: <slrnikmdd0.7pe.chris@chris.onthe.net.au>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
Reply-To: chris@onthe.net.au
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56533 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916Ab1BCXJe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Feb 2011 18:09:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Pl8Iv-0004C9-Rn
	for ceph-devel@vger.kernel.org; Fri, 04 Feb 2011 00:09:33 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Feb 2011 00:09:33 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Feb 2011 00:09:33 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2011-02-03, Sage Weil <sage@newdream.net> wrote:
> There are a couple of levels of difficulty.  The main problem is that the 
> only truly stable information in the NFS fh is the inode number, and 
> Ceph's architecture simply doesn't support lookup-by-ino.  (It uses an 
> extra table to support it for hard-linked files, under the assumption that 
> these are relatively rare in the real world.)

Sorry for the thread hijack, but just so this issue doesn't completely
fall through the cracks...

There are different "real worlds" where hard links are very, very
common. Although, admittedly, ceph may well not be targeted at those
parallel universes.

Backup servers are a classic example. It's very common to have
hard-links between the files for each snapshot. In this situation *most*
files have multiple hard links, and you can easily have almost all files
with 60 or more hard links (for 60 or more snapshots). Rsnapshot,
BackupPC and apparently OSX's Time Machine for instance work this way.

Of course, apps like this would probably be far better off if they
started using proper snapshots (and dedup, if/when that becomes
available, praise the day) provided by file systems such as ceph and
btrfs.

But there are other apps which use significant numbers of hard links,
some examples buried in this thread:

http://thread.gmane.org/gmane.comp.file-systems.btrfs/3427

Cheers,

Chris

