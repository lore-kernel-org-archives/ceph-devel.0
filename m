From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 02:35:44 -0700
Message-ID: <BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1EJJfq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 05:35:46 -0400
Received: by bwz15 with SMTP id 15so4669545bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 02:35:45 -0700 (PDT)
In-Reply-To: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 9, 2011 at 7:30 PM, Simon Tian <aixt2006@gmail.com> wrote:
> [root@mon-00 ~]# rbd create foo --size 1024
> 2011-05-10 17:42:44.227398 7fa9411866f0 librbd: failed to assign a
> block name for image
> create error: Input/output error
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> I just done as this tracker said: =A0http://tracker.newdream.net/issu=
es/263
>
> I found that the return value of io_ctx.exec function is bellow zero:
>
> =A0r =3D io_ctx.exec(info_oid, "rbd", "assign_bid", bl, out);
> =A0if (r < 0)
> =A0 =A0return r;
>

Can you verify that the osd has a /var/lib/ceph/tmp directory, which
is writable by the cosd daemon, and that it doesn't have a noexec
mount option?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
