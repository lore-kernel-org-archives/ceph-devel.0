From: Sage Weil <sage@newdream.net>
Subject: Re: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 09:40:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006110938120.20973@cobra.newdream.net>
References: <hutgsk$oh4$1@dough.gmane.org> <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33384 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab0FKQkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jun 2010 12:40:09 -0400
In-Reply-To: <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Peter Niemayer <niemayer@isg.de>, ceph-devel@vger.kernel.org

On Fri, 11 Jun 2010, Gregory Farnum wrote:
> That said, btrfs is most beneficial when you engage in snapshotting,
> or have to handle recoveries. Ceph makes use of a number of ioctls to
> ensure consistency and provide speed when running on btrfs; on other
> filesystems snapshots will be much slower, and OSDs will be more
> likely to lose data in the case of a power failure or similar problem.
> If these aren't big problems for you, you can run Ceph on whatever fs
> you like.

Right.

The btrfs isn't required for consistency if the writeahead journal is 
enabled (which it is by default).  However, at the moment the code that 
controls trimming the journal assumes ext3 data=ordered fsync semantics 
(fsync flushes the entire journal and all prior writes).  This needs a 
little bit of work to do the right thing with ext4 and xfs.

So: I would stick with btrfs or ext3 for now if you want recovery to work 
reliably!

sage
