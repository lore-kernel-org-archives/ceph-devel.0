From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: infernalis feature freeze
Date: Thu, 13 Aug 2015 14:26:36 -0700
Message-ID: <55CD0B8C.6090907@redhat.com>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43440 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbHMV0g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Aug 2015 17:26:36 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id E62E6A97
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2015 21:26:35 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

It'd be nice to get omap in the python bindings, it's been a pain not
having it several times:

https://github.com/ceph/ceph/pull/5272

On 08/12/2015 02:20 PM, Sage Weil wrote:
> The infernalis feature freeze is coming up Real Soon Now.  I've marked
> some of the pull requests on github that I would like to see merged.
> Please take a look:
>
> 	https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ainfernalis
>
> Ideally we should focus our testing efforts on whatever is on this list.
>
> I didn't look at the bug fix PRs carefully since generally these go in
> once tested regardless of any feature freeze, but I suggest we mark things
> that need to make it into infernalis anyway so that we focus our efforts.
>
> The big items on my list that are pending testing are:
>
> 	wip-newstore-sort (teuthology running now)
> 	wip-newstore (will be marked experimental)
> 	wip-osd-compat (enforces upgrades include hammer, needs qa)
> 	wip-user (run daemons as user 'ceph')
> 	proxy writes (Sam is testing this)
> 	bufferlist tuning (performance)
> 	MOSDOp staged decoding (performance)
>
> There's tons of other stuff pending that is not on this list.  As always,
> our ability to merge code is limited primarily on our ability to test
> it--we can't afford to destabilize core ceph by merging something that we
> aren't confident will work correctly and will not easily break down the
> line.  If you have something pending that you want to get in, the single
> biggest thing you can do to help that happen is to write more or better
> tests for it (e.g., things that run during 'make check') and to run the
> teuthology regression suite (see Loic's recent blogs about doing this with
> OpenStack[1]).
>
> Thanks!
> sage
>
> [1] http://dachary.org/?p=3852

