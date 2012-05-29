From: madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Re: NFS re-exporting CEPH cluster
Date: Tue, 29 May 2012 14:18:08 +0000 (UTC)
Message-ID: <loom.20120529T161529-853@post.gmane.org>
References: <loom.20120524T071113-43@post.gmane.org> <EAA87E18111B4AFFB0F9758A2C6F2C67@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36469 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab2E2OSZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 May 2012 10:18:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SZNFc-000866-Uq
	for ceph-devel@vger.kernel.org; Tue, 29 May 2012 16:18:23 +0200
Received: from Static-39.108.99.14.tataidc.co.in ([Static-39.108.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 16:18:20 +0200
Received: from madhusudhana.u.acharya by Static-39.108.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 16:18:20 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Greg Farnum <greg <at> inktank.com> writes:

> 
> Have you tried something and it failed? Or are you looking for suggestions?
> If the former, please report the failure. :)
> If the latter: http://ceph.com/wiki/Re-exporting_NFS
> -Greg

Greg,
I have tried the link. But, my production build (t_make) is failing on the
NFS exported ceph_cluster where as it runs fine over another NFS directory
coming from a NFS server.

Is CEPH is 100% compatible with NFS ?

Thanks
__M

