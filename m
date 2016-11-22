From: Samuel Just <sjust@redhat.com>
Subject: Re: osd/*PG* code cleanup
Date: Tue, 22 Nov 2016 09:34:50 -0800
Message-ID: <CAN=+7FWAMi_-GC8Eq_jqxr+65qr-WZydoCkHy23=KR9Ke7exvQ@mail.gmail.com>
References: <alpine.DEB.2.11.1611220318580.5480@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35214 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcKVRev (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 12:34:51 -0500
Received: by mail-qt0-f169.google.com with SMTP id c47so16806522qtc.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 09:34:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611220318580.5480@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, that'll work.
-Sam

On Mon, Nov 21, 2016 at 7:22 PM, Sage Weil <sweil@redhat.com> wrote:
> Hey Sam,
>
> I think now is the time to do a cleanup the PG class and file names--right
> after a big refactor that is effectively a backport-barrier anyway.  If we
> do it after kraken it will make it hard to backport to kraken, and the
> recent changes have just drastically cut the probability that anything
> post-kraken will be backported to jewel without care anyway.
>
> I think we should
>
>  - rename ReplicatedPG -> PrimaryLogPG
>  - PGBackend and *Backend -> PLPG[*]Backend
>
> Eventually we also need to move most of PG into PrimaryLogPG, but it's
> less important that that happens now...
>
> What do you think?
>
> sage
