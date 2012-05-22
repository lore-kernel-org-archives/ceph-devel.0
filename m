From: Grant Ashman <grant.ashman@mach.com.au>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 21:31:06 +0000 (UTC)
Message-ID: <loom.20120522T232520-187@post.gmane.org>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10> <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com> <loom.20120522T135204-38@post.gmane.org> <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com> <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11> <9AF25259E69149DE97352565797966E1@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38111 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab2EVVb2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 17:31:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SWwfr-0005VX-3L
	for ceph-devel@vger.kernel.org; Tue, 22 May 2012 23:31:23 +0200
Received: from 60-240-78-43.static.tpgi.com.au ([60.240.78.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:31:23 +0200
Received: from grant.ashman by 60-240-78-43.static.tpgi.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 23:31:23 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Greg Farnum <greg <at> inktank.com> writes:
> Oh, I got this conversation confused with another one.
> You also need to specify the pool as a valid pool to
> store filesystem data in, if you haven't done that already:
> "ceph mds add_data_pool <poolname>"
> 
> 

Thanks Greg,

However, I still get the same error :(
When I specify the add data pool I get the following:
(with or without the additional values)

root@dsan-test:~# ceph mds add_data_pool backup
added data pool 0 to mdsmap
root@dsan-test:~# cephfs /mnt/ceph-backup set_layout -p 3
Error setting layout: Invalid argument

Seems to be pointing at pool 0 instead of pool 3 like it should?

Sorry if this has all been covered before, I've not found any 
resolution and the ability to mount specific pools I.E "data"
for production data and "backup" for 1N backup data is a huge
priority to begin using Ceph.




