From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: who is using nfs-ganesha and cephfs?
Date: Wed, 8 Nov 2017 16:52:14 -0500
Message-ID: <CAGbvivLN_YzDR4XDHsJK5kiYZMBrMSeE71kqQysq7p7-AgZ8fQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:55685 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdKHVwQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Nov 2017 16:52:16 -0500
Received: by mail-lf0-f41.google.com with SMTP id e143so4852980lfg.12
        for <ceph-devel@vger.kernel.org>; Wed, 08 Nov 2017 13:52:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-User <ceph-users@ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

We use Ganesha (currently version 2.5.2) for exporting cephfs
subdirectories over NFS, but we have been using the VFS FSAL as
opposed to the ceph one due to problems encountered in the past. Im
not sure if the past issues have been resolved or not.  It would be
good to know with some confidence if the ceph FSAL is production
ready, so proper testing would be great.

Wyllys Ingersoll
Keeper Technology, LLC

On Wed, Nov 8, 2017 at 4:41 PM, Sage Weil <sweil@redhat.com> wrote:
> Who is running nfs-ganesha's FSAL to export CephFS?  What has your
> experience been?
>
> (We are working on building proper testing and support for this into
> Mimic, but the ganesha FSAL has been around for years.)
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
