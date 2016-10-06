From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Upgrading from firefly to Jewel
Date: Thu, 6 Oct 2016 12:42:50 -0700
Message-ID: <CAMMFjmHJ00U1Tg-cGfdytgurbwSezKyYzKagVwnfk6tBfMCF0g@mail.gmail.com>
References: <CAK=B8yZ_v8KONH1t6hbQbXtsuaizdRW=bq+WrJ+EM72wdPSHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37561 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbcJFTmw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 15:42:52 -0400
Received: by mail-wm0-f44.google.com with SMTP id b201so69626802wmb.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 12:42:51 -0700 (PDT)
In-Reply-To: <CAK=B8yZ_v8KONH1t6hbQbXtsuaizdRW=bq+WrJ+EM72wdPSHsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Muminul Islam Russell <misla011@fiu.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can't comment much about radosgw, but if you really want to do
not-recommended upgrade from firefly to jewel IIRC you may have to go
through hammer step first, e.g. firefly => hammer => jewel.

Thx
YuriW

On Thu, Oct 6, 2016 at 12:04 PM, Muminul Islam Russell <misla011@fiu.edu> wrote:
> Hello cephers,
>
> I know that upgrading from firefly to jewel is not recommended but I
> wanted to give a try for my small cluster. I got it done with some
> down time but failed with object gateway part.
>
> Can anyone advise me if radosgw upgrade is possible from firefly to
> jewel considering a lot of architectural changes between this two
> LTS.?
>
> Thanks,
> Muminul
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
