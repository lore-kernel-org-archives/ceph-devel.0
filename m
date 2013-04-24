From: Sage Weil <sage@inktank.com>
Subject: Re: Unique bug in ceph start script
Date: Wed, 24 Apr 2013 11:04:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304241104380.2772@cobra.newdream.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net> <20130423064101.GA24976@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304231001160.19511@cobra.newdream.net>
 <20130424075630.GA7395@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33815 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3DXSE5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Apr 2013 14:04:57 -0400
In-Reply-To: <20130424075630.GA7395@upset.ux.pdb.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 24 Apr 2013, Andreas Friedrich wrote:
> On Di, Apr 23, 2013 at 10:01:53 -0700, Sage Weil wrote:
> ...
> > > So in this example two config files with different names but the same
> > > content would be copied to hosta. This is not very pretty but it 
> > > should work without error.
> > 
> > It's because of the $pushed_to list.. for #3 it wouldn't re-push 
> > ceph.conf.  I pushed a patch that just skips that optimization entirely:
> > 
> > https://github.com/ceph/ceph/commit/ccbc4dbc6edf09626459ca52a53a72682f541e86
> > 
> > Look okay to you?
> 
> Yes, but I'm not happy with the trap instruction:
> 
>   trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
> 
> If the start script exits with or without error, the remote config 
> file will be removed from <remote-host>:/tmp - but only for the last 
> host (the former trap calls will be overwritten by the last trap
> call)! This makes no sense to me.

Bah.. I was thinking they would stack.  How about

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 61c10e1..195bf76 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -218,8 +218,11 @@ for name in $what; do
     else
        unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
        scp -q $conf $host:/tmp/ceph.conf.$unique
-       trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
        cur_conf="/tmp/ceph.conf.$unique"
+
+       # clean up on exit
+       remote_configs="$host:/tmp/ceph.conf.$unique $remote_configs"
+       trap 'for f in '$remote_configs' ; do ssh ${f%:*} rm ${f#*:} ; done' EXIT
     fi
     cmd="$cmd -c $cur_conf"
 

??
