From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: UID/GID for ceph user and group
Date: Mon, 20 Feb 2017 16:07:02 +1000
Message-ID: <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com>
References: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35982 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdBTGPP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 01:15:15 -0500
Received: by mail-it0-f49.google.com with SMTP id h10so62806224ith.1
        for <ceph-devel@vger.kernel.org>; Sun, 19 Feb 2017 22:14:06 -0800 (PST)
In-Reply-To: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 17, 2017 at 1:46 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> Is there a typical uid/gid that is selected on oterh platforms to assign
> to ceph:ceph?

https://github.com/ceph/ceph/blob/master/ceph.spec.in#L970

I wonder if that should be "%if 0%{?rhel} || 0%{?fedora} || 0%{?centos}" ?

Seems odd you'd be the first to notice though?????

>
> On my centos7 box they are not defined when I installed the ceph package?
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
