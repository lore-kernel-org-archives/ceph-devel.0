From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: jewel v10.2.1 status update
Date: Wed, 11 May 2016 00:21:48 +0000
Message-ID: <robbat2-20160511T001522-032231734Z@orbis-terrarum.net>
References: <5731B60E.3090603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:37824 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbcEKAVt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2016 20:21:49 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 9A063340B35
	for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 00:21:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5731B60E.3090603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 10, 2016 at 12:21:02PM +0200,  Loic Dachary wrote:
> Hi,
> 
> All jewel pull requests (
> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ajewel
> ) except two ( https://github.com/ceph/ceph/pull/8868 and
> https://github.com/ceph/ceph/pull/9010 ) have been merged into the
> jewel-backports integration branch (
> http://tracker.ceph.com/issues/15317#note-4 ). They include all
> backports done by Yehuda and Jason (except 9010) in the past 24h
> hours. The suites are going to be scheduled later today (when
> gitbuilder is done creating the packages) and their progress can be
> tracked at http://tracker.ceph.com/issues/15317#note-5 etc.

I've been waiting 3 weeks now for my staticsites PRs to be merged :-(.
https://github.com/ceph/ceph/pull/8633
https://github.com/ceph/ceph/pull/8669

The matching issues:
http://tracker.ceph.com/issues/15531
http://tracker.ceph.com/issues/15532

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
