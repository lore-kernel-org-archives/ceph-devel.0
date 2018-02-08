From: Ning Yao <zay11022@gmail.com>
Subject: Re: killing ceph-rest-api
Date: Thu, 8 Feb 2018 18:07:19 +0800
Message-ID: <CALZt5jzMHQ0hSUjcoSJ5baxEiXsmwZPx0nkN46C55TAGVA+nNQ@mail.gmail.com>
References: <alpine.DEB.2.11.1802022117010.22482@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:46637 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBHKHU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Feb 2018 05:07:20 -0500
Received: by mail-io0-f177.google.com with SMTP id f34so5180088ioi.13
        for <ceph-devel@vger.kernel.org>; Thu, 08 Feb 2018 02:07:20 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1802022117010.22482@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, dmick@redhat.com, jspray@redhat.com

sounds a good idea and there is no need for us to maintain the
deployment for ceph-rest-api and its HA anymore.
Regards
Ning Yao


2018-02-03 5:19 GMT+08:00 Sage Weil <sweil@redhat.com>:
> This has come up several times but it's not dead yet.
>
> I see two options:
>
> 1- Add a mon command passthrough to restful.  John has expressed
> reservations about this in the past as it is too tempting to use.  On the
> other hand, I suspect there will always be a need for things to do
> "low-level" mon commands for unusual cases, and having a way to
> do that without shelling out or creating a librados session seems useful.
>
> 2- Transpant ceph-rest-api into a mgr module.  This probably requires a
> bit more work but would keep it as a separate thing from the curated
> restful.
>
> Thoughts?
> sage
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
