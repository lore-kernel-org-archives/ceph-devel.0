From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: can not get how many bytes read from rados_aio_read
Date: Tue, 28 Jul 2015 15:18:13 +0300
Message-ID: <CAOi1vP-23W2vNpT4=Q2xVUrGgYnPGTJUmROtWfF7Y-UU3We+zg@mail.gmail.com>
References: <CAHz-cgECZvH50a7RgryWCd=+xT+8-GYwhG_fsz+2ugU=WkDQ5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33224 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbbG1MSO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 08:18:14 -0400
Received: by wicmv11 with SMTP id mv11so176965885wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 05:18:13 -0700 (PDT)
In-Reply-To: <CAHz-cgECZvH50a7RgryWCd=+xT+8-GYwhG_fsz+2ugU=WkDQ5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: deanraccoon <deanraccoon@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 2:43 PM, deanraccoon <deanraccoon@gmail.com> wrote:
> Dear list,
>     I used the C API "rados_aio_read" to improve some read performace.
> But it seems there is no way to get exactly how many bytes I read from rados.
> the callback function will not return this infomation either.
>
> so, it there anyone who could enlighten me how to do this?

You wait for completion and get a return value from the completion,
I think.  See rados_aio_get_return_value().

Thanks,

                Ilya
