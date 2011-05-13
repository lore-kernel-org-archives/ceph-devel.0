From: Sage Weil <sage@newdream.net>
Subject: Re: rbd create error with 0.26
Date: Fri, 13 May 2011 08:58:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105130854110.12286@cobra.newdream.net>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
 <BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
 <BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
 <BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
 <BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
 <BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
 <BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1589205344-1305302294=:12286"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44578 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777Ab1EMP5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 11:57:21 -0400
In-Reply-To: <BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1589205344-1305302294=:12286
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 May 2011, Simon Tian wrote:
> Hi guys,
>=20
>      I did some test, 4 scenario:
> (1) 5 osds in 2 hosts, ceph-0.26      one of the osds will core dump
> when create several rbd.
> (2) 4 osds in 4 hosts, ceph-0.26      OK
> (3) 5 osds in 2 hosts, ceph-0.27.1   OK
> (4) 4 osds in 4 hosts, ceph-0.27.1   OK
>=20
>=20
> BTW, I have 2 question:
> 1.   In these scenario, after I execute "cclass -a" and "ceph class
> activate rbd 1.3",  I need to wait for several second before create
> rbd, otherwise, "librbd: failed to assign a block name for image" will
> come out. Is this all right?

For 0.27 and previous, yes.  The class distribution has removed in v0.28=20
and it is now the administrator's (make install's, dpkg's, rpm's)=20
responsibility to put the .so in the right directory.  This is much=20
simpler all around and easier to debug.  If you are still having any class=
=20
loading problems you should try the 'next' branch which will soon become=20
v0.28.

> 2.   I run some test with a modified testlibrbd.c, code add like:
>=20
> gettimeofday(&tv1, NULL);
>   for (i =3D 0; i < num_test; i++)
>     write_test_data(image, test_data, TEST_IO_SIZE * i, TEST_IO_SIZE);
> gettimeofday(&tv2, NULL);
> t1 =3D tv2.tv_sec-tv1.tv_sec;
> temp =3D (float)t1 + (tv2.tv_usec-tv1.tv_usec)/1000000.0;
> speed =3D 1.0*TEST_IO_SIZE*num_test/temp/1024/1024;
> printf("time used: temp=3D%.3f\n", temp);
> printf("write speed: %.2f MB/s\n", speed);
>=20
> The result I got is so slowly:
> time used: temp=3D46.611
> write speed: 0.21 MB/s
> time used: temp=3D14.706
> read speed: 0.68 MB/s
> time used: temp=3D45.453
> aio write speed: 0.22 MB/s
> time used: temp=3D14.759
> aio read speed: 0.68 MB/s
>=20
> But while the test, some cosd process is running with high CPU usage.

What is the IO size?  Is write_test_data synchronous?

For simple write benchmarking you can also use

=09rados mkpool foo
=09rados -p foo bench <seconds> write -b <blocksize> -t <threads>

and you'll see latency and throughput.  Blocksize defaults to 4M and=20
"threads" (parallel IOs) default to 16, IIRC.

sage


>=20
> Thx!
> Simon
>=20
>=20
> 2011/5/10 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> > On Tue, May 10, 2011 at 7:15 AM, Simon Tian <aixt2006@gmail.com> wrote:
> >> Hi,
> >>
> >> =A0 =A0As you said, one of the osds crashed:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 2011-05-10 21:46:38.990311 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
> >> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
> >> oi.user_version=3D8'2 is_modify=3D0
> >> 2011-05-10 21:46:38.990386 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
> >> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
> >> oi.user_version=3D8'2 is_modify=3D1
> >> *** Caught signal (Segmentation fault) **
> >> =A0in thread 0x45382940
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> I tried again, this time, i done "rbd create foo --size 1024"
> >> successfully, but when I run the code of testlibrbd.c, one of the osds
> >> crash again:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 2011-05-10 22:08:20.008871 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> >> snaptrimq=3D[1~1]] dump_watchers testimg.rbd/head testimg.rbd/head(9'4
> >> client4107.0:14 wrlock_by=3Dunknown0.0:0)
> >> 2011-05-10 22:08:20.008903 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> >> snaptrimq=3D[1~1]] =A0* obc->watcher: client4107 session=3D0xc80990
> >> 2011-05-10 22:08:20.008925 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> >> snaptrimq=3D[1~1]] =A0* oi->watcher: client4107 cookie=3D2
> >> 2011-05-10 22:08:20.009232 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> >> oi.user_version=3D10'5 is_modify=3D1
> >> 2011-05-10 22:08:20.009267 4b914940 expires 2011-05-10 23:08:19.890032
> >> now 2011-05-10 22:08:20.009260
> >> 2011-05-10 22:08:20.009284 napshots_list
> >> 2011-05-10 22:08:20.009307 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> >> oi.user_version=3D10'5 is_modify=3D0
> >> 2011-05-10 22:08:20.009375 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> >> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> >> oi.user_version=3D10'5 is_modify=3D1
> >> *** Caught signal (Segmentation fault) **
> >> =A0in thread 0x4eb1c940
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> > Can you by any chance get backtrace for that crash (gdb cosd core;
> > bt)? You might need to have the debug packages installed.
> > Also, note that you're not running the latest version so you might be
> > hitting something that was already fixed (not that I remember anything
> > specific, but it might be worth a try).
> >
> > Thanks,
> > Yehuda
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1589205344-1305302294=:12286--
