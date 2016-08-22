From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: 0.94.8 QE validation status
Date: Mon, 22 Aug 2016 15:05:35 -0700
Message-ID: <CAJ4mKGYhC5T0WszHuFmcVvheBoizXoT1jRPp--YD9dUwRNrAmw@mail.gmail.com>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33749 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755857AbcHVWFh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 18:05:37 -0400
Received: by mail-ua0-f182.google.com with SMTP id 74so214367524uau.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 15:05:36 -0700 (PDT)
In-Reply-To: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, Nathan Cutler <ncutler@suse.cz>

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

I don't think we ever had SELinux validated on the FS tests for
hammer? I wouldn't worry about it.
-Greg

> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17075 (Sage
> pls review/approve)
>
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
