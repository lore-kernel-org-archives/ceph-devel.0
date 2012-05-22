From: Grant Ashman <grant.ashman@mach.com.au>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 21:21:06 +0000 (UTC)
Message-ID: <loom.20120522T231859-65@post.gmane.org>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10> <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com> <loom.20120522T135204-38@post.gmane.org> <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48121 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2EVVVT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 17:21:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWwW4-0006aj-Lb
	for ceph-devel@vger.kernel.org; Tue, 22 May 2012 23:21:16 +0200
Received: from 60-240-78-43.static.tpgi.com.au ([60.240.78.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:21:16 +0200
Received: from grant.ashman by 60-240-78-43.static.tpgi.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:21:16 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Greg Farnum <greg <at> inktank.com> writes:
> That's the right pool ID; yes. I believe the problem is that the cephfs tool 
> currently requires you to fill in
> all the fields, not just the one you wish to change. Try that (setting all the 
> other values to match what you
> see when you view the layout). :)
> -Greg
> 

Hi,

I've tried setting all values the same as the current layout.
Changing only the pool number I still get;

root@dsan-test:# cephfs /mnt/ceph-backup show_layout
layout.data_pool:     0
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1
root@dsan-test:#
root@dsan-test:# cephfs /mnt/ceph-backup set_layout -p 3 -s 4194304 
-u 4194304 -c 1 Error setting layout: Invalid argument

If I leave all values exactly the same i.e '-p 0' the command runs without any 
error output. 
However, changing the pool from anything but 0 results in 'Error 
setting layout: Invalid argument'

Any ideas?

Grant



