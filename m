From: Gregory Farnum <gfarnum@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_osd=3A_fine=2Dgrained_statistics_for_object_?=
        =?UTF-8?Q?space_usage?=
Date: Thu, 30 Nov 2017 13:17:15 -0800
Message-ID: <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com>
References: <201711300849388246138@zte.com.cn> <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:45519 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdK3VRR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Nov 2017 16:17:17 -0500
Received: by mail-io0-f176.google.com with SMTP id e204so9031210iof.12
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 13:17:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Igor Fedotov <ifedotov@suse.de>, Xie Xingguo <xie.xingguo@zte.com.cn>

On Wed, Nov 29, 2017 at 7:06 PM Sage Weil <sweil@redhat.com> wrote:
>
> On Thu, 30 Nov 2017, xie.xingguo@zte.com.cn wrote:
> > （My network connection seems to be problematic, resending :( ）
> >
> >   Anyway, I am + 1 for doing this in a more effective way (e.g., as Igor
> > suggested).
> >
> >   The potential big challenge might be making the scrub-process happy,
> > though!
>
> Would this be something like:
>
> 1- an object_info_t field like uint32_t allocated_size, which has been
> incorporated into the pg summation, and
>
> 2- an ObjectStore method that returns the allocated size for an object?
>
> The challenge I see is that the new value (or delta) needs to be sorted
> out at the transaction prepare time because the stat update is part of the
> transaction, but we won't really know what the result is until bluestore
> (or any other impl) does it's write preparation work.  :/


It would take some doing but this might be a good time to start adding
delayed work. We could get the stat updates as part of the objectstore
callback and incorporate them into future disk ops, and part of the
startup/replay process could be querying for stat updates to objects
we haven’t committed yet.

...except we don’t really have an OSD-level or pg replay phase any
more, do we. Hrmm. And doing it in the transaction would require some
sort of set-up/query phase to the transaction, then finalization and
submission, which isn’t great since it impacts checksumming and other
stuff (although *hopefully* not actual allocation).
-Greg
