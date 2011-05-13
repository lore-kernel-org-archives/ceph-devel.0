From: Simon Tian <aixt2006@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Fri, 13 May 2011 15:45:41 +0800
Message-ID: <BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
	<BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
	<BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294Ab1EMHpn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 03:45:43 -0400
Received: by wya21 with SMTP id 21so1710483wya.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2011 00:45:41 -0700 (PDT)
In-Reply-To: <BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi guys,

     I did some test, 4 scenario:
(1) 5 osds in 2 hosts, ceph-0.26      one of the osds will core dump
when create several rbd.
(2) 4 osds in 4 hosts, ceph-0.26      OK
(3) 5 osds in 2 hosts, ceph-0.27.1   OK
(4) 4 osds in 4 hosts, ceph-0.27.1   OK


BTW, I have 2 question:
1.   In these scenario, after I execute "cclass -a" and "ceph class
activate rbd 1.3",  I need to wait for several second before create
rbd, otherwise, "librbd: failed to assign a block name for image" will
come out. Is this all right?

2.   I run some test with a modified testlibrbd.c, code add like:

gettimeofday(&tv1, NULL);
  for (i =3D 0; i < num_test; i++)
    write_test_data(image, test_data, TEST_IO_SIZE * i, TEST_IO_SIZE);
gettimeofday(&tv2, NULL);
t1 =3D tv2.tv_sec-tv1.tv_sec;
temp =3D (float)t1 + (tv2.tv_usec-tv1.tv_usec)/1000000.0;
speed =3D 1.0*TEST_IO_SIZE*num_test/temp/1024/1024;
printf("time used: temp=3D%.3f\n", temp);
printf("write speed: %.2f MB/s\n", speed);

The result I got is so slowly:
time used: temp=3D46.611
write speed: 0.21 MB/s
time used: temp=3D14.706
read speed: 0.68 MB/s
time used: temp=3D45.453
aio write speed: 0.22 MB/s
time used: temp=3D14.759
aio read speed: 0.68 MB/s

But while the test, some cosd process is running with high CPU usage.

Thx!
Simon


2011/5/10 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Tue, May 10, 2011 at 7:15 AM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>> Hi,
>>
>> =C2=A0 =C2=A0As you said, one of the osds crashed:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 2011-05-10 21:46:38.990311 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
>> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
>> oi.user_version=3D8'2 is_modify=3D0
>> 2011-05-10 21:46:38.990386 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
>> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
>> oi.user_version=3D8'2 is_modify=3D1
>> *** Caught signal (Segmentation fault) **
>> =C2=A0in thread 0x45382940
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> I tried again, this time, i done "rbd create foo --size 1024"
>> successfully, but when I run the code of testlibrbd.c, one of the os=
ds
>> crash again:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 2011-05-10 22:08:20.008871 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
>> snaptrimq=3D[1~1]] dump_watchers testimg.rbd/head testimg.rbd/head(9=
'4
>> client4107.0:14 wrlock_by=3Dunknown0.0:0)
>> 2011-05-10 22:08:20.008903 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
>> snaptrimq=3D[1~1]] =C2=A0* obc->watcher: client4107 session=3D0xc809=
90
>> 2011-05-10 22:08:20.008925 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
>> snaptrimq=3D[1~1]] =C2=A0* oi->watcher: client4107 cookie=3D2
>> 2011-05-10 22:08:20.009232 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
>> oi.user_version=3D10'5 is_modify=3D1
>> 2011-05-10 22:08:20.009267 4b914940 expires 2011-05-10 23:08:19.8900=
32
>> now 2011-05-10 22:08:20.009260
>> 2011-05-10 22:08:20.009284 napshots_list
>> 2011-05-10 22:08:20.009307 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
>> oi.user_version=3D10'5 is_modify=3D0
>> 2011-05-10 22:08:20.009375 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
>> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
>> oi.user_version=3D10'5 is_modify=3D1
>> *** Caught signal (Segmentation fault) **
>> =C2=A0in thread 0x4eb1c940
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
> Can you by any chance get backtrace for that crash (gdb cosd core;
> bt)? You might need to have the debug packages installed.
> Also, note that you're not running the latest version so you might be
> hitting something that was already fixed (not that I remember anythin=
g
> specific, but it might be worth a try).
>
> Thanks,
> Yehuda
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
