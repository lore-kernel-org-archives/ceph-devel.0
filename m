From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: client/cluster compatibility testing
Date: Thu, 16 Apr 2015 13:59:11 -0700
Message-ID: <5530229F.5020509@redhat.com>
References: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbbDPU7I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Apr 2015 16:59:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id D19A2C1F09
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 20:59:08 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 04/16/2015 09:42 AM, Sage Weil wrote:
> I think the simplest way to address this is to talk about compatibility in
> terms of the upstream stable releases (firefly, hammer, etc.), and test
> that compatibility with teuthology tests from ceph-qa-suite.git.  We have
> some basic inter-version client/cluster tests already in
> suites/upgrade/client-upgrade.  Currently these test new (version "x")
> clients against a given release (dumpling, firefly).  I think we just need
> to add hammer to that mix, and then add a second set of tests that do the
> reverse: test clients from a given release (dumpling, firefly, hammer)
> against an arbitrary cluster version ("x").

The suites in suites/upgrade/$version-x do this, and use a mixed
version cluster rather than a purely version x cluster. It seems like
people would want that intra-cluster version coverage for smooth
upgrades.

Just need to add hammer-x there too (Yuri's renaming the client ones to
be $version-client-x for less confusion).

Also I think we'll want to start doing mixed-client-version tests,
particularly for things like rbd's exclusive locking:

http://tracker.ceph.com/issues/11405

Josh
