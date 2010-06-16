From: Sage Weil <sage@newdream.net>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
 forever
Date: Wed, 16 Jun 2010 11:56:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006161151420.22082@cobra.newdream.net>
References: <hvaqvm$fdp$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57363 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892Ab0FPSzO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 14:55:14 -0400
In-Reply-To: <hvaqvm$fdp$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Niemayer <niemayer@isg.de>
Cc: ceph-devel@vger.kernel.org

On Wed, 16 Jun 2010, Peter Niemayer wrote:
> Hi,
> 
> trying to "umount" a formerly mounted ceph filesystem that has become
> unavailable (osd crashed, then msd/mon were shut down using /etc/init.d/ceph
> stop) results in "umount" hanging forever in
> "D" state.
> 
> Strangely, "umount -f" started from another terminal reports
> the ceph filesystem as not being mounted anymore, which is consistent
> with what the mount-table says.
> 
> The kernel keeps emitting the following messages from time to time:
> > Jun 16 17:25:29 gitega kernel: ceph:  tid 211912 timed out on osd0, will
> > reset osd
> > Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 connection
> > failed
> > Jun 16 17:26:15 gitega last message repeated 4 times
> 
> I would have expected the "umount" to terminate at least after some generous
> timeout.
> 
> Ceph should probably support something like the "soft,intr" options
> of NFS, because if the only supported way of mounting is one where
> a client is more or less stuck-until-reboot when the service fails,
> many potential test-configurations involving Ceph are way too dangerous
> to try...

Yeah, being able to force it to shut down when servers are unresponsive is 
definitely the intent.  'umount -f' should work.  It sounds like the 
problem is related to the initial 'umount' (which doesn't time out) 
followed by 'umount -f'.

I'm hesitant to add a blanket umount timeout, as that could prevent proper 
writeout of cached data/metadata in some cases.  So I think the goal 
should be that if a normal umount hangs for some reason, you should be 
able to intervene to add the 'force' if things don't go well.

sage
