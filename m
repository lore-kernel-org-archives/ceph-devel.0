From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph] CephFS Quota Support V3 (#2241)
Date: Fri, 9 Jan 2015 14:30:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501091429000.5967@cobra.newdream.net>
References: <ceph/ceph/pull/2241@github.com> <ceph/ceph/pull/2241/c66294395@github.com> <548FA0BB.8060204@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbbAIWa6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 17:30:58 -0500
In-Reply-To: <548FA0BB.8060204@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>
Cc: gfarnum@redhat.com, ceph-devel@vger.kernel.org

Hi Yunchuan, Li!

We're seeing two bugs/failures with the quota code:

32-bit build issue:
	http://tracker.ceph.com/issues/10503

regular test failures:
	http://tracker.ceph.com/issues/10416

Do you have time to take a look?

Thanks!
sage
