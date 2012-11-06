From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: BUG: kvm crashing in void librbd::AioCompletion::complete_request
Date: Tue, 06 Nov 2012 10:28:25 +0100
Message-ID: <5098D839.2040704@profihost.ag>
References: <3de2d3a8-8e11-4a68-9198-7f25bbf8fd49@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44695 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab2KFJ23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 04:28:29 -0500
In-Reply-To: <3de2d3a8-8e11-4a68-9198-7f25bbf8fd49@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

Am 06.11.2012 10:07, schrieb Alexandre DERUMIER:
>>> Most mem get used while doing a lot of small reads.
>
> I see same problem with my test and wip-rbd-read.
>
> I got also strange fio results, from 5k to 100K iops (increase and increase in time during the bench).

Update to latest wip-rbd-read frmo yesterday. Sage fixed the bug but 
didn't report back.

Stefan
