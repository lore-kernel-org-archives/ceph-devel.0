From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: client/cluster compatibility testing
Date: Mon, 20 Apr 2015 17:17:54 -0400 (EDT)
Message-ID: <402130240.3271153.1429564674313.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net> <5530229F.5020509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:48069 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbbDTVRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2015 17:17:54 -0400
In-Reply-To: <5530229F.5020509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

We have a PR https://github.com/ceph/ceph-qa-suite/pull/414 that addressed part of this issue, e.g. added hammer-x to the mix (it's ready to be merged).

We also have two tickets where requirements for this suite were captured:
http://tracker.ceph.com/issues/11413
http://tracker.ceph.com/issues/11414

Per Josh's comment "Also I think we'll want to start doing mixed-client-version tests, particularly for things like rbd's exclusive locking", I assigned #11414 for next steps.

Question/request to the team leads - pls either agree with a need to add specific tests for mixed clients testing (and pls add tickets as you feel necessary.) or suggest otherwise.

I am guessing:

rbd - confirmed by Josh, we need those
rados - Sam, Sage?
cephfs - Greg?
rgw - Yehuda?

I am sure I missing lots of others...

What do you think?

Thx
YuriW

----- Original Message -----
From: "Josh Durgin" <jdurgin@redhat.com>
To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
Sent: Thursday, April 16, 2015 1:59:11 PM
Subject: Re: client/cluster compatibility testing

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
