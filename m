From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: slow fio random read benchmark, need help
Date: Thu, 1 Nov 2012 17:00:06 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F755770827F@lisa.maurer-it.com>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
	<0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro>
	<24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
	<CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
	<CALFpzo7dMm2EUGh2-Tzx33+PFh=BqB342wE2mh_4dgmWAggsQA@mail.gmail.com>
 <CALFpzo7+vGuPN-sF2WZR1E2HKvGScQAyjx1nuCZ4GGnoMFbxgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.maurer-it.com ([213.129.239.114]:51633 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2KARAL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 13:00:11 -0400
In-Reply-To: <CALFpzo7+vGuPN-sF2WZR1E2HKvGScQAyjx1nuCZ4GGnoMFbxgw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>, Gregory Farnum <greg@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>


> For the record, I'm not saying that it's the entire reason why the performance
> is lower (obviously since iscsi is better), I'm just saying that when you're
> talking about high iops, adding 100us (best case gigabit) to each request and
> response is significant

iSCSI also uses the network (also adds 100us to esach request), so that simply can't be the reason.

I always thought a distributed block storage could do such things 
faster (or at least as fast) than a single centralized store?

- Dietmar

