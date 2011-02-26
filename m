From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: problem with ceph init scripts
Date: Fri, 25 Feb 2011 16:28:50 -0800
Message-ID: <AANLkTimzNG7Cdh554OCtBmhm9Z0aP1fGD1oAtCze4C54@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
	<AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
	<AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
	<AANLkTi=yoPPo0HGn8tQgqRxuHNVfsoEYXGcuNpkc6G7Q@mail.gmail.com>
	<AANLkTin3HgsAsHgnMfHpwEeBm4CXNR=8oJZJT8jxsKA8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37030 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977Ab1BZA3T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 19:29:19 -0500
Received: by fxm17 with SMTP id 17so2261483fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 16:29:18 -0800 (PST)
In-Reply-To: <AANLkTin3HgsAsHgnMfHpwEeBm4CXNR=8oJZJT8jxsKA8@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

Hi Upendra,

Based on the output you posted, init-ceph is doing something on every
node. However, I only see a kill for certain nodes.

Does /var/run/ceph/ exist on all nodes, or just some of them? Does the
appropriate pid file exist on all nodes? What happens when you ssh in
to those nodes manually and run init-ceph stop?

Colin


On Fri, Feb 18, 2011 at 6:11 AM, Upendra Moturi <upendra.m@hexagrid.com=
> wrote:
> Hi Colin
>
> I am using the ubuntu 11.04 (32 bit) and got the ceph package from ap=
t-get
> i am using the default init script.(Found at /etc/init.d/ceph)
>
> Regarding issue 1)
>
> On the osd node I tried to start that osd but it did not work
> Steps followed
>
> 1) Started 3 nodes(ceph.conf is same as i sent earlier)
>
> 2) =A0mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyri=
ng.bin
>
> 3)/etc/init.d/ceph start osd0 =A0(Did this on first osd)
>
> 4) ps -ef | grep ceph =A0or ps -ef | grep cosd ---- does not show any=
 process
>
> 5)/etc/init.d/ceph =A0-a start ---- shows all process on all nodes
>
> Regading Issue 2
> It says -x option is not available
>
> Tried /etc/init.d/ceph -ax stop and /etc/init.d/ceph -x stop and even
> tried =A0/etc/init.d/ceph -x -a stop
> but nothing worked.
>
> Then tried with /etc/init.d/ceph -a -v stop this also did not stop
> ceph on all nodes but got the output as
>
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D mon.0 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"pid file"
> "/var/run/ceph/mon.0.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"log sym dir" ""
> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"post stop comma=
nd" ""
> Stopping Ceph mon.0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; ulimi=
t
> -c unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.0.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.0.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> kill 1668...done
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D mon.1 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"pid file"
> "/var/run/ceph/mon.1.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"log sym dir" ""
> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"post stop comma=
nd" ""
> Stopping Ceph mon.1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; ulimi=
t
> -c unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.1.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.1.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> done
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D mon.2 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"pid file"
> "/var/run/ceph/mon.2.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"log sym dir" ""
> --- ssh ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"post stop comma=
nd" ""
> Stopping Ceph mon.2 on ceph2...--- ssh ceph2 =A0"cd /etc/ceph ; ulimi=
t
> -c unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.2.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.2.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> done
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D mds.0 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"pid file"
> "/var/run/ceph/mds.0.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"log sym dir" ""
> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"post stop comma=
nd" ""
> Stopping Ceph mds0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; ulimit=
 -c
> unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mds.0.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mds.0.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> kill 1844...done
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D mds.1 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"pid file"
> "/var/run/ceph/mds.1.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"log sym dir" ""
> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"post stop comma=
nd" ""
> Stopping Ceph mds1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; ulimit=
 -c
> unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mds.1.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mds.1.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> done
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D osd.0 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"pid file"
> "/var/run/ceph/osd.0.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"log sym dir" ""
> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"osd data" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs path" "/d=
ata/osd0"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs devs" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"post stop comma=
nd" ""
> Stopping Ceph osd0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; ulimit=
 -c
> unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.0.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.0.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> kill 2033...done
> Unmounting Btrfs on ceph0:/data/osd0
> --- ssh root@ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; umount
> /data/osd0 || true"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D osd.1 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"pid file"
> "/var/run/ceph/osd.1.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"log sym dir" ""
> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"osd data" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"btrfs path" "/d=
ata/osd1"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"btrfs devs" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"post stop comma=
nd" ""
> Stopping Ceph osd1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; ulimit=
 -c
> unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.1.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.1.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> done
> Unmounting Btrfs on ceph1:/data/osd1
> --- ssh root@ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; umount
> /data/osd1 || true"
> umount: /data/osd1: device is busy.
> =A0 =A0 =A0 =A0(In some cases useful info about processes that use
> =A0 =A0 =A0 =A0 the device is found by lsof(8) or fuser(1))
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"auto start" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"user" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"ssh path" "/etc=
/ceph"
> =3D=3D=3D osd.2 =3D=3D=3D
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"pid file"
> "/var/run/ceph/osd.2.pid"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"log dir" "/var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"log sym dir" ""
> --- ssh ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/=
log/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"osd data" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"btrfs path" "/d=
ata/osd2"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"btrfs devs" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"lock file"
> "/var/lock/subsys/ceph"
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"pre stop comman=
d" ""
> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"post stop comma=
nd" ""
> Stopping Ceph osd2 on ceph2...--- ssh ceph2 =A0"cd /etc/ceph ; ulimit=
 -c
> unlimited ; while [ 1 ]; do
> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.2.pid ] || break
> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.2.pid`
> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmd=
line ; do
> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
> =A0 =A0 =A0 =A0 =A0 =A0$cmd
> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
> =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0break
> =A0 =A0done"
> done
> Unmounting Btrfs on ceph2:/data/osd2
> --- ssh root@ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; umount
> /data/osd2 || true"
> umount: /data/osd2: device is busy.
> =A0 =A0 =A0 =A0(In some cases useful info about processes that use
> =A0 =A0 =A0 =A0 the device is found by lsof(8) or fuser(1))
>
>
>
>
> On Fri, Feb 18, 2011 at 12:35 PM, Colin McCabe <cmccabe@alumni.cmu.ed=
u> wrote:
>> Hi Upendra,
>>
>> Are you running init-ceph from the source directory? If you do that,
>> it will use the ceph.conf in the source directory itself, which is
>> probably not what you want. So it might be good to double-check that=
=2E
>>
>> If all else fails, running init-ceph with -x will show you exactly
>> what the script is doing. If all goes well, its exit status should b=
e
>> 0. Are you getting exit status 0?
>>
>> Colin
>>
>>
>> On Thu, Feb 17, 2011 at 1:55 AM, Upendra Moturi <upendra.m@hexagrid.=
com> wrote:
>>> Hi Colin
>>>
>>> Here is my ceph.conf :
>>>
>>> [global]
>>> =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
>>> =A0 =A0 =A0 debug ms =3D 1
>>> [mon]
>>> =A0 =A0 =A0 =A0mon data =3D /data/mon$id
>>> [mon.0]
>>> =A0 =A0 =A0 =A0host =3D ceph0
>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.5:6789
>>> [mon.1]
>>> =A0 =A0 =A0 =A0host =3D ceph1
>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.6:6789
>>> [mon.2]
>>> =A0 =A0 =A0 =A0host =3D ceph2
>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.7:6789
>>> [mds]
>>>
>>> [mds0]
>>> =A0 =A0 =A0 =A0host =3D ceph0
>>> [mds1]
>>> =A0 =A0 =A0 =A0host =3D ceph1
>>>
>>> [osd]
>>> =A0 =A0 =A0 =A0sudo =3D true
>>> =A0 =A0 =A0 =A0osd data =3D /data/osd$id
>>> =A0 =A0 =A0 =A0osd journal =3D /data/osd$id/journal
>>> =A0 =A0 =A0 =A0osd journal size =3D 512
>>> =A0 =A0 =A0 =A0osd use stale snap =3D true
>>> [osd0]
>>> =A0 =A0 =A0 =A0host =3D ceph0
>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>> [osd1]
>>> =A0 =A0 =A0 =A0host =3D ceph1
>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>> [osd2]
>>> =A0 =A0 =A0 =A0host =3D ceph2
>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>>
>>>
>>>
>>>
>>> On Thu, Feb 17, 2011 at 1:06 PM, Colin McCabe <cmccabe@alumni.cmu.e=
du> wrote:
>>>> I'm using head of line from the master branch. But that particular
>>>> code hasn't changed since January, which is 0.24.2 is from.
>>>>
>>>> In my ceph.conf, I just had an osd that was on a remote machine, a=
nd
>>>> everything else local.
>>>>
>>>> If you could post your ceph.conf here or in IRC, perhaps we might =
spot
>>>> an issue that's causing the problems that you see.
>>>>
>>>> Colin
>>>>
>>>>
>>>> On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@hexagr=
id.com> wrote:
>>>>> Hi Colin
>>>>> I am using
>>>>> ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d90831b=
b7
>>>>> ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic
>>>>>
>>>>> Installed ceph form apt source.
>>>>>
>>>>> With above configurations i still able yo reproduce.
>>>>> Can you please share me ur configurations?
>>>>>
>>>>> On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumni.cmu=
=2Eedu> wrote:
>>>>>> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cm=
u.edu> wrote:
>>>>>>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexa=
grid.com> wrote:
>>>>>>>> But if we want to start a particular osd or mon or mds ,its no=
t
>>>>>>>> working and there is no error
>>>>>>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don'=
t get any error
>>>>>>>
>>>>>>> That is expected, unless you are running init-ceph on the same =
node as
>>>>>>> osd1 is on.
>>>>>>>
>>>>>>> It might be nice to have some kind of interface like "run comma=
nd X on
>>>>>>> osd1", but init-ceph is not that.
>>>>>>>
>>>>>>>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.=
It stops
>>>>>>>> on current node only
>>>>>>>> where as
>>>>>>>> /etc/init.d/ceph -a killall works fine.
>>>>>>>
>>>>>>> That sounds like a bug. I'll see if I can fix it.
>>>>>>
>>>>>> I'm afraid I can't reproduce this.
>>>>>>
>>>>>> I ran /etc/init.d/ceph -a stop
>>>>>>
>>>>>> and it stopped ceph daemons running on remote nodes too. Looking=
 at
>>>>>> the code, it looks correct.
>>>>>>
>>>>>> Colin
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Thanks and Regards,
>>>>> Upendra.M
>>>>>
>>>>
>>>
>>>
>>>
>>> --
>>> Thanks and Regards,
>>> Upendra.M
>>>
>>
>
>
>
> --
> Thanks and Regards,
> Upendra.M
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
