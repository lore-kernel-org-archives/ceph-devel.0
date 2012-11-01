From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 01 Nov 2012 09:08:03 +0100
Message-ID: <50922DE3.9000903@profihost.ag>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com> <0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro> <24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60512 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab2KAIIL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 04:08:11 -0400
In-Reply-To: <24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 01.11.2012 08:38, schrieb Dietmar Maurer:
> I do not really understand that network latency argument.
> If one can get 40K iops with iSCSI, why can't I get the same with rados/ceph?
> Note: network latency is the same in both cases
> What do I miss?

Good question. Also i've seen 20k iops on ceph with 10GBE but i'm able 
to get 100.000 iops via iSCSI.

Stefan
