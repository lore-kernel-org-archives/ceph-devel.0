From: Sage Weil <sage@newdream.net>
Subject: Re: Hard links (was: Fixing NFS)
Date: Thu, 3 Feb 2011 15:16:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102031513200.19855@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
 <slrnikmdd0.7pe.chris@chris.onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1BCXPX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 18:15:23 -0500
In-Reply-To: <slrnikmdd0.7pe.chris@chris.onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Thu, 3 Feb 2011, Chris Dunlop wrote:
> On 2011-02-03, Sage Weil <sage@newdream.net> wrote:
> > There are a couple of levels of difficulty.  The main problem is that the 
> > only truly stable information in the NFS fh is the inode number, and 
> > Ceph's architecture simply doesn't support lookup-by-ino.  (It uses an 
> > extra table to support it for hard-linked files, under the assumption that 
> > these are relatively rare in the real world.)
> 
> Sorry for the thread hijack, but just so this issue doesn't completely
> fall through the cracks...
> 
> There are different "real worlds" where hard links are very, very
> common. Although, admittedly, ceph may well not be targeted at those
> parallel universes.
> 
> Backup servers are a classic example. It's very common to have
> hard-links between the files for each snapshot. In this situation *most*
> files have multiple hard links, and you can easily have almost all files
> with 60 or more hard links (for 60 or more snapshots). Rsnapshot,
> BackupPC and apparently OSX's Time Machine for instance work this way.

Yep.  These apps will work.. mostly.  The current pain point will be the 
anchor table, which isn't built to scale currently (it's pretty trivial, 
everything in memory).  

Assuming that is addressed, though, these workloads won't be too bad.  The 
nice thing is that these links are usually "parallel" in that all the 
dentries in one dir are hard linked to the same targets in another dir.  
Although the MDS pays a cost looking up the anchor for the first name, the 
result is that it loads the second directory into cache, and the 
subsequent links are also resolve for "free."  The result is a lookup cost 
that is more like O(number of dirs) instead of O(number of files).  

sage
