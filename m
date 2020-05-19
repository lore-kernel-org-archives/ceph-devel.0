From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph kernel client orientation
Date: Tue, 19 May 2020 16:36:05 +0200
Message-ID: <CAOi1vP9HvJd-Cdm4TnfEjNN-PooZCAPBwANpS88UfinkhJuUsg@mail.gmail.com>
References: <6n.cjI5.4P7G519BQ1k.1Um{AC@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgESOgC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2020 10:36:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48CC08C5C0
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 07:36:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s10so14742000iog.7
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 07:36:01 -0700 (PDT)
In-Reply-To: <6n.cjI5.4P7G519BQ1k.1Um{AC@seznam.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal.Plsek@seznam.cz
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 19, 2020 at 3:44 PM <Michal.Plsek@seznam.cz> wrote:
>
> Hello,
>
> I am trying to get to functions responsible for reading/writing to/openin=
g RBD blocks in ceph client kernel module (alternatives to librbd=E2=80=99s=
 rbd_read(), rbd_write() etc.). I presume it should be located somewhere ar=
ound drivers/block/, but until now I=E2=80=99ve been without luck. My idea =
is to edit these functions, rebuild the ceph kernel =E2=80=98rbd=E2=80=99 m=
odule and replace it. Since comments are pretty much missing everywhere, it=
 would be nice to narrow my searching area.
>
> If you know anything about it, please let me know. Thanks, M.

Hi Michal,

Everything is in drivers/block/rbd.c.  The entry point is
rbd_queue_rq(), this is where all rbd requests are dispatched from.
After setting up where data is to be written from (for writes) or read
to (for reads), the details specific to each type of request (read,
write, discard or zeroout) are handled in __rbd_img_fill_request()
and then later on the respective state machine is kicked off.

The job of the state machine is to submit requests to the OSDs and
handle replies from the OSDs.  As in librbd, satisfying a single
user I/O request can require sending multiple OSDs requests, in some
cases sequentially.

Unfortunately, there is no one function to edit.  I might be able
to help more if you explain what you are trying to achieve.

Thanks,

                Ilya
