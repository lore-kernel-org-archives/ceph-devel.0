From: Sage Weil <sage@newdream.net>
Subject: Re: Bug #630
Date: Thu, 24 Feb 2011 07:36:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102240734200.28922@cobra.newdream.net>
References: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57761 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab1BXPet (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 10:34:49 -0500
In-Reply-To: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 24 Feb 2011, Henry Chang wrote:
> I want to confirm if the following problem is related to Bug #630.
> 
> Step 1. On client A, create a file of 10G by dd.
> "ceph -w" shows the total data size increased by 10G.
> 
> Step 2. On client B, touch the file.
> 
> Step 3. On client A, remove the file.
> "ceph -w" shows the total data size is NOT decreased.
> 
> Step 4. Umount ceph on client B.
> "ceph -w" shows the total data size decreased by 10G.

It is.  The bug is that the data doesn't get removed until the inode drops 
out of the inode cche on client B, and there is currently no hint from the 
MDS that it has been unlinked, so that takes however long it takes for the 
VFS to get around to it on its own accord.

The plan is for the MDS to push a caps message informing client B that 
nlink==0 so that it can prod the VFS into trimming the inode.

sage
