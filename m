From: huang jun <hjwsm1989@gmail.com>
Subject: Re: question about ReplicatedPG::do_op
Date: Mon, 5 Dec 2016 17:47:58 +0800
Message-ID: <CABAwU-YnDypKGQZks8ZQ9Vn4ssaxfKoPgh2B_Oz4q3ggLN5JTA@mail.gmail.com>
References: <5b867a2e.bca8.158ce3c9b56.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33603 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcLEJr7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2016 04:47:59 -0500
Received: by mail-qt0-f177.google.com with SMTP id p16so307677140qta.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2016 01:47:59 -0800 (PST)
In-Reply-To: <5b867a2e.bca8.158ce3c9b56.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

the RWState structure was used to reserve the waited ops

2016-12-05 17:07 GMT+08:00 xxhdx1985126 <xxhdx1985126@163.com>:
> Hi, everyone.
>
> I'm trying to read the source code of ceph's read/write operation process=
ing. In ReplicatedPG::do_op, I found that when the call to "get_rw_locks(wr=
ite_ordered, ctx)" fail, as showed in the following, the method ReplicatedP=
G::do_op will return. However, when ReplicatedPG::do_op is called, the op i=
s dequeued from the osd_op_wq, wouldn't the op be lost if do_op return with=
out requeueing the op?  If it is lost, wouldn't this lead to an error?  Tha=
nks.
>
>          else if (!get_rw_locks(write_ordered, ctx)) {
>                 dout(20)
>                                         << __func__ << " waiting for rw l=
ocks " << dendl;
>                 op->mark_delayed("waiting for rw locks");
>                 close_op_ctx(ctx, -EBUSY);
>                 return;
>         }



--=20
Thank you!
HuangJun
