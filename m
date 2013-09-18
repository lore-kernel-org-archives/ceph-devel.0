From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: Rados and user-provided buffers
Date: Wed, 18 Sep 2013 22:31:15 +0200
Message-ID: <l1d2ib$hnd$1@ger.gmane.org>
References: <l1d0jr$jqa$1@ger.gmane.org> <alpine.DEB.2.00.1309181259060.30792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35953 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab3IRUb1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Sep 2013 16:31:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VMOPG-0007r6-FI
	for ceph-devel@vger.kernel.org; Wed, 18 Sep 2013 22:31:26 +0200
Received: from 77-173-143-102.ip.telfort.nl ([77.173.143.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 22:31:26 +0200
Received: from rutger by 77-173-143-102.ip.telfort.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 22:31:26 +0200
In-Reply-To: <alpine.DEB.2.00.1309181259060.30792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2013-09-18 22:01, Sage Weil wrote:
>
> The read-into-existing-buffer is only wired up properly for the C
> interface.  For the C++ it isn't generally necessary: we allocate and read
> the data off the network,a nd pass the reference directly back to the user
> without making another copy.  The 2010 thread is about similarly avoiding
> such a copy for the C API.  We didn't contemplate the situation where you
> specifically want the bytes to go to a particular address via C++.  If
> that's what you need, the C++ API needs to be extended, or you can just
> use the C call for that case.
>
> sage
>

Hey Sage,

my particular use case is a pager that uses Rados as a backend. Striping 
of pages works identical to the striping mechanism of Ceph. Reads and 
writes of multiple pages may be combined into one aio_ call with one 
bufferlist. Pages are allocated by the pager.

AFAICT, the C call provides reading into a contiguous buffer, whereas I 
would like to read into a bufferlist. What would need to be done to add 
support for this in rados?

Thanks,

Rutger



