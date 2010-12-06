From: Sage Weil <sage@newdream.net>
Subject: fsck
Date: Sun, 5 Dec 2010 20:59:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012052037510.2155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53369 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0LFEy2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Dec 2010 23:54:28 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B38B3BC715
	for <ceph-devel@vger.kernel.org>; Sun,  5 Dec 2010 20:59:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8B213BC715
	for <ceph-devel@vger.kernel.org>; Sun,  5 Dec 2010 20:59:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

Yehuda, Greg, and I talked for a while last week about how we're going to 
approach disaster recovery/fsck for the MDS.  I'm going to try to 
summarize what we came up with (and reference the relevant issues in the 
tracker) so that people have some idea what the current plan is.

The first failure type is a corrupted, missing, or incomplete MDS journal.  
Because of the complexity of the shared state between MDSs, the simplest 
thing at this point when any single MDS has a journal corruption is to 
simply throw out all of the journals and go into some sort of recovery 
mode.  This results in the loss of some recent changes, but avoids the 
complexity of unraveling the already complex dependencies of journal 
events within and between MDS journals.  See #602.

One prerequisite for that to work is ordering the writeback of directory 
contents when a file is renamed between directories (say from A to B).  
The idea is to write B and then A, so that at worst (i.e. if the journal 
is lost/discarded) we have two links to the file instead of zero.  What to 
do if a file is renamed from B to A is an open issue.  See #601.

The main failure type is then what to do when we have already 
lost/discarded our journals, or we have encountered a missing or corrupt 
directory object.  The current plan is for fsck to do a full traversal of 
the directory hierarchy.  When a missing/corrupt/incomplete directory is 
encountered, it's added to a missing list.  We then need to query the 
object store to scan all directory objects to find any child directories 
of the missing list.  To do this, we maintain an xattr on all directory 
objects that includes all ancestors of that directory (name, inode, inode 
version for each ancestor).  The version lets us disambiguate between 
different paths to a directory when there have been renames but some attrs 
are out of date.  Once we identify the children, we can reconstruct any 
subdirectories in the missing/corrupt directory so that we don't lose that 
whole piece of the namespace.  See #603.

The trick is how to do that scan efficiently.  The plan is to extend the 
OSD class mechanism to include per-pool methods (currently we only support 
adding object methods) so that some special code on the OSDs can iterate 
over objects in the pool PG, parse the ancestor xattrs, look for one or 
more missing items, and return the result.  See #609.

As part of the namespace scan we could/should verify that we don't have 
multiple primary links to the same file.  This is difficult as it 
essentially requires maintaining a huge set of visited ino's.  Bloom 
filters could be used here to speed things up, but memory will definitely 
be an issue; some local temporary storage or something stored in the 
object store.

We can also verify the accuracy of the anchor table while doing the 
hierarchy traversal.  See #605.

That's a pretty rough sketch, but covers things at a high level.  The 
preliminaries are targetted at 0.25 (maintaining ancestor attr, osd class 
changes, and journal discard/recovery mode preliminaries).  The hierarchy 
traversal will be the biggest bit, but work on that will start after the 
holidays.

sage
