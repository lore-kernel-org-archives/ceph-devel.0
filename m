From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Read from clones
Date: Wed, 16 Jul 2014 22:24:28 +0400
Message-ID: <CALFYKtD3RPa-aHqRZ8AGBttEsbKjznKS5dM+fyzCY2GaRsvt2Q@mail.gmail.com>
References: <3ADFB25A75C80A4BA0183C65FE86C53404934AB4@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtC1CHjAnB-KY4ToXXGmS7kcMmWrc+v0o7zKUGW1spBAfA@mail.gmail.com>
	<CAPYLRziYadk1qNYWoaR6SOVMLL-uQZ=KpgFTVH218Juf0_igiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33184 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934818AbaGPSY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 14:24:29 -0400
Received: by mail-qc0-f177.google.com with SMTP id o8so1136444qcw.8
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 11:24:28 -0700 (PDT)
In-Reply-To: <CAPYLRziYadk1qNYWoaR6SOVMLL-uQZ=KpgFTVH218Juf0_igiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Lakshminarayana Mavunduri <Lakshminarayana.Mavunduri@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>

On Wed, Jul 16, 2014 at 10:19 PM, Gregory Farnum <greg@inktank.com> wrote:
> FYI, this sounds like an issue the userspace client (and possibly the
> actual rbd class?) had as well: it looked at the "HEAD" parent_overlap
> field even when reading from snapshots. (I don't remember if
> parent_overlap is the actual parameter name, but you get the idea.)

Yeah, I think that's exactly what's going on here.  I'll get on it next
week.

Thanks,

                Ilya
