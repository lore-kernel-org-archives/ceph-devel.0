From: Greg Farnum <greg@inktank.com>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 10:58:32 -0700
Message-ID: <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
 <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
 <loom.20120522T135204-38@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50239 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab2EVR6h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 13:58:37 -0400
Received: by pbbrp8 with SMTP id rp8so8704866pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 10:58:37 -0700 (PDT)
In-Reply-To: <loom.20120522T135204-38@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Grant Ashman <grant.ashman@mach.com.au>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 5:02 AM, Grant Ashman wrote:
> Tommi Virtanen <tommi.virtanen <at> dreamhost.com (http://dreamhost.com)> writes:
> > 
> > You don't mount pools directly; there's filesystem metadata (as
> > managed by metadata servers) that is needed too.
> > 
> > What you probably want is to specify that a subtree of your ceph dfs
> > stores the file data in a separate pool, using "cephfs
> > /mnt/ceph/some/subtree set_layout --pool 6". Note that a numerical
> > pool id is currently required.
> > 
> > http://ceph.newdream.net/docs/master/man/8/cephfs/
> > 
> > You can mount any subtree of the ceph dfs directly, using
> > 10.32.0.10:6789:/some/subtree in your mount command.
> 
> 
> 
> Hi Tommi,
> 
> We have tried setting the layout as described below with:
> 'cephfs /mnt/ceph-backup/ set_layout --pool 3'
> 
> However, I only ever receive the following output;
> 'Error setting layout: Invalid argument'
> 
> I can run other view the current layout of the mount 
> point, but cannot change the pool layout.
> 
> My understanding of the numeric pool is as follows:
> 
> root@dsan-test:/mnt# ceph osd dump -o -|grep 'pool'
> pool 0 'data' rep size 2 crush_ruleset 0
> pool 1 'metadata' rep size 2 crush_ruleset 1
> pool 2 'rbd' rep size 2 crush_ruleset 2
> pool 3 'backup' rep size 2 crush_ruleset 0 
> 
> (omitted detail I thought unnecessary)
> 
> Therefore the backup pool which we specifically want to mount is 3?
> 
> Are you able to assist with the syntax for cephfs set_layout?
That's the right pool ID; yes. I believe the problem is that the cephfs tool currently requires you to fill in all the fields, not just the one you wish to change. Try that (setting all the other values to match what you see when you view the layout). :)
-Greg


