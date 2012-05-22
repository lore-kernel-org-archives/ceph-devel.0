From: Grant Ashman <grant.ashman@mach.com.au>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 12:02:58 +0000 (UTC)
Message-ID: <loom.20120522T135204-38@post.gmane.org>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10> <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34280 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2EVMZF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 08:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWo99-0004Ic-My
	for ceph-devel@vger.kernel.org; Tue, 22 May 2012 14:25:04 +0200
Received: from 60-240-78-43.static.tpgi.com.au ([60.240.78.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 14:25:03 +0200
Received: from grant.ashman by 60-240-78-43.static.tpgi.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 14:25:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tommi Virtanen <tommi.virtanen <at> dreamhost.com> writes:
> 
> You don't mount pools directly; there's filesystem metadata (as
> managed by metadata servers) that is needed too.
> 
> What you probably want is to specify that a subtree of your ceph dfs
> stores the file data in a separate pool, using "cephfs
> /mnt/ceph/some/subtree set_layout --pool 6". Note that a numerical
> pool id is currently required.
> 
> http://ceph.newdream.net/docs/master/man/8/cephfs/
> 
> You can mount any subtree of the ceph dfs directly, using
> 10.32.0.10:6789:/some/subtree in your mount command.
> 

Hi Tommi,

We have tried setting the layout as described below with:
'cephfs /mnt/ceph-backup/ set_layout --pool 3'

However, I only ever receive the following output;
'Error setting layout: Invalid argument'

I can run other view the current layout of the mount 
point, but cannot change the pool layout.

My understanding of the numeric pool is as follows:

root@dsan-test:/mnt# ceph osd dump -o -|grep 'pool'
pool 0 'data' rep size 2 crush_ruleset 0
pool 1 'metadata' rep size 2 crush_ruleset 1
pool 2 'rbd' rep size 2 crush_ruleset 2
pool 3 'backup' rep size 2 crush_ruleset 0 

(omitted detail I thought unnecessary)

Therefore the backup pool which we specifically want to mount is 3?

Are you able to assist with the syntax for cephfs set_layout?

Thanks
Grant

