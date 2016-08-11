From: Sage Weil <sweil@redhat.com>
Subject: RE: Bluestore assert
Date: Thu, 11 Aug 2016 16:29:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608111629170.17762@piezo.us.to>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>  <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbcHKQ3k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 12:29:40 -0400
In-Reply-To: <BL2PR02MB2115CDD714FC3883028291F8F41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Somnath Roy wrote:
> Sage,
> Please find the full log for the BlueFS replay bug in the following location.
> 
> https://github.com/somnathr/ceph/blob/master/ceph-osd.1.log.zip
> 
> For the db transaction one , I have added code to dump the rocksdb error code before the assert as you suggested and waiting to reproduce.

I'm pretty sure this is the root cause:

	https://github.com/ceph/ceph/pull/10686

sage
