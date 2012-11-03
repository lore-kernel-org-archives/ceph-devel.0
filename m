From: Gregory Farnum <greg@inktank.com>
Subject: Re: slow fio random read benchmark, need help
Date: Sat, 3 Nov 2012 18:09:11 +0100
Message-ID: <CAPYLRzhkg=34+JF-+_9TArxgoPAw59J1naAyfoxazpdyy2hE9g@mail.gmail.com>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
	<0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro>
	<24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
	<CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
	<CALFpzo7dMm2EUGh2-Tzx33+PFh=BqB342wE2mh_4dgmWAggsQA@mail.gmail.com>
	<CALFpzo7+vGuPN-sF2WZR1E2HKvGScQAyjx1nuCZ4GGnoMFbxgw@mail.gmail.com>
	<24E144B8C0207547AD09C467A8259F755770827F@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48826 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab2KCRJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:09:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6345427iea.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:09:11 -0700 (PDT)
In-Reply-To: <24E144B8C0207547AD09C467A8259F755770827F@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 1, 2012 at 6:00 PM, Dietmar Maurer <dietmar@proxmox.com> wrote:
> I always thought a distributed block storage could do such things
> faster (or at least as fast) than a single centralized store?

That rather depends on what makes up each of them. ;)

On Thu, Nov 1, 2012 at 6:11 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> I have some customers with some huge databases (too big to be handle in the bufer), require a lot of ios. (around 10K).
>
> I have redone tests with 4 guest in parallel, I get 4 x 5000iops, so it seem to scale ! (and cpu is very low on the ceph cluster).
>
>
> So I'll try some tricks, like raid over multiple rbd devices, maybe it'll help.

Did your RAID setup improve anything? Have you tried scaling past 4
guests in parallel?
I still haven't come up with a good model for what could be causing
these symptoms. :/
-Greg
