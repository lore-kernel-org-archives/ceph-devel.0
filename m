From: Sage Weil <sage@newdream.net>
Subject: Re: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 09:54:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006110952020.20973@cobra.newdream.net>
References: <hutgsk$oh4$1@dough.gmane.org> <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
 <Pine.LNX.4.64.1006110938120.20973@cobra.newdream.net> <hutpad$p9t$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59925 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0FKQyU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jun 2010 12:54:20 -0400
In-Reply-To: <hutpad$p9t$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Niemayer <niemayer@isg.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 11 Jun 2010, Peter Niemayer wrote:
> On 06/11/2010 06:40 PM, Sage Weil wrote:
> > The btrfs isn't required for consistency if the writeahead journal is
> > enabled (which it is by default).  However, at the moment the code that
> > controls trimming the journal assumes ext3 data=ordered fsync semantics
> > (fsync flushes the entire journal and all prior writes).  This needs a
> > little bit of work to do the right thing with ext4 and xfs.
> > 
> > So: I would stick with btrfs or ext3 for now if you want recovery to work
> > reliably!
> 
> The recovery you are referring to, here, is that an operation required...
> 
> a) after an outage that involved many/all redundant OSDs
> b) after a physical failure of one underlying storage device
> c) after every disconnect/reconnect of Ceph nodes

After an OSD node crash.  

The challenge is keeping the contents of the osd data dir in a fully 
consistent state.  The writeahead journal lets us do that, but it needs to 
know when previous operations have fully committed to disk so it can trim.  
Currently there's a simple fsync() in there to do that, but something 
trickier is required for ext4 and xfs.  A per-mount sync(2) type operation 
would be ideal.

sage
