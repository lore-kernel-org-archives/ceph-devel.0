From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Re: problem with ceph init scripts
Date: Mon, 28 Feb 2011 14:10:36 +0530
Message-ID: <AANLkTi=AKt1yc21Dc+cwq1SrH6-fJkb2FLgPzHhSaNVB@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
	<AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
	<AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
	<AANLkTi=yoPPo0HGn8tQgqRxuHNVfsoEYXGcuNpkc6G7Q@mail.gmail.com>
	<AANLkTin3HgsAsHgnMfHpwEeBm4CXNR=8oJZJT8jxsKA8@mail.gmail.com>
	<41D89B225A1D402EA408F47C8B9F9A60@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65381 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1B1Iki convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Feb 2011 03:40:38 -0500
Received: by wwb22 with SMTP id 22so2767702wwb.1
        for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 00:40:36 -0800 (PST)
In-Reply-To: <41D89B225A1D402EA408F47C8B9F9A60@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg
I am running mkcepfs as the first step of cluster and then use init
ceph to start all node and this works fine
When trying to stop cluser it does not happen and starting a single
osd for also dont work.

On Sat, Feb 26, 2011 at 5:58 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
>
> Sorry, we kind of lost this in the shuffle!
>
> Did you manage to resolve this issue? From what I see in your steps b=
elow, it looks like you're doing things in the wrong order -- mkcephfs =
should always be the first thing you do. If you really have nodes runni=
ng before you do mkcephfs I suspect you just got your cluster into an i=
nconsistent state and the (fairly fragile) methods it uses to shut down=
 all the daemons got broken.
> -Greg
> On Friday, February 18, 2011 at 6:11 AM, Upendra Moturi wrote:
> > Hi Colin
> >
> > I am using the ubuntu 11.04 (32 bit) and got the ceph package from =
apt-get
> > i am using the default init script.(Found at /etc/init.d/ceph)
> >
> > Regarding issue 1)
> >
> > On the osd node I tried to start that osd but it did not work
> > Steps followed
> >
> > 1) Started 3 nodes(ceph.conf is same as i sent earlier)
> >
> > 2) mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyrin=
g.bin
> >
> > 3)/etc/init.d/ceph start osd0 (Did this on first osd)
> >
> > 4) ps -ef | grep ceph or ps -ef | grep cosd ---- does not show any =
process
> >
> > 5)/etc/init.d/ceph -a start ---- shows all process on all nodes
> >
> > Regading Issue 2
> > It says -x option is not available
> >
> > Tried /etc/init.d/ceph -ax stop and /etc/init.d/ceph -x stop and ev=
en
> > tried /etc/init.d/ceph -x -a stop
> > but nothing worked.
> >
> > Then tried with /etc/init.d/ceph -a -v stop this also did not stop
> > ceph on all nodes but got the output as
> >
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "ssh path" "/etc/=
ceph"
> > =3D=3D=3D mon.0 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "pid file"
> > "/var/run/ceph/mon.0.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "log sym dir" ""
> > --- ssh ceph0 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon "post stop comman=
d" ""
> > Stopping Ceph mon.0 on ceph0...--- ssh ceph0 "cd /etc/ceph ; ulimit
> > -c unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/mon.0.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/mon.0.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > kill 1668...done
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "ssh path" "/etc/=
ceph"
> > =3D=3D=3D mon.1 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "pid file"
> > "/var/run/ceph/mon.1.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "log sym dir" ""
> > --- ssh ceph1 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon "post stop comman=
d" ""
> > Stopping Ceph mon.1 on ceph1...--- ssh ceph1 "cd /etc/ceph ; ulimit
> > -c unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/mon.1.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/mon.1.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > done
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "ssh path" "/etc/=
ceph"
> > =3D=3D=3D mon.2 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "pid file"
> > "/var/run/ceph/mon.2.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "log sym dir" ""
> > --- ssh ceph2 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon "post stop comman=
d" ""
> > Stopping Ceph mon.2 on ceph2...--- ssh ceph2 "cd /etc/ceph ; ulimit
> > -c unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/mon.2.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/mon.2.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > done
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "ssh path" "/etc/=
ceph"
> > =3D=3D=3D mds.0 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "pid file"
> > "/var/run/ceph/mds.0.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "log sym dir" ""
> > --- ssh ceph0 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds "post stop comman=
d" ""
> > Stopping Ceph mds0 on ceph0...--- ssh ceph0 "cd /etc/ceph ; ulimit =
-c
> > unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/mds.0.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/mds.0.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > kill 1844...done
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "ssh path" "/etc/=
ceph"
> > =3D=3D=3D mds.1 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "pid file"
> > "/var/run/ceph/mds.1.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "log sym dir" ""
> > --- ssh ceph1 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds "post stop comman=
d" ""
> > Stopping Ceph mds1 on ceph1...--- ssh ceph1 "cd /etc/ceph ; ulimit =
-c
> > unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/mds.1.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/mds.1.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > done
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "ssh path" "/etc/=
ceph"
> > =3D=3D=3D osd.0 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "pid file"
> > "/var/run/ceph/osd.0.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "log sym dir" ""
> > --- ssh ceph0 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "osd data" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "btrfs path" "/da=
ta/osd0"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "btrfs devs" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd "post stop comman=
d" ""
> > Stopping Ceph osd0 on ceph0...--- ssh ceph0 "cd /etc/ceph ; ulimit =
-c
> > unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/osd.0.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/osd.0.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > kill 2033...done
> > Unmounting Btrfs on ceph0:/data/osd0
> > --- ssh root@ceph0 "cd /etc/ceph ; ulimit -c unlimited ; umount
> > /data/osd0 || true"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "ssh path" "/etc/=
ceph"
> > =3D=3D=3D osd.1 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "pid file"
> > "/var/run/ceph/osd.1.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "log sym dir" ""
> > --- ssh ceph1 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "osd data" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "btrfs path" "/da=
ta/osd1"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "btrfs devs" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd "post stop comman=
d" ""
> > Stopping Ceph osd1 on ceph1...--- ssh ceph1 "cd /etc/ceph ; ulimit =
-c
> > unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/osd.1.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/osd.1.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > done
> > Unmounting Btrfs on ceph1:/data/osd1
> > --- ssh root@ceph1 "cd /etc/ceph ; ulimit -c unlimited ; umount
> > /data/osd1 || true"
> > umount: /data/osd1: device is busy.
> > =A0(In some cases useful info about processes that use
> > =A0the device is found by lsof(8) or fuser(1))
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "auto start" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "user" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "ssh path" "/etc/=
ceph"
> > =3D=3D=3D osd.2 =3D=3D=3D
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "pid file"
> > "/var/run/ceph/osd.2.pid"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "log dir" "/var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "log sym dir" ""
> > --- ssh ceph2 "cd /etc/ceph ; ulimit -c unlimited ; mkdir -p /var/l=
og/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "osd data" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "btrfs path" "/da=
ta/osd2"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "btrfs devs" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "lock file"
> > "/var/lock/subsys/ceph"
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "pre stop command=
" ""
> > /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd "post stop comman=
d" ""
> > Stopping Ceph osd2 on ceph2...--- ssh ceph2 "cd /etc/ceph ; ulimit =
-c
> > unlimited ; while [ 1 ]; do
> > =A0[ -e /var/run/ceph/osd.2.pid ] || break
> > =A0pid=3D`cat /var/run/ceph/osd.2.pid`
> > =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pid/cmdline ; do
> > =A0cmd=3D"kill $pid"
> > =A0echo -n $cmd...
> > =A0$cmd
> > =A0sleep 1
> > =A0continue
> > =A0done
> > =A0break
> > =A0done"
> > done
> > Unmounting Btrfs on ceph2:/data/osd2
> > --- ssh root@ceph2 "cd /etc/ceph ; ulimit -c unlimited ; umount
> > /data/osd2 || true"
> > umount: /data/osd2: device is busy.
> > =A0(In some cases useful info about processes that use
> > =A0the device is found by lsof(8) or fuser(1))
> >
> >
> >
> >
> > On Fri, Feb 18, 2011 at 12:35 PM, Colin McCabe <cmccabe@alumni.cmu.=
edu> wrote:
> > > Hi Upendra,
> > >
> > > Are you running init-ceph from the source directory? If you do th=
at,
> > > it will use the ceph.conf in the source directory itself, which i=
s
> > > probably not what you want. So it might be good to double-check t=
hat.
> > >
> > > If all else fails, running init-ceph with -x will show you exactl=
y
> > > what the script is doing. If all goes well, its exit status shoul=
d be
> > > 0. Are you getting exit status 0?
> > >
> > > Colin
> > >
> > >
> > > On Thu, Feb 17, 2011 at 1:55 AM, Upendra Moturi <upendra.m@hexagr=
id.com> wrote:
> > > > Hi Colin
> > > >
> > > > Here is my ceph.conf :
> > > >
> > > > [global]
> > > > =A0pid file =3D /var/run/ceph/$name.pid
> > > > =A0debug ms =3D 1
> > > > [mon]
> > > > mon data =3D /data/mon$id
> > > > [mon.0]
> > > > host =3D ceph0
> > > > mon addr =3D 192.168.155.5:6789
> > > > [mon.1]
> > > > host =3D ceph1
> > > > mon addr =3D 192.168.155.6:6789
> > > > [mon.2]
> > > > host =3D ceph2
> > > > mon addr =3D 192.168.155.7:6789
> > > > [mds]
> > > >
> > > > [mds0]
> > > > host =3D ceph0
> > > > [mds1]
> > > > host =3D ceph1
> > > >
> > > > [osd]
> > > > sudo =3D true
> > > > osd data =3D /data/osd$id
> > > > osd journal =3D /data/osd$id/journal
> > > > osd journal size =3D 512
> > > > osd use stale snap =3D true
> > > > [osd0]
> > > > host =3D ceph0
> > > > btrfs devs =3D /dev/sdb
> > > > [osd1]
> > > > host =3D ceph1
> > > > btrfs devs =3D /dev/sdb
> > > > [osd2]
> > > > host =3D ceph2
> > > > btrfs devs =3D /dev/sdb
> > > >
> > > >
> > > >
> > > >
> > > > On Thu, Feb 17, 2011 at 1:06 PM, Colin McCabe <cmccabe@alumni.c=
mu.edu> wrote:
> > > > > I'm using head of line from the master branch. But that parti=
cular
> > > > > code hasn't changed since January, which is 0.24.2 is from.
> > > > >
> > > > > In my ceph.conf, I just had an osd that was on a remote machi=
ne, and
> > > > > everything else local.
> > > > >
> > > > > If you could post your ceph.conf here or in IRC, perhaps we m=
ight spot
> > > > > an issue that's causing the problems that you see.
> > > > >
> > > > > Colin
> > > > >
> > > > >
> > > > > On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@h=
exagrid.com> wrote:
> > > > > > Hi Colin
> > > > > > I am using
> > > > > > ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d=
90831bb7
> > > > > > ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generi=
c
> > > > > >
> > > > > > Installed ceph form apt source.
> > > > > >
> > > > > > With above configurations i still able yo reproduce.
> > > > > > Can you please share me ur configurations?
> > > > > >
> > > > > > On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alum=
ni.cmu.edu> wrote:
> > > > > > > On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@al=
umni.cmu.edu> wrote:
> > > > > > > > On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendr=
a.m@hexagrid.com> wrote:
> > > > > > > > > But if we want to start a particular osd or mon or md=
s ,its not
> > > > > > > > > working and there is no error
> > > > > > > > > eg:/etc/init.d/ceph start osd1 does not start osd1 an=
d don't get any error
> > > > > > > >
> > > > > > > > That is expected, unless you are running init-ceph on t=
he same node as
> > > > > > > > osd1 is on.
> > > > > > > >
> > > > > > > > It might be nice to have some kind of interface like "r=
un command X on
> > > > > > > > osd1", but init-ceph is not that.
> > > > > > > >
> > > > > > > > > /etc/init.d/ceph -a stop also does not stop ceph on a=
ll nodes.It stops
> > > > > > > > > on current node only
> > > > > > > > > where as
> > > > > > > > > /etc/init.d/ceph -a killall works fine.
> > > > > > > >
> > > > > > > > That sounds like a bug. I'll see if I can fix it.
> > > > > > >
> > > > > > > I'm afraid I can't reproduce this.
> > > > > > >
> > > > > > > I ran /etc/init.d/ceph -a stop
> > > > > > >
> > > > > > > and it stopped ceph daemons running on remote nodes too. =
Looking at
> > > > > > > the code, it looks correct.
> > > > > > >
> > > > > > > Colin
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks and Regards,
> > > > > > Upendra.M
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks and Regards,
> > > > Upendra.M
> >
> >
> >
> > --
> > Thanks and Regards,
> > Upendra.M
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> >
>



--
Thanks and Regards,
Upendra.M
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
