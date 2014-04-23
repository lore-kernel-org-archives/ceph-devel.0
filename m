From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: rbd map automation woes
Date: Wed, 23 Apr 2014 13:50:24 +0400
Message-ID: <CALFYKtCFZsqc+b7z-YGaXLnPH=WE14hDBA48VqPgJG9jRqSBSA@mail.gmail.com>
References: <CABt9es9b2EzSn9apkEs940GMktTyssV7BjeZUPK2GV3RW5b0BQ@mail.gmail.com>
	<CALFYKtACugAXVP=7RAt=bxFBMWnKOAT7O9S53KttOuJnTMenyQ@mail.gmail.com>
	<CABt9es8xehAUFNNk7GPMk5CjAeESpazEyA+j=TQgPXjEkacUXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:46630 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaDWJuZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Apr 2014 05:50:25 -0400
Received: by mail-qg0-f49.google.com with SMTP id j5so658272qga.22
        for <ceph-devel@vger.kernel.org>; Wed, 23 Apr 2014 02:50:24 -0700 (PDT)
In-Reply-To: <CABt9es8xehAUFNNk7GPMk5CjAeESpazEyA+j=TQgPXjEkacUXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Thorwald Lundqvist <thorwald@jumpstarter.io>

On Tue, Apr 22, 2014 at 11:58 PM, Hannes Landeholm
<hannes@jumpstarter.io> wrote:
> Okay, it's unfortunate that it still depends on udev but we would
> really appreciate to have those guarantees.
>
> Does the "rbd returning the new device node" feature also depend on udev?

Yes, in fact that's the core of it.  Those guarantees are mostly just
a nice side effect.

>
> Also, is this branch public? I'd like to have a look.

Yes, https://github.com/ceph/ceph/tree/wip-libkrbd.

Thanks,

                Ilya
