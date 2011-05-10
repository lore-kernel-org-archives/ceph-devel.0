From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 06:59:56 -0700
Message-ID: <BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53597 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab1EJN75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 09:59:57 -0400
Received: by bwz15 with SMTP id 15so4857607bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 06:59:56 -0700 (PDT)
In-Reply-To: <BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 10, 2011 at 6:39 AM, Simon Tian <aixt2006@gmail.com> wrote:
> Sorry, I didn't learn the wiki carefullllllly..
>
> There is another problem:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [root@mon-00 ~]# rbd create foo --size 1024
> 2011-05-11 02:37:15.400313 42d6a940 -- 10.250.6.98:0/1010326 >>
> 10.250.6.30:6801/3051 pipe(0x63f140 sd=3D6 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault

This looks like your osd is not reachable, might have crashed?

> terminate called after throwing an instance of 'ceph::buffer::end_of_=
buffer'
> =A0what(): =A0buffer::end_of_buffer
> *** Caught signal (Aborted) **

This shouldn't happen anyway, but probably bad error handling. Can you
verify whether one of the daemons went down?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
