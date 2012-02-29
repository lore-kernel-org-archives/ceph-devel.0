From: Alex Elder <elder@dreamhost.com>
Subject: Re: Patch Bomb!
Date: Tue, 28 Feb 2012 19:05:25 -0800
Message-ID: <4F4D95F5.8020806@dreamhost.com>
References: <4F4D89F0.7000107@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42652 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab2B2DFZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:05:25 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8976C24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:05:25 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6CE2224314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:05:25 -0800 (PST)
In-Reply-To: <4F4D89F0.7000107@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 02/28/2012 06:14 PM, Alex Elder wrote:
> Over the next few hours I plan to send out a lot of patches
> for review. Most of these have been around and under test
> for a month or more, and at the time I originally committed
> them I wasn't sure how best to get them reviewed.
>
> We decided that sending them all out to the list was a
> good way to ensure visibility and preserve community
> input. So here goes. From now on I'll send patch series
> out to the list when they're ready rather than hanging on
> to them like this.

One more thing.  The patches are grouped into smaller series
(with some just standing alone).  But they do build on each
other.  They are currently available in order on the ceph-client
git tree, branch "for-review", here:

     https://github.com/NewDreamNetwork/ceph-client/commits/for-review

					-Alex
