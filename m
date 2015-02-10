From: Samuel Just <sam.just@inktank.com>
Subject: Re: K/V interface buffer transaction
Date: Tue, 10 Feb 2015 09:22:17 -0800
Message-ID: <CA+4uBUa+XBKHkx32hmZAvn4JOLp=o2WJywnA7OWXzSphvEcgjw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:59960 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbBJRWT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:22:19 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so3889383lbv.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 09:22:17 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

In general, you do need to preserve the order.  You are free to
determine when re-ordering is safe though.
-Sam

On Tue, Feb 10, 2015 at 8:59 AM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> Hi Sage/Haomai,
> Our K/V store works best if the keys of the objects within a transact=
ion are sorted. We are writing a new K/V Db interface and planning to s=
ort the keys within a transaction. So, this raises one question, do we =
need to preserve the order of the operation within a transaction ?
> With the latest Ceph code, we are getting the following operations wi=
thin a transaction.
>
> 2015-02-09 19:00:21.885646 7fde2a573700  0 Before ZSMPut :: p_num_obj=
 =3D  9
> 2015-02-09 19:00:21.885653 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885656 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 83
> 2015-02-09 19:00:21.885657 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 225
> 2015-02-09 19:00:21.885660 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
GHOBJTOSEQ_^A1%e6e_head!E63730A9!!1!!rbd_data%e100574b0dc51%e0000000000=
000689!head=C3=BF
> 2015-02-09 19:00:21.885663 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885664 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 64
> 2015-02-09 19:00:21.885665 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 178
> 2015-02-09 19:00:21.885666 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000000361__OBJOMAP__^A0000000011.00000000000000000554
> 2015-02-09 19:00:21.885668 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885669 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 39
> 2015-02-09 19:00:21.885671 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 4
> 2015-02-09 19:00:21.885672 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000000361__OBJOMAP__^A_epoch
> 2015-02-09 19:00:21.885673 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885674 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 38
> 2015-02-09 19:00:21.885675 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 713
> 2015-02-09 19:00:21.885676 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000000361__OBJOMAP__^A_info
> 2015-02-09 19:00:21.885677 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885679 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 48
> 2015-02-09 19:00:21.885680 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 12
> 2015-02-09 19:00:21.885681 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000000361__OBJOMAP__^Acan_rollback_to
> 2015-02-09 19:00:21.885682 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885683 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 57
> 2015-02-09 19:00:21.885684 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 12
> 2015-02-09 19:00:21.885685 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000000361__OBJOMAP__^Arollback_info_trimmed_to
> 2015-02-09 19:00:21.885686 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885688 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 31
> 2015-02-09 19:00:21.885689 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 65536
> 2015-02-09 19:00:21.885690 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000001345_STRIP_^A54
> 2015-02-09 19:00:21.885691 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885692 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 34
> 2015-02-09 19:00:21.885693 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 273
> 2015-02-09 19:00:21.885695 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000001345__OBJATTR__^A_
> 2015-02-09 19:00:21.885696 7fde2a573700  0 p_obj[p_num_obj].flags =3D=
 0
> 2015-02-09 19:00:21.885697 7fde2a573700  0 p_obj[p_num_obj].key_len =3D=
 40
> 2015-02-09 19:00:21.885698 7fde2a573700  0 p_obj[p_num_obj].data_len =
=3D 31
> 2015-02-09 19:00:21.885699 7fde2a573700  0 p_obj[p_num_obj].key =3D _=
SEQ_0000000000001345__OBJATTR__^Asnapset
>
> Looking at this it seems we don't need to preserve the order.
> But, if I can remember correctly, at some point there will be some pg=
log trim operation will be issued from upstream and that may require so=
me ordering.
> Please share your thought around this.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
