From: Milosz Tanski <milosz@adfin.com>
Subject: Re: RBD thoughts
Date: Wed, 7 May 2014 18:05:11 -0400
Message-ID: <CANP1eJGei-h0OJTdP9nCnGtcvakCzJni9zD9Ht+U0ys8V-uSuQ@mail.gmail.com>
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
	<CAPYLRzhMu+AAEpwkx1MaFXyLPnQ65RAsvspcCQpkdYMYK9j9VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:61387 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbaEGWFM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 18:05:12 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so1649045wgh.35
        for <ceph-devel@vger.kernel.org>; Wed, 07 May 2014 15:05:11 -0700 (PDT)
In-Reply-To: <CAPYLRzhMu+AAEpwkx1MaFXyLPnQ65RAsvspcCQpkdYMYK9j9VA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>, Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Greg; It looks like I was conflating a couple things.

On Wed, May 7, 2014 at 4:25 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Wed, May 7, 2014 at 1:13 PM, Milosz Tanski <milosz@adfin.com> wrote:
>> I was under the assumption that this was already in there (although
>> I'm using xfs) since the documentation for file store mentions that
>> being a settings that's defaulted to true.
>> https://ceph.com/docs/master/rados/configuration/filestore-config-ref/
>> filestore btrfs clone range
>>
>> We're using XFS today, but we were thinking of using brtfs in the
>> future for this exact property. In our setup reads trump writes
>> (between one or two magnitudes) and when we write data it's in large
>> chunks.
>
> Ah, that setting is related to using btrfs clones for RADOS clones
> (instead of explicitly copying the changed extents as we do for xfs).
> -Greg



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
