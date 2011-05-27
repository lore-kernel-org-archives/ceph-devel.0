From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: OSD crash
Date: Sat, 28 May 2011 01:52:38 +0300
Message-ID: <4DE02B36.2020007@ufm.su>
References: <4DDEEC7C.8060800@ufm.su>	<BANLkTimxRbM95_LMJwAa+oUwj-HAePJM+Q@mail.gmail.com>	<4DDFD44E.8070305@ufm.su>	<BANLkTinGoEpm3C22HuPN2dH8wsVWPuAFgA@mail.gmail.com> <BANLkTinQmX5HnzaxQE11Mst9Pjei7j90FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:50233 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab1E0Wwk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2011 18:52:40 -0400
In-Reply-To: <BANLkTinQmX5HnzaxQE11Mst9Pjei7j90FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/27/2011 10:18 PM, Gregory Farnum wrote:
> Can you check out the recoverywq_fix branch and see if that prevents
> this issue? Or just apply the patch I've included below. :)
> -Greg

Looks as though this patch has helped.
At least this osd has completd rebalancing.
Great! Thanks!

WBR,
     Fyodor.
