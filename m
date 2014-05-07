From: Gregory Farnum <greg@inktank.com>
Subject: Re: RBD thoughts
Date: Wed, 7 May 2014 13:25:30 -0700
Message-ID: <CAPYLRzhMu+AAEpwkx1MaFXyLPnQ65RAsvspcCQpkdYMYK9j9VA@mail.gmail.com>
References: <7334B4281E425749B85E08CF7EC6F8531F5C93CE@SACMBXIP01.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1405060837530.28165@cobra.newdream.net>
	<7334B4281E425749B85E08CF7EC6F8531F5CA5D5@SACMBXIP01.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1405061418490.28165@cobra.newdream.net>
	<alpine.DEB.2.00.1405070912450.31818@cobra.newdream.net>
	<7334B4281E425749B85E08CF7EC6F8531F5CBBB1@SACMBXIP01.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1405071225290.31818@cobra.newdream.net>
	<CANP1eJHPkxi-CvSaBWnXqXs9hRWyQ83GNqpM2CEdPuHz7UjOfQ@mail.gmail.com>
	<536A90C1.7050701@inktank.com>
	<CANP1eJH2QTR6LROuYZnPFsEjRX=0wpzOP-8R+YbGaBCoJARCvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34350 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaEGUZb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 16:25:31 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so1677430qga.6
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 13:25:30 -0700 (PDT)
In-Reply-To: <CANP1eJH2QTR6LROuYZnPFsEjRX=0wpzOP-8R+YbGaBCoJARCvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 7, 2014 at 1:13 PM, Milosz Tanski <milosz@adfin.com> wrote:
> I was under the assumption that this was already in there (although
> I'm using xfs) since the documentation for file store mentions that
> being a settings that's defaulted to true.
> https://ceph.com/docs/master/rados/configuration/filestore-config-ref/
> filestore btrfs clone range
>
> We're using XFS today, but we were thinking of using brtfs in the
> future for this exact property. In our setup reads trump writes
> (between one or two magnitudes) and when we write data it's in large
> chunks.

Ah, that setting is related to using btrfs clones for RADOS clones
(instead of explicitly copying the changed extents as we do for xfs).
-Greg
