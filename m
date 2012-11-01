From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 1 Nov 2012 10:28:50 -0600
Message-ID: <CALFpzo7+vGuPN-sF2WZR1E2HKvGScQAyjx1nuCZ4GGnoMFbxgw@mail.gmail.com>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
	<0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro>
	<24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
	<CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
	<CALFpzo7dMm2EUGh2-Tzx33+PFh=BqB342wE2mh_4dgmWAggsQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50968 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762027Ab2KAQ2w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 12:28:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2734074oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 09:28:51 -0700 (PDT)
In-Reply-To: <CALFpzo7dMm2EUGh2-Tzx33+PFh=BqB342wE2mh_4dgmWAggsQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Actually that didn't illustrate my point very well, since you see
individual requests being sent to the driver without waiting for
individual completion, but if you look at the full output you can see
that once the queue is full, you're at the mercy of waiting for
individual IOs to complete before sending new ones. Sometimes it's one
at a time, sometimes you get 3-4 completed and can insert a few at
once. I think this is countered by the fact that there's roundtrip
network latency in sending the request and in receiving the result.

For the record, I'm not saying that it's the entire reason why the
performance is lower (obviously since iscsi is better), I'm just
saying that when you're talking about high iops, adding 100us (best
case gigabit) to each request and response is significant. If an io
takes 25us locally (for example an SSD can do 40k iops or more at a
queue depth of 1), and you share that storage over gigabit, you just
increased the latency by an order of magnitude, and as seen there is
only so much simultaneous io going on when the queue depth is raised.
Add to that that multipathing isn't doing parallel but interleaving,
and extra traffic for distributed storage.
