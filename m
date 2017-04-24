From: Brett Niver <bniver@redhat.com>
Subject: Re: Storing NFS (ganesha) HA state in Ceph
Date: Mon, 24 Apr 2017 09:23:05 -0400
Message-ID: <CAMdDSN0u0jhL4rJCawaKm4Jrv4xFiMvbUuYWrj037cq+sKq3Fg@mail.gmail.com>
References: <CALe9h7cyD6r+0ed0r49jR-4BZhk7dxoe6ngUcqVMhH6kCo+vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36137 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170742AbdDXNXI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 09:23:08 -0400
Received: by mail-io0-f181.google.com with SMTP id p80so73820294iop.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 06:23:08 -0700 (PDT)
In-Reply-To: <CALe9h7cyD6r+0ed0r49jR-4BZhk7dxoe6ngUcqVMhH6kCo+vgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

+1


On Mon, Apr 24, 2017 at 9:17 AM, John Spray <jspray@redhat.com> wrote:
> Interesting ganesha patch (not by me) here:
> https://review.gerrithub.io/#/c/355070/
>
> My review is suggesting that ganesha should store its client state in
> RADOS objects rather than the mon, but others may have opinions as
> well...
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
