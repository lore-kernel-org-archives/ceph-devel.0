From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Tue, 12 Dec 2017 14:38:35 -0500
Message-ID: <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:46181 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdLLTig (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Dec 2017 14:38:36 -0500
Received: by mail-it0-f43.google.com with SMTP id t1so881256ite.5
        for <ceph-devel@vger.kernel.org>; Tue, 12 Dec 2017 11:38:36 -0800 (PST)
In-Reply-To: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Its useful for legacy systems that installed with "plain" back when
that was the only option. Since there is no easy migration path for
re-keying an encrypted OSD to use a new encryption scheme, keeping
support for legacy "plain" is still very useful and desirable.

On Tue, Dec 12, 2017 at 2:27 PM, Alfredo Deza <adeza@redhat.com> wrote:
> We have started looking into encryption support in ceph-volume, and
> one of the unclear paths is if we really want to support both "plain"
> and "LUKS".
>
> According to the cryptsetup docs [0] :
>
>     (LUKS) is now the preferred way to set up disk encryption with
> dm-crypt using the cryptsetup utility
>
>
> ceph-disk supports both plain and LUKS, but moving forward, I was
> interested in understanding if anyone is really expecting the "plain"
> type to be a choice?
>
> The legacy support will mean that ceph-volume will have to deal with
> "plain", but moving forward it might be easier if we are supporting a
> single type of encryption with LUKS.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
