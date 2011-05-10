From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 21:39:22 +0800
Message-ID: <BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60649 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1EJNjX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 09:39:23 -0400
Received: by wwk4 with SMTP id 4so3387759wwk.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 06:39:22 -0700 (PDT)
In-Reply-To: <BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Sorry, I didn't learn the wiki carefullllllly..

There is another problem:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[root@mon-00 ~]# rbd create foo --size 1024
2011-05-11 02:37:15.400313 42d6a940 -- 10.250.6.98:0/1010326 >>
10.250.6.30:6801/3051 pipe(0x63f140 sd=3D6 pgs=3D0 cs=3D0 l=3D0).fault =
first
fault
terminate called after throwing an instance of 'ceph::buffer::end_of_bu=
ffer'
  what():  buffer::end_of_buffer
*** Caught signal (Aborted) **
 in thread 0x7f9cbfc6c6f0
*** Caught signal (Aborted) **
 in thread 0x7f9cbfc6c6f0
 ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
 1: /usr/local/lib/librados.so.2 [0x7f9cbfff1b98]
 2: /lib64/libpthread.so.0 [0x324ea0e7c0]
 3: (gsignal()+0x35) [0x324de30265]
 4: (abort()+0x110) [0x324de31d10]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x32610bec44]
 6: /usr/lib64/libstdc++.so.6 [0x32610bcdb6]
 7: /usr/lib64/libstdc++.so.6 [0x32610bcde3]
 8: /usr/lib64/libstdc++.so.6 [0x32610bceca]
 9: (librbd::rbd_assign_bid(librados::IoCtx&, std::string&, unsigned
long*)+0x227) [0x7f9cc02726c7]
 10: (librbd::create(librados::IoCtx&, std::string&, char const*,
unsigned long, int*)+0x115) [0x7f9cc0272865]
 11: (librbd::RBD::create(librados::IoCtx&, char const*, unsigned
long, int*)+0x61) [0x7f9cc0273141]
 12: (__gxx_personality_v0()+0x489) [0x403e59]
 13: (main()+0x177c) [0x4063dc]
 14: (__libc_start_main()+0xf4) [0x324de1d994]
 15: (__gxx_personality_v0()+0xc9) [0x403a99]
Aborted
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cclass -a should run on all host of the cluster or any one host or the
host to run rbd create?

Thx very much!

Simon


2011/5/10 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Mon, May 9, 2011 at 7:30 PM, Simon Tian <aixt2006@gmail.com> wrote=
:
>> [root@mon-00 ~]# rbd create foo --size 1024
>> 2011-05-10 17:42:44.227398 7fa9411866f0 librbd: failed to assign a
>> block name for image
>> create error: Input/output error
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> I just done as this tracker said: =C2=A0http://tracker.newdream.net/=
issues/263
>>
>> I found that the return value of io_ctx.exec function is bellow zero=
:
>>
>> =C2=A0r =3D io_ctx.exec(info_oid, "rbd", "assign_bid", bl, out);
>> =C2=A0if (r < 0)
>> =C2=A0 =C2=A0return r;
>>
>
> Can you verify that the osd has a /var/lib/ceph/tmp directory, which
> is writable by the cosd daemon, and that it doesn't have a noexec
> mount option?
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
