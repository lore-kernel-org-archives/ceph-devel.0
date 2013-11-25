From: Gregory Farnum <greg@inktank.com>
Subject: Re: How to use the class Filer in Ceph
Date: Sun, 24 Nov 2013 22:22:06 -0800
Message-ID: <CAPYLRzgMp8o-zSNoThNM71Aub7rVdQzCPVwOYXoL8yL93EeV_A@mail.gmail.com>
References: <7061367AB47B6A4EAE551551A9A197330100F1DA@S3-EXCHMB04.shared-svc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55911 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3KYGWI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Nov 2013 01:22:08 -0500
Received: by mail-wg0-f46.google.com with SMTP id m15so3316965wgh.13
        for <ceph-devel@vger.kernel.org>; Sun, 24 Nov 2013 22:22:07 -0800 (PST)
In-Reply-To: <7061367AB47B6A4EAE551551A9A197330100F1DA@S3-EXCHMB04.shared-svc.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Luo Shaobo (DSI)" <luosb@dsi.a-star.edu.sg>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I haven't looked at the Filer code (or anything around it) in a while,
but if I were to guess, "in->snapid" is set to something which doesn't
exist.

Are you actually using the Filer in some new code that includes
inodes, or modifying the Client classes? Looking at how they
initialize things should help you through this.
Also, you could turn on messenger debugging to see exactly what your
program is sending to the OSDs and check if that looks right (and, if
necessary, turn on OSD debugging and see what's making it decide
ENOENT).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Nov 21, 2013 at 9:30 PM, Luo Shaobo (DSI)
<luosb@dsi.a-star.edu.sg> wrote:
> Dear All,
>
>    Currently, I=E2=80=99m using the class Filer to operate the OSD di=
rectly. And below list the codes.
> The write_trunc routing return success, but I can=E2=80=99t read back=
 the object, and I got r =3D -2,  -ENOENT.
> Would anyone help me to answer the question that how to use those fun=
ctions?  Thanks!
>
> The input parameters are:
> in->ino =3D 0x10000000035;
> In->layout.fl_stripe_unit =3D stripe_unit =3D 4194304;
> In->layout.fl_stripe_count =3D stripe_count =3D 1;
> In->layout.fl_object_size =3D object_size =3D 4194304;
> In->layout.fl_pg_pool =3D 0;
> in->snaprealm =3D new SnapRealm(in->ino);
> in->snaprealm->build_snap_context();
>
> The writing code looks like this.
>     Mutex flock("MClient::_write flock");
>     Cond cond;
>     bool done =3D false;
>     Context *onfinish =3D new C_SafeCond(&flock, &cond, &done);
>     Context *onsafe =3D new C_Client_SyncCommit(this, in);
>
>     unsafe_sync_write++;
>     get_cap_ref(in, CEPH_CAP_FILE_BUFFER);  // released by onsafe cal=
lback
>
>     r =3D filer->write_trunc(in->ino, &in->layout, in->snaprealm->get=
_snap_context(),
>                                                    offset, size, bl, =
ceph_clock_now(cct), 0,
>                                                    in->truncate_size,=
 in->truncate_seq,
>                                                    onfinish, onsafe);
>     if (r < 0)
>       goto done;
>
>     client_lock.Unlock();
>     flock.Lock();
>     while (!done)
>       cond.Wait(flock);
> =E3=80=80flock.Unlock();
>
> The reading code looks like this.
>
> Mutex flock("MClient::_read_sync flock");
> bool done =3D false;
>     Context *onfinish =3D new C_SafeCond(&flock, &cond, &done, &r);
>     bufferlist tbl;
>
>     int wanted =3D left;
>     filer->read_trunc(in->ino, &in->layout, in->snapid,
>                                       pos, left, &tbl, 0,
>                                       in->truncate_size, in->truncate=
_seq,
>                                       onfinish);
>     client_lock.Unlock();
>     flock.Lock();
>     while (!done)
>       cond.Wait(flock);
> =E3=80=80flock.Unlock();
>
> Thomas
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
