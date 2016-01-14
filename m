From: Sage Weil <sweil@redhat.com>
Subject: Re: Regarding bluestore release schedule
Date: Thu, 14 Jan 2016 09:08:21 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601140906070.26381@cpach.fuggernut.com>
References: <4EFB79CD-2601-4ABF-96DB-AAF6A90D0036@ict.ac.cn> <alpine.DEB.2.11.1601130842560.26381@cpach.fuggernut.com> <84CAA53B-B2B6-4F2A-B199-32534733068F@ict.ac.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbcANOIR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jan 2016 09:08:17 -0500
In-Reply-To: <84CAA53B-B2B6-4F2A-B199-32534733068F@ict.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Huan <zhanghuan@ict.ac.cn>
Cc: ceph-devel@vger.kernel.org

On Thu, 14 Jan 2016, Zhang Huan wrote:
> > The collection->lock doesn't need to be broken up since it's hidden 
> > beneath the OSD's per-pg lock anyway.  
> Thanks, I found the per-pg lock. If there exist per-pg locks, the
> per-collection locks are actually not needed?

If OSD were the only user, almost.. there are a few cases where PGs 
touch the snapmapper object in the meta collection.  They also make it 
possible for other parts of the system to access the store.  For example, 
FuseStore (see https://github.com/ceph/ceph/pull/7134) lets you expose a 
running ObjectStore via fuse on a running OSD for diagnostic/debugging 
purposes.

sage
