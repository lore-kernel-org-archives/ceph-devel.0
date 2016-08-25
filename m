From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 0.94.8 QE validation status
Date: Thu, 25 Aug 2016 13:07:00 -0700
Message-ID: <CAMMFjmG2OKJO_VnreX00QGophw3VfTtVEH=UMEZGqUX2X6rJJQ@mail.gmail.com>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37655 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbcHYUPR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 16:15:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so89026221wmg.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 13:15:17 -0700 (PDT)
In-Reply-To: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, Nathan Cutler <ncutler@suse.cz>, "Deza, Alfredo" <adeza@redhat.com>

We addressed all open issues and if there is no objections from Sage,
it's ready for release!

Alfredo FYI

Thx
YuriW

On Mon, Aug 22, 2016 at 2:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Detailed summary of the QE Validation can be found here
> http://tracker.ceph.com/issues/15895#note-33
>
> The following suites were in scope of this point release testing:
>
> rados (subset 1/20)
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> hadoop
> samba
> rest
> ceph-deploy
> upgrade/client-upgrade
> upgrade/hammer-x (jewel)
> upgrade/hammer
> powercycle
>
> Deprecated suites (Sage pls reconfirm)
>
> upgrade/dumpling-firefly-x
> upgrade/firefly-x (hammer)
> upgrade/hammer-x (infernalis)
> upgrade/firefly-hammer-x (infernalis)
>
> Known issues (need approval):
>
> http://tracker.ceph.com/issues/17075 was caught be several runs, see
> email from Nathan with details "What to do with python-ceph-compat?"
>
> krbd -  http://tracker.ceph.com/issues/17083 (Jason pls review/approve)
> knsf - http://tracker.ceph.com/issues/17074 (Gregory, Sage pls review/approve)
> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17075 (Sage
> pls review/approve)
>
> Thx
> YuriW
