From: GabrieleB <gabriele.bozzi@kaukana.be>
Subject: Re: ceph messenger compile error on old backport (2.6.32)
Date: Sat, 19 Feb 2011 16:22:21 +0000 (UTC)
Message-ID: <loom.20110219T171654-818@post.gmane.org>
References: <loom.20110219T141159-409@post.gmane.org> <AANLkTin8bMZYru0eXLSVcRdaHzJ2Ldikowc1N5Z3F0_y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59512 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332Ab1BSQWd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Feb 2011 11:22:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PqpZo-0001Lq-8i
	for ceph-devel@vger.kernel.org; Sat, 19 Feb 2011 17:22:32 +0100
Received: from 89.235-240-81.adsl-dyn.isp.belgacom.be ([81.240.235.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 17:22:32 +0100
Received: from gabriele.bozzi by 89.235-240-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 19 Feb 2011 17:22:32 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Henry Chang <henry.cy.chang <at> gmail.com> writes:
>

> 
> For kernel 2.6.32, the simplest wordaround is to revert the following commits:
> 
> c59cb6f net/ceph: make ceph_msgr_wq non-reentrant
> 6b40e7f ceph: fsc->*_wq's aren't used in memory reclaim path
> 
> Cheers,

Great, this did the job.

I had a look at the commits and I thought the first was a good candidate but I
overlooked the second.

Thanks a lot.


