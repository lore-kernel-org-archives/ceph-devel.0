From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cannot do ceph pg dump
Date: Sun, 2 Jul 2017 08:58:11 -0700
Message-ID: <CAJ4mKGY=xYvjz7x=L1D6OMNyMBocasZNwDF-VrDywdV4jd5NAg@mail.gmail.com>
References: <7e8f4b8a-8a85-8356-0f56-485d02696fd2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34611 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdGBP6N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Jul 2017 11:58:13 -0400
Received: by mail-io0-f172.google.com with SMTP id r36so44265846ioi.1
        for <ceph-devel@vger.kernel.org>; Sun, 02 Jul 2017 08:58:13 -0700 (PDT)
In-Reply-To: <7e8f4b8a-8a85-8356-0f56-485d02696fd2@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Jul 2, 2017 at 4:45 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I can rebuild the cluster, and fix it for mgr, but that is not the point
> of my message:
>
> ---
> root@cephtest:/zfs/home/wjw # ceph pg dump
> Error EACCES: access denied' does your client key have mgr caps? See
> http://docs.ceph.com/docs/master/mgr/administrator/#client-authentication
> ---
>
> When I try to follow that link, it does not really work, because the
> actual link on that page to give the instructions how to do this, tha
> page does not exist.

...bah humbug. It's supposed to link to
http://docs.ceph.com/docs/master/rados/operations/user-management/#id1
; I'll get that fixed up tomorrow.

>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
