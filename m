From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 01 Nov 2012 11:54:03 +0100
Message-ID: <509254CB.1080604@profihost.ag>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com> <0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro> <24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com> <CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:49946 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363Ab2KAKyL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 06:54:11 -0400
In-Reply-To: <CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 01.11.2012 11:40, schrieb Gregory Farnum:
> I'm not sure that latency addition is quite correct. Most use cases
> cases do multiple IOs at the same time, and good benchmarks tend to
> reflect that.
>
> I suspect the IO limitations here are a result of QEMU's storage
> handling (or possibly our client layer) more than anything else =97 J=
osh
> can talk about that more than I can, though!
> -Greg

Same results with rbd kernel driver without QEMU involved.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
