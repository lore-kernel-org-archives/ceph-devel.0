From: Sage Weil <sage@inktank.com>
Subject: RE: [ceph-users] Scaling RBD module
Date: Tue, 24 Sep 2013 15:47:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309241535430.25142@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com> <523A4EFB.8040601@inktank.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A6AF@SACMBXIP01.sdcorp.global.sandisk.com> <523B4F39.9080109@inktank.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A738@SACMBXIP01.sdcorp.global.sandisk.com> <CACkq2mrfO+eFCYaEdoTQpJ2tOoDyVCkedSMAAztnQVYPBsv7gw@mail.gmail.com> <alpine.DEB.2.00.1309241413280.25142@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F199232CC@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1102609160-1380062838=:25142"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47788 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3IXWrT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 18:47:19 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F199232CC@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Travis Rhoden <trhoden@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Anirban Ray <Anirban.Ray@sandisk.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1102609160-1380062838=:25142
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Somnath!

On Tue, 24 Sep 2013, Somnath Roy wrote:
>=20
> Hi Sage,
>=20
> We did quite a few experiment to see how ceph read performance can scal=
e up.
> Here is the summary.
>=20
> =A0
>=20
> 1.
>=20
> First we tried to see how far a single node cluster with one osd can sc=
ale
> up. We started with cuttlefish release and the entire osd file system i=
s on
> the ssd. What we saw with 4K size object and with single rados client w=
ith
> dedicated 10G network, throughput can't go beyond a certain point.

Are you using 'rados bench' to generate this load or something else? =20
We've noticed that individual rados bench commands do not scale beyond a=20
point but have never looked into it; the problem may be in the bench code=
=20
and not in librados or SimpleMessenger.

> We dig through the code and found out SimpleMessenger is opening single
> socket connection (per client)to talk to the osd. Also, we saw there is=
 only
> one dispatcher Q (Dispatch thread)/ SimpleMessenger to carry these requ=
ests
> to OSD. We started adding more dispatcher threads in Dispatch Q, rearra=
nge
> several locks in the Pipe.cc to identify the bottleneck. What we end up
> discovering is that there is bottleneck both in upstream as well as in =
the
> downstream at osd level and changing the locking scheme in io path =A0w=
ill
> affect lot of other codes (that we don't even know).
>=20
> So, we stopped that activity and started workaround the upstream bottle=
neck
> by introducing more clients to the single OSD. What we saw single OSD i=
s
> scaling with lot of cpu utilization. To produce ~40K iops (4K) it is ta=
king
> almost 12 core of cpu.

Just to make sure I understand: the single OSD dispatch queue does not=20
become a problem with multiple clients?

Possibilities that come to mind:

- DispatchQueue is doing some funny stuff to keep individual clients'=20
messages ordered but to fairly process requests from multiple clients. =20
There could easily be a problem with the per-client queue portion of this=
.

- Pipe's use of MSG_MORE is making the TCP stream efficient... you might=20
try setting 'ms tcp nodelay =3D false'.

- The message encode is happening in the thread that sends messages over=20
the wire.  Maybe doing it in send_message() instead of writer() will keep=
=20
that on a separate core than the thread that's shoveling data into the=20
socket.

> Another point, I didn't see this single osd scale with the Dumpling rel=
ease
> with the multiple clients !! Something changed..

What is it with dumpling?

> 2. =A0=A0After that, we setup a proper cluster with 3 high performing n=
odes and
> total 30 osds. Here also, we are seeing single rados bech client as wel=
l as
> rbd client instance is not scaling beyond a certain limit. It is not ab=
le to
> generate much load as node cpu utilization remains very low. But runnin=
g
> multiple client instance the performance is scaling till hit the cpu li=
mit.
>=20
> So, it is pretty clear we are not able to saturate anything with single
> client and that's why the 'noshare' option was very helpful to measure =
the
> rbd performance benchmark. I have a single osd/single client level call
> grind =A0data attached here.

Something from perf that shows a call graph would be more helpful to=20
identify where things are waiting.  We haven't done much optimizing at=20
this level at all, so these results aren't entirely surprising.

> Now, I am doing the benchmark for radosgw and I think I am stuck with
> similar bottleneck here. Could you please confirm that if radosgw also
> opening single client instance to the cluster?=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0

It is: each radosgw has a single librados client instance.

> If so, is there any similar option like 'noshare' in this case ? Here a=
lso,
> creating multiple radosgw instance on separate nodes the performance is
> scaling.

No, but

> BTW, is there a way to run multiple radosgw to a single node or it has =
to be
> one/node ?

yes.  You just need to make sure they have different fastcgi sockets they=
=20
listen on and probably set up a separate web server in front of each one.

I think the next step to understanding what is going on is getting the=20
right profiling tools in place so we can see where the client threads are=
=20
spending their (non-idle and idle) time...

sage


>=20
> =A0
>=20
> Thanks & Regards
>=20
> Somnath
>=20
> =A0
>=20
> =A0=A0=A0
>=20
> =A0
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, September 24, 2013 2:16 PM
> To: Travis Rhoden
> Cc: Josh Durgin; ceph-devel@vger.kernel.org; Anirban Ray;
> ceph-users@lists.ceph.com
> Subject: Re: [ceph-users] Scaling RBD module
>=20
> =A0
>=20
> On Tue, 24 Sep 2013, Travis Rhoden wrote:
>=20
> > This "noshare" option may have just helped me a ton -- I sure wish I
>=20
> > would have asked similar questions sooner, because I have seen the
>=20
> > same failure to scale.=A0 =3D)
>=20
> >
>=20
> > One question -- when using the "noshare" option (or really, even
>=20
> > without it) are there any practical limits on the number of RBDs that
>=20
> > can be mounted?=A0 I have servers with ~100 RBDs on them each, and am
>=20
> > wondering if I switch them all over to using "noshare" if anything is
>=20
> > going to blow up, use a ton more memory, etc.=A0 Even without noshare=
,
>=20
> > are there any known limits to how many RBDs can be mapped?
>=20
> =A0
>=20
> With noshare each mapped image will appear as a separate client instanc=
e,
> which means it will have it's own session with teh monitors and own TCP
> connections to the OSDs.=A0 It may be a viable workaround for now but i=
n
> general I would not recommend it.
>=20
> =A0
>=20
> I'm very curious what the scaling issue is with the shared client.=A0 D=
o you
> have a working perf that can capture callgraph information on this mach=
ine?
>=20
> =A0
>=20
> sage
>=20
> =A0
>=20
> >
>=20
> > Thanks!
>=20
> >
>=20
> > =A0- Travis
>=20
> >
>=20
> >
>=20
> > On Thu, Sep 19, 2013 at 8:03 PM, Somnath Roy <Somnath.Roy@sandisk.com=
>
>=20
> > wrote:
>=20
> >=A0=A0=A0=A0=A0=A0 Thanks Josh !
>=20
> >=A0=A0=A0=A0=A0=A0 I am able to successfully add this noshare option i=
n the image
>=20
> >=A0=A0=A0=A0=A0=A0 mapping now. Looking at dmesg output, I found that =
was indeed
>=20
> >=A0=A0=A0=A0=A0=A0 the secret key problem. Block performance is scalin=
g now.
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 Regards
>=20
> >=A0=A0=A0=A0=A0=A0 Somnath
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 -----Original Message-----
>=20
> >=A0=A0=A0=A0=A0=A0 From: ceph-devel-owner@vger.kernel.org
>=20
> >=A0=A0=A0=A0=A0=A0 [mailto:ceph-devel-owner@vger.kernel.org] On Behalf=
 Of Josh
>=20
> >=A0=A0=A0=A0=A0=A0 Durgin
>=20
> >=A0=A0=A0=A0=A0=A0 Sent: Thursday, September 19, 2013 12:24 PM
>=20
> >=A0=A0=A0=A0=A0=A0 To: Somnath Roy
>=20
> >=A0=A0=A0=A0=A0=A0 Cc: Sage Weil; ceph-devel@vger.kernel.org; Anirban =
Ray;
>=20
> >=A0=A0=A0=A0=A0=A0 ceph-users@lists.ceph.com
>=20
> >=A0=A0=A0=A0=A0=A0 Subject: Re: [ceph-users] Scaling RBD module
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 On 09/19/2013 12:04 PM, Somnath Roy wrote:
>=20
> >=A0=A0=A0=A0=A0=A0 > Hi Josh,
>=20
> >=A0=A0=A0=A0=A0=A0 > Thanks for the information. I am trying to add th=
e following
>=20
> >=A0=A0=A0=A0=A0=A0 but hitting some permission issue.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > root@emsclient:/etc# echo
>=20
> >=A0=A0=A0=A0=A0=A0 <mon-1>:6789,<mon-2>:6789,<mon-3>:6789
>=20
> >=A0=A0=A0=A0=A0=A0 > name=3Dadmin,key=3Dclient.admin,noshare test_rbd =
ceph_block_test'
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > /sys/bus/rbd/add
>=20
> >=A0=A0=A0=A0=A0=A0 > -bash: echo: write error: Operation not permitted
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 If you check dmesg, it will probably show an error =
trying to
>=20
> >=A0=A0=A0=A0=A0=A0 authenticate to the cluster.
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 Instead of key=3Dclient.admin, you can pass the bas=
e64 secret
>=20
> >=A0=A0=A0=A0=A0=A0 value as shown in 'ceph auth list' with the
>=20
> >=A0=A0=A0=A0=A0=A0 secret=3DXXXXXXXXXXXXXXXXXXXXX option.
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 BTW, there's a ticket for adding the noshare option=
 to rbd map
>=20
> >=A0=A0=A0=A0=A0=A0 so using the sysfs interface like this is never nec=
essary:
>=20
> >
>=20
> >=A0=A0 =A0=A0=A0=A0http://tracker.ceph.com/issues/6264
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 Josh
>=20
> >
>=20
> >=A0=A0=A0=A0=A0=A0 > Here is the contents of rbd directory..
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > root@emsclient:/sys/bus/rbd# ll
>=20
> >=A0=A0=A0=A0=A0=A0 > total 0
>=20
> >=A0=A0=A0=A0=A0=A0 > drwxr-xr-x =A04 root root =A0 =A00 Sep 19 11:59 .=
/
>=20
> >=A0=A0=A0=A0=A0=A0 > drwxr-xr-x 30 root root =A0 =A00 Sep 13 11:41 ../
>=20
> >=A0=A0=A0=A0=A0=A0 > --w------- =A01 root root 4096 Sep 19 11:59 add
>=20
> >=A0=A0=A0=A0=A0=A0 > drwxr-xr-x =A02 root root =A0 =A00 Sep 19 12:03 d=
evices/
>=20
> >=A0=A0=A0=A0=A0=A0 > drwxr-xr-x =A02 root root =A0 =A00 Sep 19 12:03 d=
rivers/
>=20
> >=A0=A0=A0=A0=A0=A0 > -rw-r--r-- =A01 root root 4096 Sep 19 12:03 drive=
rs_autoprobe
>=20
> >=A0=A0=A0=A0=A0=A0 > --w------- =A01 root root 4096 Sep 19 12:03 drive=
rs_probe
>=20
> >=A0=A0=A0=A0=A0=A0 > --w------- =A01 root root 4096 Sep 19 12:03 remov=
e
>=20
> >=A0=A0=A0=A0=A0=A0 > --w------- =A01 root root 4096 Sep 19 11:59 ueven=
t
>=20
> > =A0=A0=A0=A0=A0=A0>
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > I checked even if I am logged in as root , I can'=
t write
>=20
> >=A0=A0=A0=A0=A0=A0 anything on /sys.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Here is the Ubuntu version I am using..
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > root@emsclient:/etc# lsb_release -a
>=20
> >=A0=A0=A0=A0=A0=A0 > No LSB modules are available.
>=20
> >=A0=A0=A0=A0=A0=A0 > Distributor ID: Ubuntu
>=20
> >=A0=A0=A0=A0=A0=A0 > Description: =A0 =A0Ubuntu 13.04
>=20
> >=A0=A0=A0=A0=A0=A0 > Release: =A0 =A0 =A0 =A013.04
>=20
> >=A0=A0=A0=A0=A0=A0 > Codename: =A0 =A0 =A0 raring
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Here is the mount information....
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > root@emsclient:/etc# mount
>=20
> >=A0=A0=A0=A0=A0 =A0> /dev/mapper/emsclient--vg-root on / type ext4
>=20
> >=A0=A0=A0=A0=A0=A0 (rw,errors=3Dremount-ro)
>=20
> >=A0=A0=A0=A0=A0=A0 > proc on /proc type proc (rw,noexec,nosuid,nodev) =
sysfs on /sys
>=20
> >=A0=A0=A0=A0=A0=A0 type
>=20
> >=A0=A0=A0=A0=A0=A0 > sysfs (rw,noexec,nosuid,nodev) none on /sys/fs/cg=
roup type
>=20
> >=A0=A0=A0=A0=A0=A0 tmpfs (rw)
>=20
> > =A0=A0=A0=A0=A0=A0> none on /sys/fs/fuse/connections type fusectl (rw=
) none on
>=20
> >=A0=A0=A0=A0=A0=A0 > /sys/kernel/debug type debugfs (rw) none on
>=20
> >=A0=A0=A0=A0=A0=A0 /sys/kernel/security type
>=20
> >=A0=A0=A0=A0=A0=A0 > securityfs (rw) udev on /dev type devtmpfs (rw,mo=
de=3D0755)
>=20
> >=A0=A0=A0=A0=A0=A0 devpts on
>=20
> >=A0=A0=A0=A0=A0=A0 > /dev/pts type devpts (rw,noexec,nosuid,gid=3D5,mo=
de=3D0620)
>=20
> >=A0=A0=A0=A0=A0=A0 > tmpfs on /run type tmpfs (rw,noexec,nosuid,size=3D=
10%,mode=3D0755)
>=20
> >=A0=A0=A0=A0=A0=A0 > none on /run/lock type tmpfs
>=20
> >=A0=A0=A0=A0=A0=A0 (rw,noexec,nosuid,nodev,size=3D5242880)
>=20
> >=A0=A0=A0=A0=A0=A0 > none on /run/shm type tmpfs (rw,nosuid,nodev) non=
e on
>=20
> >=A0=A0=A0=A0=A0=A0 /run/user type
>=20
> >=A0=A0=A0=A0=A0=A0 > tmpfs (rw,noexec,nosuid,nodev,size=3D104857600,mo=
de=3D0755)
>=20
> >=A0=A0=A0=A0=A0=A0 > /dev/sda1 on /boot type ext2 (rw)
>=20
> >=A0=A0=A0=A0=A0=A0 > /dev/mapper/emsclient--vg-home on /home type ext4=
 (rw)
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0 =A0=A0> Any idea what went wrong here ?
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Thanks & Regards
>=20
> >=A0=A0=A0=A0=A0=A0 > Somnath
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > -----Original Message-----
>=20
> >=A0=A0=A0=A0=A0=A0 > From: Josh Durgin [mailto:josh.durgin@inktank.com=
]
>=20
> >=A0=A0=A0=A0=A0=A0 > Sent: Wednesday, September 18, 2013 6:10 PM
>=20
> >=A0 =A0=A0=A0=A0=A0> To: Somnath Roy
>=20
> >=A0=A0=A0=A0=A0=A0 > Cc: Sage Weil; ceph-devel@vger.kernel.org; Anirba=
n Ray;
>=20
> >=A0=A0=A0=A0=A0=A0 > ceph-users@lists.ceph.com
>=20
> >=A0=A0=A0=A0=A0=A0 > Subject: Re: [ceph-users] Scaling RBD module
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > On 09/17/2013 03:30 PM, Somnath Roy wrote:
>=20
> >=A0=A0=A0=A0=A0=A0 >> Hi,
>=20
> >=A0=A0=A0=A0=A0=A0 >> I am running Ceph on a 3 node cluster and each o=
f my server
>=20
> >=A0=A0=A0=A0=A0=A0 node is running 10 OSDs, one for each disk. I have =
one admin
>=20
> >=A0=A0=A0=A0=A0=A0 node and all the nodes are connected with 2 X 10G n=
etwork. One
>=20
> >=A0=A0=A0=A0=A0=A0 network is for cluster and other one configured as =
public
>=20
> >=A0=A0=A0=A0=A0=A0 network.
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> Here is the status of my cluster.
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> ~/fio_test# ceph -s
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> =A0 =A0 cluster b2e0b4db-6342-490e-9c28-0aadf018=
8023
>=20
> >=A0=A0 =A0=A0=A0=A0>> =A0 =A0 =A0health HEALTH_WARN clock skew detecte=
d on mon.
>=20
> >=A0=A0=A0=A0=A0=A0 <server-name-2>, mon. <server-name-3>
>=20
> >=A0=A0=A0=A0=A0=A0 >> =A0 =A0 =A0monmap e1: 3 mons at
>=20
> >=A0=A0=A0=A0=A0=A0 {<server-name-1>=3Dxxx.xxx.xxx.xxx:6789/0,
>=20
> >=A0=A0=A0=A0=A0=A0 <server-name-2>=3Dxxx.xxx.xxx.xxx:6789/0,
>=20
> >=A0=A0=A0=A0=A0=A0 <server-name-3>=3Dxxx.xxx.xxx.xxx:6789/0}, election=
 epoch 64,
>=20
> >=A0=A0=A0=A0=A0=A0 quorum 0,1,2 <server-name-1>,<server-name-2>,<serve=
r-name-3>
>=20
> >=A0=A0=A0=A0=A0=A0 >> =A0 =A0 =A0osdmap e391: 30 osds: 30 up, 30 in
>=20
> >=A0=A0=A0=A0=A0=A0 >> =A0 =A0 =A0 pgmap v5202: 30912 pgs: 30912 active=
+clean; 8494 MB
>=20
> >=A0=A0=A0=A0=A0=A0 data, 27912 MB used, 11145 GB / 11172 GB avail
>=20
> >=A0=A0=A0=A0=A0=A0 >> =A0 =A0 =A0mdsmap e1: 0/0/1 up
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> I started with rados bench command to benchmark =
the read
>=20
> >=A0=A0=A0=A0=A0=A0 performance of this Cluster on a large pool (~10K P=
Gs) and found
>=20
> >=A0=A0=A0=A0=A0=A0 that each rados client has a limitation. Each clien=
t can only
>=20
> >=A0=A0=A0=A0=A0=A0 drive up to a certain mark. Each server =A0node cpu=
 utilization
>=20
> >=A0=A0=A0=A0=A0=A0 shows it is =A0around 85-90% idle and the admin nod=
e (from where
>=20
> >=A0=A0=A0=A0=A0=A0 rados client is running) is around ~80-85% idle. I =
am trying
>=20
> >=A0=A0=A0=A0=A0=A0 with 4K object size.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Note that rados bench with 4k objects is differen=
t from rbd
>=20
> >=A0=A0=A0=A0=A0=A0 with 4k-sized I/Os - rados bench sends each request=
 to a new
>=20
> >=A0=A0=A0=A0=A0=A0 object, while rbd objects are 4M by default.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 >> Now, I started running more clients on the admin=
 node and the
>=20
> >=A0=A0=A0=A0=A0=A0 performance is scaling till it hits the client cpu =
limit. Server
>=20
> >=A0=A0=A0=A0=A0=A0 still has the cpu of 30-35% idle. With small object=
 size I must
>=20
> >=A0=A0=A0=A0=A0=A0 say that the ceph per osd cpu utilization is not pr=
omising!
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> After this, I started testing the rados block in=
terface with
>=20
> >=A0=A0=A0=A0=A0=A0 kernel rbd module from my admin node.
>=20
> >=A0=A0=A0=A0=A0=A0 >> I have created 8 images mapped on the pool havin=
g around 10K
>=20
> >=A0=A0=A0=A0=A0=A0 PGs and I am not able to scale up the performance b=
y running fio
>=20
> >=A0=A0=A0=A0=A0=A0 (either by creating a software raid or running on i=
ndividual
>=20
> >=A0=A0=A0=A0=A0=A0 /dev/rbd* instances). For example, running multiple=
 fio
>=20
> >=A0=A0=A0=A0=A0=A0 instances (one in /dev/rbd1 and the other in /dev/r=
bd2) =A0the
>=20
> >=A0=A0=A0=A0=A0=A0 performance I am getting is half of what I am getti=
ng if running
>=20
> >=A0=A0=A0=A0=A0=A0 one instance. Here is my fio job script.
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> [random-reads]
>=20
> >=A0=A0=A0=A0=A0=A0 >> ioengine=3Dlibaio
>=20
> >=A0=A0=A0=A0=A0=A0 >> iodepth=3D32
>=20
> >=A0=A0=A0=A0=A0=A0 >> filename=3D/dev/rbd1
>=20
> >=A0=A0=A0=A0=A0=A0 >> rw=3Drandread
>=20
> >=A0=A0=A0=A0=A0=A0 >> bs=3D4k
>=20
> >=A0=A0=A0=A0=A0=A0 >> direct=3D1
>=20
> >=A0=A0=A0=A0=A0=A0 >> size=3D2G
>=20
> >=A0=A0=A0=A0=A0=A0 >> numjobs=3D64
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> Let me know if I am following the proper procedu=
re or not.
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> But, If my understanding is correct, kernel rbd =
module is
>=20
> >=A0=A0=A0=A0=A0=A0 acting as a client to the cluster and in one admin =
node I can
>=20
> >=A0=A0=A0=A0=A0=A0 run only one of such kernel instance.
>=20
> >=A0=A0=A0=A0=A0=A0 >> If so, I am then limited to the client bottlenec=
k that I
>=20
> >=A0 =A0=A0=A0=A0=A0stated earlier. The cpu utilization of the server s=
ide is around
>=20
> >=A0=A0=A0=A0=A0=A0 85-90% idle, so, it is clear that client is not dri=
ving.
>=20
> >=A0=A0=A0=A0=A0=A0 >>
>=20
> >=A0=A0=A0=A0=A0=A0 >> My question is, is there any way to hit the clus=
ter =A0with
>=20
> >=A0=A0=A0=A0=A0=A0 more client from a single box while testing the rbd=
 module ?
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > You can run multiple librbd instances easily (for=
 example with
>=20
> >=A0=A0=A0=A0=A0=A0 multiple runs of the rbd bench-write command).
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > The kernel rbd driver uses the same rados client =
instance for
>=20
> >=A0=A0=A0=A0=A0=A0 multiple block devices by default. There's an optio=
n (noshare)
>=20
> >=A0=A0=A0=A0=A0=A0 to use a new rados client instance for a newly mapp=
ed device,
>=20
> >=A0=A0=A0=A0=A0=A0 but it's not exposed by the rbd cli. You need to us=
e the sysfs
>=20
> >=A0=A0=A0=A0=A0=A0 interface that 'rbd map' uses instead.
>=20
> >=A0=A0=A0 =A0=A0=A0>
>=20
> >=A0=A0=A0=A0=A0=A0 > Once you've used rbd map once on a machine, the k=
ernel will
>=20
> >=A0=A0=A0=A0=A0=A0 already have the auth key stored, and you can use:
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > echo '1.2.3.4:6789 name=3Dadmin,key=3Dclient.admi=
n,noshare
>=20
> >=A0=A0=A0=A0=A0=A0 poolname
>=20
> >=A0=A0=A0=A0=A0=A0 > imagename' > /sys/bus/rbd/add
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Where 1.2.3.4:6789 is the address of a monitor, a=
nd you're
>=20
> >=A0=A0=A0=A0=A0=A0 connecting as client.admin.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > You can use 'rbd unmap' as usual.
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > Josh
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> > =A0=A0=A0=A0=A0=A0> ________________________________
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >=A0=A0=A0=A0=A0=A0 > PLEASE NOTE: The information contained in this el=
ectronic mail
>=20
> >=A0=A0=A0=A0=A0=A0 message is intended only for the use of the designa=
ted
>=20
> >=A0=A0=A0=A0=A0=A0 recipient(s) named above. If the reader of this mes=
sage is not
>=20
> >=A0=A0=A0=A0=A0=A0 the intended recipient, you are hereby notified tha=
t you have
>=20
> >=A0=A0=A0=A0=A0=A0 received this message in error and that any review,
>=20
> >=A0=A0=A0=A0=A0=A0 dissemination, distribution, or copying of this mes=
sage is
>=20
> >=A0=A0=A0=A0=A0=A0 strictly prohibited. If you have received this comm=
unication in
>=20
> >=A0=A0=A0=A0=A0=A0 error, please notify the sender by telephone or e-m=
ail (as shown
>=20
> >=A0=A0=A0=A0=A0=A0 above) immediately and destroy any and all copies o=
f this
>=20
> >=A0=A0=A0=A0=A0=A0 message in your possession (whether hard copies or
>=20
> >=A0=A0=A0=A0=A0=A0 electronically stored copies).
>=20
> >=A0=A0 =A0=A0=A0=A0>
>=20
> >=A0=A0=A0=A0=A0=A0 >
>=20
> >
>=20
> > --
>=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo
>=20
> > info at =A0http://vger.kernel.org/majordomo-info.html
>=20
> >
>=20
> >
>=20
> > _______________________________________________
>=20
> > ceph-users mailing list
>=20
> > ceph-users@lists.ceph.com
>=20
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
> >
>=20
> >
>=20
> >
>=20
> >
>=20
>=20
> _______________________________________________________________________=
_____
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is
> intended only for the use of the designated recipient(s) named above. I=
f the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any revi=
ew,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please no=
tify
> the sender by telephone or e-mail (as shown above) immediately and dest=
roy
> any and all copies of this message in your possession (whether hard cop=
ies
> or electronically stored copies).
>=20
>=20
>=20
>=20
--557981400-1102609160-1380062838=:25142--
