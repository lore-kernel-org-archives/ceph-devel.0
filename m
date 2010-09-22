From: cang lin <fwdflywl@gmail.com>
Subject: Re: some questions about ceph deployment
Date: Wed, 22 Sep 2010 19:09:04 +0800
Message-ID: <AANLkTi=257Xg+aNMiLihg-JL27irQvaDr9nYgL0D2y2+@mail.gmail.com>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
	<Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54025 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab0IVLJH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 07:09:07 -0400
Received: by wwi17 with SMTP id 17so552190wwi.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 04:09:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks for your replay,Sege.I think ceph is a very good distributed
filesystem and want to test it in product environment.Your reply is
very important to us.

2010/9/18 Sage Weil=C2=A0<sage@newdream.net>
>
> Sorry, I just realized this one slipped through the cracks!
>
> On Sat, 4 Sep 2010, FWDF wrote:
>
> > We use 3 servers to build a test system of ceph, configured as belo=
w:
> >
> > Host =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0IP
> > client01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0192.168.1.10
> > ceph01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0192.168.2.50
> > ceph02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0192.168.2.51
> >
> > The OS is unbuntu 10.04 LTS and the version of ceph is v0.21.1
> >
> > ceph.conf:
> > [global]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth supported =3D cephx
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid file =3D /var/run/ceph/$name.pid
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug ms =3D 0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyring =3D /etc/ceph/keyring.bin
> > [mon]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon data =3D /mnt/ceph/data/mon$id
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug ms =3D 1
> > [mon0]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 mon addr =3D=C2=A0192.168.2.50:6789
> > =C2=A0[mds]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyring =3D /etc/ceph/keyring.$name
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug ms =3D 1
> > [mds.ceph01]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > [mds.ceph02]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph02
> > [osd]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo =3D true
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd data =3D /mnt/ceph/osd$id/data
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 keyring =3D /etc/ceph/keyring.$name
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal =3D /mnt/ceph/osd$id/data/j=
ournal
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 100
> > [osd0]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > [osd1]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > [osd2]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > [osd3]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph01
> > [osd10]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D ceph02
> >
> >There are 4 HDDs in the ceph01 and every HDD has a OSD named as osd0=
, osd1, osd2,osd3; there is 1 HDD in the ceph02 named as osd10. All the=
se HDDs are made as btrfs and mounted on the mount point as listed belo=
w:
> >
> > ceph01
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /dev/sdc1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
mnt/ceph/osd0/data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btr=
fs
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /dev/sdd1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
mnt/ceph/osd1/data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btr=
fs
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /dev/sde1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
mnt/ceph/osd2/data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btr=
fs
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /dev/sdf1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/mnt/ceph/osd3/data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 btrfs
> >
> > ceph02
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /dev/sdb1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
mnt.ceph/osd10/data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btrfs
> >
> > Make ceph FileSystem:
> > root@ceph01:~# =C2=A0mkcephfs =C2=A0-c /etc/cepf/ceph.conf -a -k /e=
tc/ceph/keyring.bin
> >
> > Startup ceph:
> > root@ceph01:~# =C2=A0/etc/init.d/ceph -a =C2=A0start
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Then
> > root@ceph01:~# =C2=A0ceph -w
> > 10.09.01_17:56:19.337895 =C2=A0 mds e17: 1/1/1 up {0=3Dup:active}, =
1 up:standby
> > 10.09.01_17:56:19.347184 =C2=A0 osd e27: 5 osds: 5 up, 5 in
> > 10.09.01_17:56:19.349447 =C2=A0 =C2=A0 log ...
> > 10.09.01_17:56:19.373773 =C2=A0 mon e1: 1 mons at=C2=A0192.168.2.50=
:6789/0
> >
> > The ceph file system is mounted to client01(192.168.1.10), ceph01(1=
92.168.2.50), ceph02(192.168.2.51) at /data/ceph. It works fine at the =
beginning, I can use ls and the write and read of file is ok. After som=
e files are wrote , I find I can't use ls -l /data/ceph until I umount =
ceph from ceph02, but one day later the same problem occurred again, th=
en I umount ceph from ceph01 the system and everything is ok.
> >
> > Q1:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Can the ceph filesystem be mounte=
d to a member of ceph cluster?
>
> Technically, yes, but you should be very careful doing so. =C2=A0The =
problem is
> that when the kernel is low on memory it will force the client to wri=
te
> out dirty data so that it can reclaim those pages. =C2=A0If the write=
out
> depends on then waking up some user process (cosd daemon), doing a bu=
nch
> of random work, and writing the data to disk (dirtying yet more memor=
y),
> you can deadlock the system.

We not only mount ceph onto a client in the same subnet but also mount
it onto remote client through=C2=A0internet.in=C2=A0the first week ever=
ything
worked fine,it is about 100G write operation and 10 times read
operation per day.The file was almost read only and the size is form a
dozens =C2=A0of MB to a few GB,not a very heavy load.but in the second =
week
the client in the same subnet with ceph cluster can=E2=80=99t be access=
ed and
ceph can=E2=80=99t be unmounted from it,the remote client can still acc=
ess and
unmount ceph.

Use 'ceph=C2=A0=E2=80=93s'=C2=A0and 'ceph osd dump -0' on ceph01 can fi=
nd out that the 3
of 4 osd were down(osd0,osd02,osd04). Use 'df=C2=A0=E2=80=93h' command =
can find out
/dev/sde1(for osd0), /dev/sdd1(for osd2), /dev/sdc1(for osd4) still in
their mount point.

Use following command to restart osd:

# /etc/init.d/ceph start osd0

[/etc/ceph/fetch_config /tmp/fetched.ceph.conf.4967]
=3D=3D=3D osd.0 =3D=3D=3D
Starting Ceph osd0 on ceph01...
=C2=A0** WARNING: Ceph is still under heavy development, and is only su=
itable for **
=C2=A0**=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tes=
ting and review.=C2=A0=C2=A0Do not trust it with important data.=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0**
starting osd0 at=C2=A00.0.0.0:6800/4864=C2=A0osd_data /mnt/ceph/osd0/da=
ta
/mnt/ceph/osd0/data/journal
=E2=80=A6

3 osd started and ran normally,but the local ceph client was down.Dose
it have anything to do with the osd restart?The local client can
remount ceph after reboot and work normally. The remote client can
remount ceph and work normally too,but a few days later it can=E2=80=99=
t
access or unmount ceph.

#umount /mnt/ceph
umount: /mnt/ceph: device is busy.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(In some cases useful i=
nfo about processes that use
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the device is fou=
nd by lsof(8) or fuser(1))

There was no response for lsof or fuser command.the only thing could
do is kill the process and reboot the system.We use ceph v0.21.2 for
the cluster and client and use Ubuntu 10.04 LTS(server),kernel version
is 2.6.32-21-generic-pae=E3=80=82
What confuse me is why the client can=E2=80=99t access ceph?Even if the=
 osd
was down shouldn=E2=80=99t affect the client.what is the reason for the=
 client
can=E2=80=99t access or unmount ceph?
>
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0When I follow the instruction of=C2=
=A0http://ceph.newdream.net/wiki/Monitor_cluster_expansion=C2=A0to expa=
nd a monitor to ceph02, the following error occurred:
> >
> > root@ceph02:~# =C2=A0/etc/init.d/ceph start mon1
> > [/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.conf 100%=
 =C2=A02565 =C2=A02.5KB/s =C2=A000:00
> > =3D=3D=3D mon.1 =3D=3D=3D
> > Starting Ceph mon1 on ceph02...
> > =C2=A0** WARNING: Ceph is still under heavy development, and is onl=
y suitable for **
> > =C2=A0** testing and review. =C2=A0Do not trust it with important d=
ata. =C2=A0**
> > terminate called after throwing an instance of 'std::logic_error'
> > =C2=A0 what(): =C2=A0basic_string::_S_construct NULL not valid
> > Aborted (core dumped)
> > failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 '
>
> I haven't seen that crash, but it looks like a std::string constructo=
r is
> being passed a NULL pointer. =C2=A0Do you have a core dump (to get a
> backtrace)? =C2=A0Which version are you running (`cmon -v`)?

The cmon version is v0.21.1 when the crash happen and been updated to v=
0.21.2.
The following backtrace is from v0.21.2:

# gdb cmon core
GNU gdb (GDB) 7.1-ubuntu
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
=2Ehtml>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.=C2=A0=C2=A0Type "=
show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu".
=46or bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/bin/cmon...(no debugging symbols found)...don=
e.

warning: exec file is newer than core file.
[New Thread 17644]
warning: Can't read pathname for load map: Input/output error.
Reading symbols from /lib/tls/i686/cmov/libpthread.so.0...(no
debugging symbols found)...done.
Loaded symbols for /lib/tls/i686/cmov/libpthread.so.0
Reading symbols from /lib/i686/cmov/libcrypto.so.0.9.8...(no debugging
symbols found)...done.
Loaded symbols for /lib/i686/cmov/libcrypto.so.0.9.8
Reading symbols from /usr/lib/libstdc++.so.6...(no debugging symbols
found)...done.
Loaded symbols for /usr/lib/libstdc++.so.6
Reading symbols from /lib/tls/i686/cmov/libm.so.6...(no debugging
symbols found)...done.
Loaded symbols for /lib/tls/i686/cmov/libm.so.6
Reading symbols from /lib/libgcc_s.so.1...(no debugging symbols found).=
=2E.done.
Loaded symbols for /lib/libgcc_s.so.1
Reading symbols from /lib/tls/i686/cmov/libc.so.6...(no debugging
symbols found)...done.
Loaded symbols for /lib/tls/i686/cmov/libc.so.6
Reading symbols from /lib/ld-linux.so.2...(no debugging symbols found).=
=2E.done.
Loaded symbols for /lib/ld-linux.so.2
Reading symbols from /lib/tls/i686/cmov/libdl.so.2...(no debugging
symbols found)...done.
Loaded symbols for /lib/tls/i686/cmov/libdl.so.2
Reading symbols from /lib/libz.so.1...(no debugging symbols found)...do=
ne.
Loaded symbols for /lib/libz.so.1
Core was generated by `/usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.175=
98'.
Program terminated with signal 6, Aborted.
#0=C2=A0=C2=A00x001be422 in __kernel_vsyscall ()

(gdb)bt
#0=C2=A0=C2=A00x001be422 in __kernel_vsyscall ()
#1=C2=A0=C2=A00x00c2d651 in raise () from /lib/tls/i686/cmov/libc.so.6
#2=C2=A0=C2=A00x00c30a82 in abort () from /lib/tls/i686/cmov/libc.so.6
#3=C2=A0=C2=A00x0050a52f in __gnu_cxx::__verbose_terminate_handler() ()=
 from
/usr/lib/libstdc++.so.6
#4=C2=A0=C2=A00x00508465 in ?? () from /usr/lib/libstdc++.so.6
#5=C2=A0=C2=A00x005084a2 in std::terminate() () from /usr/lib/libstdc++=
=2Eso.6
#6=C2=A0=C2=A00x005085e1 in __cxa_throw () from /usr/lib/libstdc++.so.6
#7=C2=A0=C2=A00x0049f57f in std::__throw_logic_error(char const*) () fr=
om
/usr/lib/libstdc++.so.6
#8=C2=A0=C2=A00x004e3b82 in ?? () from /usr/lib/libstdc++.so.6
#9=C2=A0=C2=A00x004e3da2 in std::basic_string<char, std::char_traits<ch=
ar>,
std::allocator<char> >::basic_string(char const*, unsigned int,
std::allocator<char> const&) () from /usr/lib/libstdc++.so.6
#10 0x08088744 in main ()
(gdb)
>
> > Q2:
> > How to expand a monitor to a running ceph system?
>
> The process in that wiki article can expand the monitor cluster while=
 it
> is online. =C2=A0Note that the monitor identication changed slightly =
between
> v0.21 and the current unstable branch (will be v0.22), and the
> instructions still need to be updated for that.
>
> > Q3
> > =C2=A0 =C2=A0Is it possible to add mds when the ceph system is runn=
ing? how?
>
> Yes. =C2=A0Add the new mds to ceph.conf, start the daemon. =C2=A0You =
should see it
> as up:standby in the 'ceph -s' or 'ceph mds dump -o -' output. =C2=A0=
Then
>
> =C2=A0ceph mds setmaxmds 2
>
> change the size of the 'active' cluster to 2.
>
> Please keep in mind the clustered MDS still has some bugs; we expect =
v0.22
> to be stable.

Thanks,I will wait for v0.22 and try to add mds then,but I want to is
my config for mds is right.

I set 2 mds in ceph.conf

[mds]
        keyring =3D /etc/ceph/keyring.$name
        debug ms =3D 1
[mds.ceph01]
        host =3D ceph01
[mds.ceph02]
=C2=A0=C2=A0 =C2=A0 =C2=A0host =3D ceph02

The result for 'ceph=C2=A0=E2=80=93s':

  10.09.01_17:56:19.337895=C2=A0=C2=A0=C2=A0mds e17: 1/1/1 up {0=3Dup:a=
ctive}, 1 up:standby

But now=C2=A0the result for 'ceph=C2=A0=E2=80=93s' is:

  10.09.19_17:01:50.398809=C2=A0=C2=A0=C2=A0mds e27: 1/1/1 up {0=3Dup:a=
ctive}

The result for '

  ceph mds dump -o =E2=80=93' is:
  10.09.19_17:05:10.263142 mon <- [mds,dump]
  10.09.19_17:05:10.264095 mon0 -> 'dumped mdsmap epoch 27' (0)
  epoch 27
  client_epoch 0
  created 10.08.26_03:27:01.753124
  modified 10.09.11_00:42:41.691011
  tableserver 0
  root 0
  session_timeout 60
  session_autoclose 300
  compat=C2=A0=C2=A0compat=3D{},rocompat=3D{},incompat=3D{1=3Dbase v0.2=
0}
  max_mds 1
  in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
  up=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{0=3D4298}
  failed
  stopped
  4298:=C2=A0=C2=A0=C2=A0192.168.2.51:6800/3780=C2=A0'ceph02' mds0.6 up=
:active seq 260551
  10.09.19_17:05:10.264231 wrote 321 byte payload to -

I don=E2=80=99t quite understand what the infomation means?Does it mean=
 1 mds
was down?how should I handle it?
>
> >
> > I fdisked a HDD into two partition, one for journal, other one for =
data like this:
> > /dev/sdc1=C3=BF=C3=BF180GB=C3=BF=C3=BFas data
> > dev/sdc2=C3=BF=C3=BF10GB=C3=BF=C3=BFas journal
> >
> > /dev/sdc1 made as btrfs, mount to /mnt/osd0/data
> > /dev/sdc2 made as btrfs, mount to /mnt/osd0/journal
> >
> > ceph.conf:
> >
> > [osd]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd data =3D /mnt/ceph/osd$id/data
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal =3D /mnt/ceph/osd$id/journa=
l
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; osd journal size =3D 100
> >
> > When I use mkcephfs command, I can't build osd until I edited ceph.=
conf like this:
> >
> > [osd]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd data =3D /mnt/ceph/osd$id/data
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal =3D /mnt/ceph/osd$id/data/j=
ournal
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 osd journal size =3D 100
>
> If the journal is a file, the system won't create it for you unless y=
ou
> specify a size. =C2=A0If it already exists (e.g., you created it via =
'dd', or
> it's a block device) the journal size isn't needed.
>
> > Q4.
> > How to set the journal path to a device or patition?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal =3D /dev/sdc1 =C2=A0; or whate=
ver

How to know which journal is for certain osd?
Can the following config does that?

[osd]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sudo =3D true
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0osd data =3D /mnt/ceph/=
osd$id/data
[osd0]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0host =3D ceph01
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal =3D /dev/sdc1

If I make a partition for journal in a 500GB hdd,what is the proper
size for the partition?

thanks.
Lin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
