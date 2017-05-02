From: kefu chai <tchaikov@gmail.com>
Subject: Re: man pages no longer compressing during install?
Date: Wed, 3 May 2017 00:08:27 +0800
Message-ID: <CAJE9aONw-QhZ7ewqGQededt2CgTDFZUdA_K=ZuXaJTAi8r-+BA@mail.gmail.com>
References: <81511478-8a15-9cc7-73e5-84102231b1bc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33410 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdEBQI3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 May 2017 12:08:29 -0400
Received: by mail-vk0-f48.google.com with SMTP id i65so36550578vkh.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 May 2017 09:08:29 -0700 (PDT)
In-Reply-To: <81511478-8a15-9cc7-73e5-84102231b1bc@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Apr 29, 2017 at 8:16 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> My FreeBSD port assumes that the manpages are installed compresses when
> running `make install`.
> That used to work, but that is no longer the case...

Willem, i don't think we used to compress manpages when doing "make install".

>
> Now I can fix this in the package-building, but I was wondering why this
> is an issue all of a sudden.

the last time doc/man/8/CMakeLists.txt got updated was Aug 23 13:32:47 2016.

>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
