From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Re: problem with ceph init scripts
Date: Wed, 2 Mar 2011 14:48:09 +0530
Message-ID: <AANLkTimr1hp=Dqp9xtVtPxMv6sQ5cEX1TCUpjTN-knai@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
	<AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
	<AANLkTikY8TeWBtFFGKsWVUd22ZwZpsvASj_4Q_oWkyAW@mail.gmail.com>
	<AANLkTi=yoPPo0HGn8tQgqRxuHNVfsoEYXGcuNpkc6G7Q@mail.gmail.com>
	<AANLkTin3HgsAsHgnMfHpwEeBm4CXNR=8oJZJT8jxsKA8@mail.gmail.com>
	<AANLkTimzNG7Cdh554OCtBmhm9Z0aP1fGD1oAtCze4C54@mail.gmail.com>
	<AANLkTi=in7bq8egokfOFZV_UGbuB22=vdmVH6DAOMB_U@mail.gmail.com>
	<AANLkTi=ar_DBafHKwiyw7L+j4U2d05cgu0YVW3NLn2To@mail.gmail.com>
	<AANLkTikgFjO9FxcDc5sH3xiSHKF=a+eWSpcV9Eb0Czw4@mail.gmail.com>
	<AANLkTimSuX_K6UJ698TUMXhg135UOr216xtwHt+tFeYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37300 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab1CBJSK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 04:18:10 -0500
Received: by wwb22 with SMTP id 22so5590024wwb.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2011 01:18:09 -0800 (PST)
In-Reply-To: <AANLkTimSuX_K6UJ698TUMXhg135UOr216xtwHt+tFeYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

I was on the same node as osd0 ,but still it did not work.
When i see /etc/init.d/ceph file,it is not even going into that start c=
ase


On Tue, Mar 1, 2011 at 11:04 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> Hi Upendra,
>
> You should be on the same node as osd0 in order to start osd0.
>
> There is that wacky -a option, at least until we decide to remove it.
> But my advice is not to use that. Set up something like dsh.
>
> cheers,
> Colin
>
>
> On Tue, Mar 1, 2011 at 3:55 AM, Upendra Moturi <upendra.m@hexagrid.co=
m> wrote:
>> Hi Colin
>>
>> Creating /var/run/ceph directory on every node has made it
>> working.(/etc/init.d/ceph -a stop)
>> But /etc/init.d/ceph start osd0 =A0still does not work
>>
>> /etc/init.d/ceph -v start osd0
>> Gives output as
>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"auto start" ""
>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"user" ""
>>
>> I have tried this on same node where osd0 is present
>>
>> Had a look at /etc/init.d/ceph and it does not enter the case start.
>>
>>
>> On Mon, Feb 28, 2011 at 10:27 PM, Colin McCabe <cmccabe@alumni.cmu.e=
du> wrote:
>>> On Mon, Feb 28, 2011 at 4:00 AM, Upendra Moturi <upendra.m@hexagrid=
=2Ecom> wrote:
>>>> Hi Colin
>>>>
>>>> /var/run/ceph exist on only one node(the node on which i start the
>>>> cluster with -a)
>>>
>>> Without /var/run/ceph/pid, the init script will not know which pid =
to
>>> kill. So it will do nothing.
>>>
>>> Try creating /var/run/ceph and other appropriate directories on all
>>> nodes before starting the cluster.
>>>
>>> Colin
>>>
>>>
>>>>
>>>> On Sat, Feb 26, 2011 at 5:58 AM, Colin McCabe <cmccabe@alumni.cmu.=
edu> wrote:
>>>>> Hi Upendra,
>>>>>
>>>>> Based on the output you posted, init-ceph is doing something on e=
very
>>>>> node. However, I only see a kill for certain nodes.
>>>>>
>>>>> Does /var/run/ceph/ exist on all nodes, or just some of them? Doe=
s the
>>>>> appropriate pid file exist on all nodes? What happens when you ss=
h in
>>>>> to those nodes manually and run init-ceph stop?
>>>>>
>>>>> Colin
>>>>>
>>>>>
>>>>> On Fri, Feb 18, 2011 at 6:11 AM, Upendra Moturi <upendra.m@hexagr=
id.com> wrote:
>>>>>> Hi Colin
>>>>>>
>>>>>> I am using the ubuntu 11.04 (32 bit) and got the ceph package fr=
om apt-get
>>>>>> i am using the default init script.(Found at /etc/init.d/ceph)
>>>>>>
>>>>>> Regarding issue 1)
>>>>>>
>>>>>> On the osd node I tried to start that osd but it did not work
>>>>>> Steps followed
>>>>>>
>>>>>> 1) Started 3 nodes(ceph.conf is same as i sent earlier)
>>>>>>
>>>>>> 2) =A0mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/=
keyring.bin
>>>>>>
>>>>>> 3)/etc/init.d/ceph start osd0 =A0(Did this on first osd)
>>>>>>
>>>>>> 4) ps -ef | grep ceph =A0or ps -ef | grep cosd ---- does not sho=
w any process
>>>>>>
>>>>>> 5)/etc/init.d/ceph =A0-a start ---- shows all process on all nod=
es
>>>>>>
>>>>>> Regading Issue 2
>>>>>> It says -x option is not available
>>>>>>
>>>>>> Tried /etc/init.d/ceph -ax stop and /etc/init.d/ceph -x stop and=
 even
>>>>>> tried =A0/etc/init.d/ceph -x -a stop
>>>>>> but nothing worked.
>>>>>>
>>>>>> Then tried with /etc/init.d/ceph -a -v stop this also did not st=
op
>>>>>> ceph on all nodes but got the output as
>>>>>>
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D mon.0 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"pid file"
>>>>>> "/var/run/ceph/mon.0.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"log sym di=
r" ""
>>>>>> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon =A0"post stop =
command" ""
>>>>>> Stopping Ceph mon.0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; =
ulimit
>>>>>> -c unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.0.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.0.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> kill 1668...done
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D mon.1 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"pid file"
>>>>>> "/var/run/ceph/mon.1.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"log sym di=
r" ""
>>>>>> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mon =A0"post stop =
command" ""
>>>>>> Stopping Ceph mon.1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; =
ulimit
>>>>>> -c unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.1.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.1.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> done
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D mon.2 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"pid file"
>>>>>> "/var/run/ceph/mon.2.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"log sym di=
r" ""
>>>>>> --- ssh ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t mon =A0"post stop =
command" ""
>>>>>> Stopping Ceph mon.2 on ceph2...--- ssh ceph2 =A0"cd /etc/ceph ; =
ulimit
>>>>>> -c unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mon.2.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mon.2.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmon /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> done
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D mds.0 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"pid file"
>>>>>> "/var/run/ceph/mds.0.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"log sym di=
r" ""
>>>>>> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds =A0"post stop =
command" ""
>>>>>> Stopping Ceph mds0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; u=
limit -c
>>>>>> unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mds.0.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mds.0.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> kill 1844...done
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D mds.1 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"pid file"
>>>>>> "/var/run/ceph/mds.1.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"log sym di=
r" ""
>>>>>> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t mds =A0"post stop =
command" ""
>>>>>> Stopping Ceph mds1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; u=
limit -c
>>>>>> unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/mds.1.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/mds.1.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cmds /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> done
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D osd.0 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"pid file"
>>>>>> "/var/run/ceph/osd.0.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"log sym di=
r" ""
>>>>>> --- ssh ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"osd data" =
""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs path=
" "/data/osd0"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"btrfs devs=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd =A0"post stop =
command" ""
>>>>>> Stopping Ceph osd0 on ceph0...--- ssh ceph0 =A0"cd /etc/ceph ; u=
limit -c
>>>>>> unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.0.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.0.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> kill 2033...done
>>>>>> Unmounting Btrfs on ceph0:/data/osd0
>>>>>> --- ssh root@ceph0 =A0"cd /etc/ceph ; ulimit -c unlimited ; umou=
nt
>>>>>> /data/osd0 || true"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D osd.1 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"pid file"
>>>>>> "/var/run/ceph/osd.1.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"log sym di=
r" ""
>>>>>> --- ssh ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"osd data" =
""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"btrfs path=
" "/data/osd1"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"btrfs devs=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 1 -t osd =A0"post stop =
command" ""
>>>>>> Stopping Ceph osd1 on ceph1...--- ssh ceph1 =A0"cd /etc/ceph ; u=
limit -c
>>>>>> unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.1.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.1.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> done
>>>>>> Unmounting Btrfs on ceph1:/data/osd1
>>>>>> --- ssh root@ceph1 =A0"cd /etc/ceph ; ulimit -c unlimited ; umou=
nt
>>>>>> /data/osd1 || true"
>>>>>> umount: /data/osd1: device is busy.
>>>>>> =A0 =A0 =A0 =A0(In some cases useful info about processes that u=
se
>>>>>> =A0 =A0 =A0 =A0 the device is found by lsof(8) or fuser(1))
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"auto start=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"user" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"ssh path" =
"/etc/ceph"
>>>>>> =3D=3D=3D osd.2 =3D=3D=3D
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"pid file"
>>>>>> "/var/run/ceph/osd.2.pid"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"log dir" "=
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"log sym di=
r" ""
>>>>>> --- ssh ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; mkdir -p =
/var/log/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"osd data" =
""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"btrfs path=
" "/data/osd2"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"btrfs devs=
" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"lock file"
>>>>>> "/var/lock/subsys/ceph"
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"pre stop c=
ommand" ""
>>>>>> /usr/bin/cconf -c /etc/ceph/ceph.conf -i 2 -t osd =A0"post stop =
command" ""
>>>>>> Stopping Ceph osd2 on ceph2...--- ssh ceph2 =A0"cd /etc/ceph ; u=
limit -c
>>>>>> unlimited ; while [ 1 ]; do
>>>>>> =A0 =A0 =A0 =A0[ -e /var/run/ceph/osd.2.pid ] || break
>>>>>> =A0 =A0 =A0 =A0pid=3D`cat /var/run/ceph/osd.2.pid`
>>>>>> =A0 =A0 =A0 =A0while [ -e /proc/$pid ] && grep -q cosd /proc/$pi=
d/cmdline ; do
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0cmd=3D"kill =A0$pid"
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0echo -n $cmd...
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0$cmd
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0sleep 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0continue
>>>>>> =A0 =A0 =A0 =A0done
>>>>>> =A0 =A0 =A0 =A0break
>>>>>> =A0 =A0done"
>>>>>> done
>>>>>> Unmounting Btrfs on ceph2:/data/osd2
>>>>>> --- ssh root@ceph2 =A0"cd /etc/ceph ; ulimit -c unlimited ; umou=
nt
>>>>>> /data/osd2 || true"
>>>>>> umount: /data/osd2: device is busy.
>>>>>> =A0 =A0 =A0 =A0(In some cases useful info about processes that u=
se
>>>>>> =A0 =A0 =A0 =A0 the device is found by lsof(8) or fuser(1))
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Fri, Feb 18, 2011 at 12:35 PM, Colin McCabe <cmccabe@alumni.c=
mu.edu> wrote:
>>>>>>> Hi Upendra,
>>>>>>>
>>>>>>> Are you running init-ceph from the source directory? If you do =
that,
>>>>>>> it will use the ceph.conf in the source directory itself, which=
 is
>>>>>>> probably not what you want. So it might be good to double-check=
 that.
>>>>>>>
>>>>>>> If all else fails, running init-ceph with -x will show you exac=
tly
>>>>>>> what the script is doing. If all goes well, its exit status sho=
uld be
>>>>>>> 0. Are you getting exit status 0?
>>>>>>>
>>>>>>> Colin
>>>>>>>
>>>>>>>
>>>>>>> On Thu, Feb 17, 2011 at 1:55 AM, Upendra Moturi <upendra.m@hexa=
grid.com> wrote:
>>>>>>>> Hi Colin
>>>>>>>>
>>>>>>>> Here is my ceph.conf :
>>>>>>>>
>>>>>>>> [global]
>>>>>>>> =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
>>>>>>>> =A0 =A0 =A0 debug ms =3D 1
>>>>>>>> [mon]
>>>>>>>> =A0 =A0 =A0 =A0mon data =3D /data/mon$id
>>>>>>>> [mon.0]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph0
>>>>>>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.5:6789
>>>>>>>> [mon.1]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph1
>>>>>>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.6:6789
>>>>>>>> [mon.2]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph2
>>>>>>>> =A0 =A0 =A0 =A0mon addr =3D 192.168.155.7:6789
>>>>>>>> [mds]
>>>>>>>>
>>>>>>>> [mds0]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph0
>>>>>>>> [mds1]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph1
>>>>>>>>
>>>>>>>> [osd]
>>>>>>>> =A0 =A0 =A0 =A0sudo =3D true
>>>>>>>> =A0 =A0 =A0 =A0osd data =3D /data/osd$id
>>>>>>>> =A0 =A0 =A0 =A0osd journal =3D /data/osd$id/journal
>>>>>>>> =A0 =A0 =A0 =A0osd journal size =3D 512
>>>>>>>> =A0 =A0 =A0 =A0osd use stale snap =3D true
>>>>>>>> [osd0]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph0
>>>>>>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>>>>>>> [osd1]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph1
>>>>>>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>>>>>>> [osd2]
>>>>>>>> =A0 =A0 =A0 =A0host =3D ceph2
>>>>>>>> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Thu, Feb 17, 2011 at 1:06 PM, Colin McCabe <cmccabe@alumni.=
cmu.edu> wrote:
>>>>>>>>> I'm using head of line from the master branch. But that parti=
cular
>>>>>>>>> code hasn't changed since January, which is 0.24.2 is from.
>>>>>>>>>
>>>>>>>>> In my ceph.conf, I just had an osd that was on a remote machi=
ne, and
>>>>>>>>> everything else local.
>>>>>>>>>
>>>>>>>>> If you could post your ceph.conf here or in IRC, perhaps we m=
ight spot
>>>>>>>>> an issue that's causing the problems that you see.
>>>>>>>>>
>>>>>>>>> Colin
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@h=
exagrid.com> wrote:
>>>>>>>>>> Hi Colin
>>>>>>>>>> I am using
>>>>>>>>>> ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d9=
0831bb7
>>>>>>>>>> ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic
>>>>>>>>>>
>>>>>>>>>> Installed ceph form apt source.
>>>>>>>>>>
>>>>>>>>>> With above configurations i still able yo reproduce.
>>>>>>>>>> Can you please share me ur configurations?
>>>>>>>>>>
>>>>>>>>>> On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumn=
i.cmu.edu> wrote:
>>>>>>>>>>> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alum=
ni.cmu.edu> wrote:
>>>>>>>>>>>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m=
@hexagrid.com> wrote:
>>>>>>>>>>>>> But if we want to start a particular osd or mon or mds ,i=
ts not
>>>>>>>>>>>>> working and there is no error
>>>>>>>>>>>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and=
 don't get any error
>>>>>>>>>>>>
>>>>>>>>>>>> That is expected, unless you are running init-ceph on the =
same node as
>>>>>>>>>>>> osd1 is on.
>>>>>>>>>>>>
>>>>>>>>>>>> It might be nice to have some kind of interface like "run =
command X on
>>>>>>>>>>>> osd1", but init-ceph is not that.
>>>>>>>>>>>>
>>>>>>>>>>>>> /etc/init.d/ceph -a stop also does not stop ceph on all n=
odes.It stops
>>>>>>>>>>>>> on current node only
>>>>>>>>>>>>> where as
>>>>>>>>>>>>> /etc/init.d/ceph -a killall works fine.
>>>>>>>>>>>>
>>>>>>>>>>>> That sounds like a bug. I'll see if I can fix it.
>>>>>>>>>>>
>>>>>>>>>>> I'm afraid I can't reproduce this.
>>>>>>>>>>>
>>>>>>>>>>> I ran /etc/init.d/ceph -a stop
>>>>>>>>>>>
>>>>>>>>>>> and it stopped ceph daemons running on remote nodes too. Lo=
oking at
>>>>>>>>>>> the code, it looks correct.
>>>>>>>>>>>
>>>>>>>>>>> Colin
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Thanks and Regards,
>>>>>>>>>> Upendra.M
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Thanks and Regards,
>>>>>>>> Upendra.M
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Thanks and Regards,
>>>>>> Upendra.M
>>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Thanks and Regards,
>>>> Upendra.M
>>>>
>>>
>>
>>
>>
>> --
>> Thanks and Regards,
>> Upendra.M
>>
>



--=20
Thanks and Regards,
Upendra.M
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
