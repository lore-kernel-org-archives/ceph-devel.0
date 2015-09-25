From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: how to sepcify the point a rbd mapped?
Date: Fri, 25 Sep 2015 10:55:22 +0300
Message-ID: <CAOi1vP8XOxj5T3Uk90NGk-6PLXJMwzkevhp0_EAOS-ZsZkHBtQ@mail.gmail.com>
References: <CAKZcxgeKCGr3_=z1=A4yhDyqK01ZzXeAFMhMow_aCT1gXeuAoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33482 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbbIYHzX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 03:55:23 -0400
Received: by wiclk2 with SMTP id lk2so10699849wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 25 Sep 2015 00:55:22 -0700 (PDT)
In-Reply-To: <CAKZcxgeKCGr3_=z1=A4yhDyqK01ZzXeAFMhMow_aCT1gXeuAoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Sep 25, 2015 at 6:25 AM, Jaze Lee <jazeltq@gmail.com> wrote:
> Hello,
>     I know we can map a rbd image to a block device into kernel by
> =E2=80=98rbd map=E2=80=99 command=E3=80=82
>     But we can not specify which block device. For example, if i have
> a rbd named rbd_0,
>     i want it mapped into /dev/rbd_0 when it mapped.
>
>     Is there some way to do that?

No, it's going to pick the lowest available ID.  The ID is picked
atomically by the kernel driver, you have no control over it.

If you want stable names, you should use udev symlinks, which look like

/dev/rbd/<poolname>/<imagename>[@<snapname>]

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
