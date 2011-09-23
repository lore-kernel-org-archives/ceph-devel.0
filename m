From: Sage Weil <sage@newdream.net>
Subject: Re: New inode parent information needed for ACL
Date: Thu, 22 Sep 2011 21:53:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109222149410.8663@cobra.newdream.net>
References: <1832752224.18125.1316473523050.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60461 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWExa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 00:53:30 -0400
In-Reply-To: <1832752224.18125.1316473523050.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hey Noah,

Sorry for the slow reply!

On Mon, 19 Sep 2011, Noah Watkins wrote:
> I've been hacking a bit on xattr-based ACLs for Ceph. It's all working
> fine, but I'm having some trouble wiring up the default ACL init code
> for new inodes (mknod, create, mkdir, and symlink): New ACLs depend on
> the the ACL of the parent. The ideal location seems to be in fill_inode,
> but it is unclear how to access the parent inode of the original request
> from fill_inode because it is receiving the filler information just from a
> mds reply. Is getting the parent information in fill_inode possible?
> 
> Alternatively, in each of ceph_mknod, ceph_symlink, etc..., the problem would
> be solved trivially if the new inode is available because the parent information
> is provided. For example, in ceph_mknod, on success will dentry->d_inode alway point
> to the new inode, or is there more async stuff going on?

Let me make sure I understand this: when you create a file, the generic 
linux ACL code gives you a new ACL based on the parent directory.  Is that 
right?

I see two options:
 1- in mknod/mkdir/create/symlink, we generate the new acl and pass it to 
the MDS along with the create request.  "trust the client."
 2- the MDS generates the ACL based on the parent directory.  "trust the 
server."

I think #2 is a more "right" answer, but it also means duplicating 
whatever the ACL logic is on the MDS.  I also suspect #1 is what labeled 
NFS does... :/

In any case, I don't think anything in the reply processing path will be 
right.  The client should only be presenting what the ACL actually is (on 
the server), which means it needs to be part of the request, or generated 
on the MDS...

sage
