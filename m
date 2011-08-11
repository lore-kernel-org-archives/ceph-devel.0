From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Thu, 11 Aug 2011 22:49:11 +0800
Message-ID: <CAFGK4NK9d3egypFZt5qySY-3-RbEiOZBbtOX_MbCdiPB8k34MA@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41032 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1HKOtM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2011 10:49:12 -0400
Received: by wwe5 with SMTP id 5so4172955wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2011 07:49:11 -0700 (PDT)
In-Reply-To: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

      This assert failure appeared in ceph-0.31 when creating a pool,
could anyone help me?

Thx
Simon


2011/5/10 Simon Tian <aixt2006@gmail.com>:
> Hi folks,
>
> I met an error when creating a rbd image:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [root@mon-00 ~]# ceph class list
> 2011-05-10 17:36:29.530759 mon <- [class,list]
> 2011-05-10 17:36:29.531491 mon0 -> 'no installed classes!' (0)
> [root@mon-00 ~]# cclass -a
> Loading class: /usr/local/lib/rados-classes/libcls_rbd.so.1.0.0: rbd =
1.3 x86-64
> 2011-05-10 17:36:37.657254 7eff9cfc36f0 read 184650 bytes from
> /usr/local/lib/rados-classes/libcls_rbd.so.1.0.0
> 2011-05-10 17:36:37.658820 mon <- [class,add,rbd,1.3,x86-64,changed]
> 2011-05-10 17:36:37.749791 mon0 -> 'updated' (0)
> [root@mon-00 ~]# ceph class list
> 2011-05-10 17:36:45.176860 mon <- [class,list]
> 2011-05-10 17:36:45.177511 mon1 -> 'installed classes:
> rbd (v1.3 [x86-64]) [active]
> ' (0)
> [root@mon-00 ~]# rbd list
> pool rbd doesn't contain rbd images
> [root@mon-00 ~]# rbd list
> pool rbd doesn't contain rbd images
> [root@mon-00 ~]# rbd create foo --size 1024
> 2011-05-10 17:42:14.854907 7fcff83cb6f0 librbd: failed to assign a
> block name for image
> create error: Input/output error
> [root@mon-00 ~]# ceph class activate rbd 1.3
> 2011-05-10 17:42:34.824676 mon <- [class,activate,rbd,1.3]
> 2011-05-10 17:42:34.944398 mon2 -> 'updated' (0)
> [root@mon-00 ~]# rbd create foo --size 1024
> 2011-05-10 17:42:44.227398 7fa9411866f0 librbd: failed to assign a
> block name for image
> create error: Input/output error
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> I just done as this tracker said: =C2=A0http://tracker.newdream.net/i=
ssues/263
>
> I found that the return value of io_ctx.exec function is bellow zero:
>
> =C2=A0r =3D io_ctx.exec(info_oid, "rbd", "assign_bid", bl, out);
> =C2=A0if (r < 0)
> =C2=A0 =C2=A0return r;
>
> Thx!
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
