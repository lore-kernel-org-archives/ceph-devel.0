From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 22:15:26 +0800
Message-ID: <BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35329 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab1EJOP1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 10:15:27 -0400
Received: by wya21 with SMTP id 21so4703795wya.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 07:15:26 -0700 (PDT)
In-Reply-To: <BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

    As you said, one of the osds crashed:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2011-05-10 21:46:38.990311 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
oi.user_version=3D8'2 is_modify=3D0
2011-05-10 21:46:38.990386 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
oi.user_version=3D8'2 is_modify=3D1
*** Caught signal (Segmentation fault) **
 in thread 0x45382940
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I tried again, this time, i done "rbd create foo --size 1024"
successfully, but when I run the code of testlibrbd.c, one of the osds
crash again:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2011-05-10 22:08:20.008871 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
snaptrimq=3D[1~1]] dump_watchers testimg.rbd/head testimg.rbd/head(9'4
client4107.0:14 wrlock_by=3Dunknown0.0:0)
2011-05-10 22:08:20.008903 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
snaptrimq=3D[1~1]]  * obc->watcher: client4107 session=3D0xc80990
2011-05-10 22:08:20.008925 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
snaptrimq=3D[1~1]]  * oi->watcher: client4107 cookie=3D2
2011-05-10 22:08:20.009232 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
oi.user_version=3D10'5 is_modify=3D1
2011-05-10 22:08:20.009267 4b914940 expires 2011-05-10 23:08:19.890032
now 2011-05-10 22:08:20.009260
2011-05-10 22:08:20.009284 napshots_list
2011-05-10 22:08:20.009307 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
oi.user_version=3D10'5 is_modify=3D0
2011-05-10 22:08:20.009375 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
oi.user_version=3D10'5 is_modify=3D1
*** Caught signal (Segmentation fault) **
 in thread 0x4eb1c940
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thx!

Simon


2011/5/10 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Tue, May 10, 2011 at 6:39 AM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>> Sorry, I didn't learn the wiki carefullllllly..
>>
>> There is another problem:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [root@mon-00 ~]# rbd create foo --size 1024
>> 2011-05-11 02:37:15.400313 42d6a940 -- 10.250.6.98:0/1010326 >>
>> 10.250.6.30:6801/3051 pipe(0x63f140 sd=3D6 pgs=3D0 cs=3D0 l=3D0).fau=
lt first
>> fault
>
> This looks like your osd is not reachable, might have crashed?
>
>> terminate called after throwing an instance of 'ceph::buffer::end_of=
_buffer'
>> =C2=A0what(): =C2=A0buffer::end_of_buffer
>> *** Caught signal (Aborted) **
>
> This shouldn't happen anyway, but probably bad error handling. Can yo=
u
> verify whether one of the daemons went down?
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
