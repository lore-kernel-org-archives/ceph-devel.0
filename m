From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: infernalis feature freeze
Date: Thu, 13 Aug 2015 10:46:47 +0800
Message-ID: <55CC0517.4050909@ubuntukylin.com>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:44343 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbbHMCrD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 22:47:03 -0400
In-Reply-To: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi Sage,
   Hope these two get a chance, they are both straightforward, and
useful for cache tiering.
https://github.com/ceph/ceph/pull/5362
https://github.com/ceph/ceph/pull/5473

Cheers,
Li Wang

On 2015/8/13 5:20, Sage Weil wrote:
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
