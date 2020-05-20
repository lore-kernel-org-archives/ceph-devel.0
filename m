From: <Michal.Plsek@seznam.cz>
Subject: Re: ceph kernel client orientation
Date: Wed, 20 May 2020 09:36:07 +0200 (CEST)
Message-ID: <da.cjLX.3v4GDfOKIZE.1UnDtd@seznam.cz>
References: <6n.cjI5.4P7G519BQ1k.1Um{AC@seznam.cz>
        <CAOi1vP9HvJd-Cdm4TnfEjNN-PooZCAPBwANpS88UfinkhJuUsg@mail.gmail.com>
Mime-Version: 1.0 (szn-mime-2.0.57)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHgQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2020 03:36:16 -0400
Received: from mxb1.seznam.cz (mxb1.seznam.cz [IPv6:2a02:598:a::78:89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F6C061A0E
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2020 00:36:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanks for swift answer.

(This is my usage in librbd.cc)

Basically there is a folder with symmetric keys used for block encryption,=
 one key for one disk in some pool. For identification of key I need (pool=
_id, disk_id) of block. I am temporarily saving key to librbd::ImageCtx st=
ructure, so I don't have to get it from file every time. I use this key to=
 encrypt/decrypt block data. Encrypt/decrypt is primitive, I'm not gonna m=
ention it here, but it is done over the data provided by functions rbd_rea=
d() and rbd_write().

If you could point how to edit rbd.c content to achieve similar behaviour,=
 I would be much obliged.

M.



---------- P=C5=AFvodn=C3=AD e-mail ----------

Od: Ilya Dryomov <idryomov@gmail.com>

Komu: Michal.Plsek@seznam.cz

Datum: 19. 5. 2020 16:36:05

P=C5=99edm=C4=9Bt: Re: ceph kernel client orientation

On Tue, May 19, 2020 at 3:44 PM <Michal.Plsek@seznam.cz> wrote:

>

> Hello,

>

> I am trying to get to functions responsible for reading/writing to/openi=
ng RBD blocks in ceph client kernel module (alternatives to librbd=
=E2=80=99s rbd_read(), rbd_write() etc.). I presume it should be located s=
omewhere around drivers/block/, but until now I=E2=80=99ve been without lu=
ck. My idea is to edit these functions, rebuild the ceph kernel =E2=80=98r=
bd=E2=80=99 module and replace it. Since comments are pretty much missing =
everywhere, it would be nice to narrow my searching area.

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
