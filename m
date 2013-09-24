From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Scaling RBD module
Date: Tue, 24 Sep 2013 22:23:41 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F199232F5@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
	<523A4EFB.8040601@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A6AF@SACMBXIP01.sdcorp.global.sandisk.com>
	<523B4F39.9080109@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A738@SACMBXIP01.sdcorp.global.sandisk.com>
	<CACkq2mrfO+eFCYaEdoTQpJ2tOoDyVCkedSMAAztnQVYPBsv7gw@mail.gmail.com>
	<alpine.DEB.2.00.1309241413280.25142@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1910409712=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Travis Rhoden <trhoden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1910409712==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_755F6B91B3BE364F9BCA11EA3F9E0C6F199232F5SACMBXIP01sdcor_"

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F199232F5SACMBXIP01sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage,

We did quite a few experiment to see how ceph read performance can scale up=
. Here is the summary.



1.

First we tried to see how far a single node cluster with one osd can scale =
up. We started with cuttlefish release and the entire osd file system is on=
 the ssd. What we saw with 4K size object and with single rados client with=
 dedicated 10G network, throughput can't go beyond a certain point.

We dig through the code and found out SimpleMessenger is opening single soc=
ket connection (per client)to talk to the osd. Also, we saw there is only o=
ne dispatcher Q (Dispatch thread)/ SimpleMessenger to carry these requests =
to OSD. We started adding more dispatcher threads in Dispatch Q, rearrange =
several locks in the Pipe.cc to identify the bottleneck. What we end up dis=
covering is that there is bottleneck both in upstream as well as in the dow=
nstream at osd level and changing the locking scheme in io path  will affec=
t lot of other codes (that we don't even know).

So, we stopped that activity and started workaround the upstream bottleneck=
 by introducing more clients to the single OSD. What we saw single OSD is s=
caling with lot of cpu utilization. To produce ~40K iops (4K) it is taking =
almost 12 core of cpu.

Another point, I didn't see this single osd scale with the Dumpling release=
 with the multiple clients !! Something changed..



2.   After that, we setup a proper cluster with 3 high performing nodes and=
 total 30 osds. Here also, we are seeing single rados bech client as well a=
s rbd client instance is not scaling beyond a certain limit. It is not able=
 to generate much load as node cpu utilization remains very low. But runnin=
g multiple client instance the performance is scaling till hit the cpu limi=
t.



So, it is pretty clear we are not able to saturate anything with single cli=
ent and that's why the 'noshare' option was very helpful to measure the rbd=
 performance benchmark. I have a single osd/single client level callgrind  =
data. Attachment is not going through the community I guess and that's why =
can't send it to you.



Now, I am doing the benchmark for radosgw and I think I am stuck with simil=
ar bottleneck here. Could you please confirm that if radosgw also opening s=
ingle client instance to the cluster ?

If so, is there any similar option like 'noshare' in this case ? Here also,=
 creating multiple radosgw instance on separate nodes the performance is sc=
aling.

BTW, is there a way to run multiple radosgw to a single node or it has to b=
e one/node ?





Thanks & Regards

Somnath







-----Original Message-----
From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-owner-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org> [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
Sent: Tuesday, September 24, 2013 2:16 PM
To: Travis Rhoden
Cc: Josh Durgin; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-u79uwXL29TbrhsbdSgBK9A@public.gmane.org=
rg>; Anirban Ray; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFLNfb0M+mGrxg@public.gmane.org=
m>
Subject: Re: [ceph-users] Scaling RBD module



On Tue, 24 Sep 2013, Travis Rhoden wrote:

> This "noshare" option may have just helped me a ton -- I sure wish I

> would have asked similar questions sooner, because I have seen the

> same failure to scale.  =3D)

>

> One question -- when using the "noshare" option (or really, even

> without it) are there any practical limits on the number of RBDs that

> can be mounted?  I have servers with ~100 RBDs on them each, and am

> wondering if I switch them all over to using "noshare" if anything is

> going to blow up, use a ton more memory, etc.  Even without noshare,

> are there any known limits to how many RBDs can be mapped?



With noshare each mapped image will appear as a separate client instance, w=
hich means it will have it's own session with teh monitors and own TCP conn=
ections to the OSDs.  It may be a viable workaround for now but in general =
I would not recommend it.



I'm very curious what the scaling issue is with the shared client.  Do you =
have a working perf that can capture callgraph information on this machine?=




sage



>

> Thanks!

>

>  - Travis

>

>

> On Thu, Sep 19, 2013 at 8:03 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org<mai=
lto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>>

> wrote:

>       Thanks Josh !

>       I am able to successfully add this noshare option in the image

>       mapping now. Looking at dmesg output, I found that was indeed

>       the secret key problem. Block performance is scaling now.

>

>       Regards

>       Somnath

>

>       -----Original Message-----

>       From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-owner@vger=
.kernel.org>

>       [mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Josh

>       Durgin

>       Sent: Thursday, September 19, 2013 12:24 PM

>       To: Somnath Roy

>       Cc: Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel-fy+rA21nqHI@public.gmane.org=
rnel.org>; Anirban Ray;

>       ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>

>       Subject: Re: [ceph-users] Scaling RBD module

>

>       On 09/19/2013 12:04 PM, Somnath Roy wrote:

>       > Hi Josh,

>       > Thanks for the information. I am trying to add the following

>       but hitting some permission issue.

>       >

>       > root@emsclient:/etc# echo

>       <mon-1>:6789,<mon-2>:6789,<mon-3>:6789

>       > name=3Dadmin,key=3Dclient.admin,noshare test_rbd ceph_block_test'=


>       >

>       > /sys/bus/rbd/add

>       > -bash: echo: write error: Operation not permitted

>

>       If you check dmesg, it will probably show an error trying to

>       authenticate to the cluster.

>

>       Instead of key=3Dclient.admin, you can pass the base64 secret

>       value as shown in 'ceph auth list' with the

>       secret=3DXXXXXXXXXXXXXXXXXXXXX option.

>

>       BTW, there's a ticket for adding the noshare option to rbd map

>       so using the sysfs interface like this is never necessary:

>

>       http://tracker.ceph.com/issues/6264

>

>       Josh

>

>       > Here is the contents of rbd directory..

>       >

>       > root@emsclient:/sys/bus/rbd# ll

>       > total 0

>       > drwxr-xr-x  4 root root    0 Sep 19 11:59 ./

>       > drwxr-xr-x 30 root root    0 Sep 13 11:41 ../

>       > --w-------  1 root root 4096 Sep 19 11:59 add

>       > drwxr-xr-x  2 root root    0 Sep 19 12:03 devices/

>       > drwxr-xr-x  2 root root    0 Sep 19 12:03 drivers/

>       > -rw-r--r--  1 root root 4096 Sep 19 12:03 drivers_autoprobe

>       > --w-------  1 root root 4096 Sep 19 12:03 drivers_probe

>       > --w-------  1 root root 4096 Sep 19 12:03 remove

>       > --w-------  1 root root 4096 Sep 19 11:59 uevent

>       >

>       >

>       > I checked even if I am logged in as root , I can't write

>       anything on /sys.

>       >

>       > Here is the Ubuntu version I am using..

>       >

>       > root@emsclient:/etc# lsb_release -a

>       > No LSB modules are available.

>       > Distributor ID: Ubuntu

>       > Description:    Ubuntu 13.04

>       > Release:        13.04

>       > Codename:       raring

>       >

>       > Here is the mount information....

>       >

>       > root@emsclient:/etc# mount

>       > /dev/mapper/emsclient--vg-root on / type ext4

>       (rw,errors=3Dremount-ro)

>       > proc on /proc type proc (rw,noexec,nosuid,nodev) sysfs on /sys

>       type

>       > sysfs (rw,noexec,nosuid,nodev) none on /sys/fs/cgroup type

>       tmpfs (rw)

>       > none on /sys/fs/fuse/connections type fusectl (rw) none on

>       > /sys/kernel/debug type debugfs (rw) none on

>       /sys/kernel/security type

>       > securityfs (rw) udev on /dev type devtmpfs (rw,mode=3D0755)

>       devpts on

>       > /dev/pts type devpts (rw,noexec,nosuid,gid=3D5,mode=3D0620)

>       > tmpfs on /run type tmpfs (rw,noexec,nosuid,size=3D10%,mode=3D0755=
)

>       > none on /run/lock type tmpfs

>       (rw,noexec,nosuid,nodev,size=3D5242880)

>       > none on /run/shm type tmpfs (rw,nosuid,nodev) none on

>       /run/user type

>       > tmpfs (rw,noexec,nosuid,nodev,size=3D104857600,mode=3D0755)

>       > /dev/sda1 on /boot type ext2 (rw)

>       > /dev/mapper/emsclient--vg-home on /home type ext4 (rw)

>       >

>       >

>       > Any idea what went wrong here ?

>       >

>       > Thanks & Regards

>       > Somnath

>       >

>       > -----Original Message-----

>       > From: Josh Durgin [mailto:josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]

>       > Sent: Wednesday, September 18, 2013 6:10 PM

>       > To: Somnath Roy

>       > Cc: Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:ceph-devel@vger.=
kernel.org>; Anirban Ray;

>       > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>

>       > Subject: Re: [ceph-users] Scaling RBD module

>       >

>       > On 09/17/2013 03:30 PM, Somnath Roy wrote:

>       >> Hi,

>       >> I am running Ceph on a 3 node cluster and each of my server

>       node is running 10 OSDs, one for each disk. I have one admin

>       node and all the nodes are connected with 2 X 10G network. One

>       network is for cluster and other one configured as public

>       network.

>       >>

>       >> Here is the status of my cluster.

>       >>

>       >> ~/fio_test# ceph -s

>       >>

>       >>     cluster b2e0b4db-6342-490e-9c28-0aadf0188023

>       >>      health HEALTH_WARN clock skew detected on mon.

>       <server-name-2>, mon. <server-name-3>

>       >>      monmap e1: 3 mons at

>       {<server-name-1>=3Dxxx.xxx.xxx.xxx:6789/0,

>       <server-name-2>=3Dxxx.xxx.xxx.xxx:6789/0,

>       <server-name-3>=3Dxxx.xxx.xxx.xxx:6789/0}, election epoch 64,

>       quorum 0,1,2 <server-name-1>,<server-name-2>,<server-name-3>

>       >>      osdmap e391: 30 osds: 30 up, 30 in

>       >>       pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB

>       data, 27912 MB used, 11145 GB / 11172 GB avail

>       >>      mdsmap e1: 0/0/1 up

>       >>

>       >>

>       >> I started with rados bench command to benchmark the read

>       performance of this Cluster on a large pool (~10K PGs) and found

>       that each rados client has a limitation. Each client can only

>       drive up to a certain mark. Each server  node cpu utilization

>       shows it is  around 85-90% idle and the admin node (from where

>       rados client is running) is around ~80-85% idle. I am trying

>       with 4K object size.

>       >

>       > Note that rados bench with 4k objects is different from rbd

>       with 4k-sized I/Os - rados bench sends each request to a new

>       object, while rbd objects are 4M by default.

>       >

>       >> Now, I started running more clients on the admin node and the

>       performance is scaling till it hits the client cpu limit. Server

>       still has the cpu of 30-35% idle. With small object size I must

>       say that the ceph per osd cpu utilization is not promising!

>       >>

>       >> After this, I started testing the rados block interface with

>       kernel rbd module from my admin node.

>       >> I have created 8 images mapped on the pool having around 10K

>       PGs and I am not able to scale up the performance by running fio

>       (either by creating a software raid or running on individual

>       /dev/rbd* instances). For example, running multiple fio

>       instances (one in /dev/rbd1 and the other in /dev/rbd2)  the

>       performance I am getting is half of what I am getting if running

>       one instance. Here is my fio job script.

>       >>

>       >> [random-reads]

>       >> ioengine=3Dlibaio

>       >> iodepth=3D32

>       >> filename=3D/dev/rbd1

>       >> rw=3Drandread

>       >> bs=3D4k

>       >> direct=3D1

>       >> size=3D2G

>       >> numjobs=3D64

>       >>

>       >> Let me know if I am following the proper procedure or not.

>       >>

>       >> But, If my understanding is correct, kernel rbd module is

>       acting as a client to the cluster and in one admin node I can

>       run only one of such kernel instance.

>       >> If so, I am then limited to the client bottleneck that I

>       stated earlier. The cpu utilization of the server side is around

>       85-90% idle, so, it is clear that client is not driving.

>       >>

>       >> My question is, is there any way to hit the cluster  with

>       more client from a single box while testing the rbd module ?

>       >

>       > You can run multiple librbd instances easily (for example with

>       multiple runs of the rbd bench-write command).

>       >

>       > The kernel rbd driver uses the same rados client instance for

>       multiple block devices by default. There's an option (noshare)

>       to use a new rados client instance for a newly mapped device,

>       but it's not exposed by the rbd cli. You need to use the sysfs

>       interface that 'rbd map' uses instead.

>       >

>       > Once you've used rbd map once on a machine, the kernel will

>       already have the auth key stored, and you can use:

>       >

>       > echo '1.2.3.4:6789 name=3Dadmin,key=3Dclient.admin,noshare

>       poolname

>       > imagename' > /sys/bus/rbd/add

>       >

>       > Where 1.2.3.4:6789 is the address of a monitor, and you're

>       connecting as client.admin.

>       >

>       > You can use 'rbd unmap' as usual.

>       >

>       > Josh

>       >

>       >

>       > ________________________________

>       >

>       > PLEASE NOTE: The information contained in this electronic mail

>       message is intended only for the use of the designated

>       recipient(s) named above. If the reader of this message is not

>       the intended recipient, you are hereby notified that you have

>       received this message in error and that any review,

>       dissemination, distribution, or copying of this message is

>       strictly prohibited. If you have received this communication in

>       error, please notify the sender by telephone or e-mail (as shown

>       above) immediately and destroy any and all copies of this

>       message in your possession (whether hard copies or

>       electronically stored copies).

>       >

>       >

>

> --

> To unsubscribe from this list: send the line "unsubscribe ceph-devel"

> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<mailto:majordomo@vg=
er.kernel.org> More majordomo

> info at  http://vger.kernel.org/majordomo-info.html

>

>

> _______________________________________________

> ceph-users mailing list

> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>

> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

>

>

>

>

________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F199232F5SACMBXIP01sdcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:SimSun}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Tahoma}
@font-face
	{}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif"}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif"}
span.PlainTextChar
	{font-family:"Calibri","sans-serif"}
span.BalloonTextChar
	{font-family:"Tahoma","sans-serif"}
span.EmailStyle21
	{font-family:"Calibri","sans-serif";
	color:#1F497D}
.MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi Sage,</p>
<p class=3D"MsoPlainText">We did quite a few experiment to see how ceph rea=
d performance can scale up. Here is the summary.</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">1.</p>
<p class=3D"MsoPlainText">First we tried to see how far a single node clust=
er with one osd can scale up. We started with cuttlefish release and the en=
tire osd file system is on the ssd. What we saw with 4K size object and wit=
h single rados client with dedicated
 10G network, throughput can't go beyond a certain point.</p>
<p class=3D"MsoPlainText">We dig through the code and found out SimpleMesse=
nger is opening single socket connection (per client)to talk to the osd. Al=
so, we saw there is only one dispatcher Q (Dispatch thread)/ SimpleMessenge=
r to carry these requests to OSD.
 We started adding more dispatcher threads in Dispatch Q, rearrange several=
 locks in the Pipe.cc to identify the bottleneck. What we end up discoverin=
g is that there is bottleneck both in upstream as well as in the downstream=
 at osd level and changing the locking
 scheme in io path &nbsp;will affect lot of other codes (that we don't even=
 know).</p>
<p class=3D"MsoPlainText">So, we stopped that activity and started workarou=
nd the upstream bottleneck by introducing more clients to the single OSD. W=
hat we saw single OSD is scaling with lot of cpu utilization. To produce ~4=
0K iops (4K) it is taking almost 12
 core of cpu.</p>
<p class=3D"MsoPlainText">Another point, I didn't see this single osd scale=
 with the Dumpling release with the multiple clients !! Something changed..=
</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">2. &nbsp;&nbsp;After that, we setup a proper clus=
ter with 3 high performing nodes and total 30 osds. Here also, we are seein=
g single rados bech client as well as rbd client instance is not scaling be=
yond a certain limit. It is not able to generate
 much load as node cpu utilization remains very low. But running multiple c=
lient instance the performance is scaling till hit the cpu limit.</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">So, it is pretty clear we are not able to saturat=
e anything with single client and that's why the 'noshare' option was very =
helpful to measure the rbd performance benchmark. I have a single osd/singl=
e client level callgrind &nbsp;data<span style=3D"color:#1F497D">.
 Attachment is not going through the community I guess and that&#8217;s why=
 can&#8217;t send it to you.</span>
</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">Now, I am doing the benchmark for radosgw and I t=
hink I am stuck with similar bottleneck here. Could you please confirm that=
 if radosgw also opening single client instance to the cluster ?&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;
</p>
<p class=3D"MsoPlainText">If so, is there any similar option like 'noshare'=
 in this case ? Here also, creating multiple radosgw instance on separate n=
odes the performance is scaling.</p>
<p class=3D"MsoPlainText">BTW, is there a way to run multiple radosgw to a =
single node or it has to be one/node ?</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">Thanks &amp; Regards</p>
<p class=3D"MsoPlainText">Somnath</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp; </p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: <a href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-owner@=
vger.kernel.org</a> [<a href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ma=
ilto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>] On Behalf Of Sage Weil<br>
Sent: Tuesday, September 24, 2013 2:16 PM<br>
To: Travis Rhoden<br>
Cc: Josh Durgin; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@v=
ger.kernel.org</a>; Anirban Ray;
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
Subject: Re: [ceph-users] Scaling RBD module</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">On Tue, 24 Sep 2013, Travis Rhoden wrote:</p>
<p class=3D"MsoPlainText">&gt; This &quot;noshare&quot; option may have jus=
t helped me a ton -- I sure wish I
</p>
<p class=3D"MsoPlainText">&gt; would have asked similar questions sooner, b=
ecause I have seen the
</p>
<p class=3D"MsoPlainText">&gt; same failure to scale.&nbsp; =3D)</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; One question -- when using the &quot;noshare=
&quot; option (or really, even
</p>
<p class=3D"MsoPlainText">&gt; without it) are there any practical limits o=
n the number of RBDs that
</p>
<p class=3D"MsoPlainText">&gt; can be mounted?&nbsp; I have servers with ~1=
00 RBDs on them each, and am
</p>
<p class=3D"MsoPlainText">&gt; wondering if I switch them all over to using=
 &quot;noshare&quot; if anything is
</p>
<p class=3D"MsoPlainText">&gt; going to blow up, use a ton more memory, etc=
.&nbsp; Even without noshare,
</p>
<p class=3D"MsoPlainText">&gt; are there any known limits to how many RBDs =
can be mapped?</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">With noshare each mapped image will appear as a s=
eparate client instance, which means it will have it's own session with teh=
 monitors and own TCP connections to the OSDs.&nbsp; It may be a viable wor=
karound for now but in general I would
 not recommend it.</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">I'm very curious what the scaling issue is with t=
he shared client.&nbsp; Do you have a working perf that can capture callgra=
ph information on this machine?</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">sage</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; Thanks!</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; &nbsp;- Travis</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; On Thu, Sep 19, 2013 at 8:03 PM, Somnath Roy=
 &lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org"><span style=3D"color:window=
text; text-decoration:none">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</span></a>&gt;</p>
<p class=3D"MsoPlainText">&gt; wrote:</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks J=
osh !</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am abl=
e to successfully add this noshare option in the image</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping =
now. Looking at dmesg output, I found that was indeed</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the secr=
et key problem. Block performance is scaling now.</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards<=
/p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Somnath<=
/p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----Ori=
ginal Message-----</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From: <a=
 href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">
<span style=3D"color:windowtext; text-decoration:none">ceph-devel-owner@vge=
r.kernel.org</span></a></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [<a href=
=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"><span style=3D"color:windowtex=
t; text-decoration:none">mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</span></a>=
] On Behalf Of Josh</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Durgin</=
p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent: Th=
ursday, September 19, 2013 12:24 PM</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: Somn=
ath Roy</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cc: Sage=
 Weil; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">
<span style=3D"color:windowtext; text-decoration:none">ceph-devel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org</span></a>; Anirban Ray;</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=
=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org"><span style=3D"color:windowtext; text=
-decoration:none">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</span></a></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subject:=
 Re: [ceph-users] Scaling RBD module</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 09/19=
/2013 12:04 PM, Somnath Roy wrote:</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Hi =
Josh,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Tha=
nks for the information. I am trying to add the following</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but hitt=
ing some permission issue.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; roo=
t@emsclient:/etc# echo</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;mon-=
1&gt;:6789,&lt;mon-2&gt;:6789,&lt;mon-3&gt;:6789</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; nam=
e=3Dadmin,key=3Dclient.admin,noshare test_rbd ceph_block_test'</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; /sy=
s/bus/rbd/add</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; -ba=
sh: echo: write error: Operation not permitted</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If you c=
heck dmesg, it will probably show an error trying to</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; authenti=
cate to the cluster.</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instead =
of key=3Dclient.admin, you can pass the base64 secret</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value as=
 shown in 'ceph auth list' with the</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; secret=
=3DXXXXXXXXXXXXXXXXXXXXX option.</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BTW, the=
re's a ticket for adding the noshare option to rbd map</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so using=
 the sysfs interface like this is never necessary:</p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<a href=
=3D"http://tracker.ceph.com/issues/6264"><span style=3D"color:windowtext; t=
ext-decoration:none">http://tracker.ceph.com/issues/6264</span></a></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Josh</p>=

<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Her=
e is the contents of rbd directory..</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; roo=
t@emsclient:/sys/bus/rbd# ll</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; tot=
al 0</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; drw=
xr-xr-x &nbsp;4 root root &nbsp; &nbsp;0 Sep 19 11:59 ./</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; drw=
xr-xr-x 30 root root &nbsp; &nbsp;0 Sep 13 11:41 ../</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --w=
------- &nbsp;1 root root 4096 Sep 19 11:59 add</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; drw=
xr-xr-x &nbsp;2 root root &nbsp; &nbsp;0 Sep 19 12:03 devices/</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; drw=
xr-xr-x &nbsp;2 root root &nbsp; &nbsp;0 Sep 19 12:03 drivers/</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; -rw=
-r--r-- &nbsp;1 root root 4096 Sep 19 12:03 drivers_autoprobe</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --w=
------- &nbsp;1 root root 4096 Sep 19 12:03 drivers_probe</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --w=
------- &nbsp;1 root root 4096 Sep 19 12:03 remove</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --w=
------- &nbsp;1 root root 4096 Sep 19 11:59 uevent</p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I c=
hecked even if I am logged in as root , I can't write</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; anything=
 on /sys.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Her=
e is the Ubuntu version I am using..</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; roo=
t@emsclient:/etc# lsb_release -a</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; No =
LSB modules are available.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Dis=
tributor ID: Ubuntu</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Des=
cription: &nbsp; &nbsp;Ubuntu 13.04</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Rel=
ease: &nbsp; &nbsp; &nbsp; &nbsp;13.04</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Cod=
ename: &nbsp; &nbsp; &nbsp; raring</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Her=
e is the mount information....</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; roo=
t@emsclient:/etc# mount</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&gt; /de=
v/mapper/emsclient--vg-root on / type ext4</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rw,erro=
rs=3Dremount-ro)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; pro=
c on /proc type proc (rw,noexec,nosuid,nodev) sysfs on /sys</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; sys=
fs (rw,noexec,nosuid,nodev) none on /sys/fs/cgroup type</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmpfs (r=
w)</p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; non=
e on /sys/fs/fuse/connections type fusectl (rw) none on</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; /sy=
s/kernel/debug type debugfs (rw) none on</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sys/ker=
nel/security type</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; sec=
urityfs (rw) udev on /dev type devtmpfs (rw,mode=3D0755)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devpts o=
n</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; /de=
v/pts type devpts (rw,noexec,nosuid,gid=3D5,mode=3D0620)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; tmp=
fs on /run type tmpfs (rw,noexec,nosuid,size=3D10%,mode=3D0755)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; non=
e on /run/lock type tmpfs</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rw,noex=
ec,nosuid,nodev,size=3D5242880)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; non=
e on /run/shm type tmpfs (rw,nosuid,nodev) none on</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /run/use=
r type</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; tmp=
fs (rw,noexec,nosuid,nodev,size=3D104857600,mode=3D0755)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; /de=
v/sda1 on /boot type ext2 (rw)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; /de=
v/mapper/emsclient--vg-home on /home type ext4 (rw)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&gt; Any=
 idea what went wrong here ?</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Tha=
nks &amp; Regards</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Som=
nath</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ---=
--Original Message-----</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Fro=
m: Josh Durgin [<a href=3D"mailto:josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org"><span style=3D"c=
olor:windowtext; text-decoration:none">mailto:josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</span=
></a>]</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Sen=
t: Wednesday, September 18, 2013 6:10 PM</p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; To:=
 Somnath Roy</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Cc:=
 Sage Weil; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">
<span style=3D"color:windowtext; text-decoration:none">ceph-devel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org</span></a>; Anirban Ray;</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; <a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org"><span style=3D"color:windowtext; =
text-decoration:none">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</span></a></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Sub=
ject: Re: [ceph-users] Scaling RBD module</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; On =
09/17/2013 03:30 PM, Somnath Roy wrote:</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 Hi,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 I am running Ceph on a 3 node cluster and each of my server</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node is =
running 10 OSDs, one for each disk. I have one admin</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node and=
 all the nodes are connected with 2 X 10G network. One</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; network =
is for cluster and other one configured as public</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; network.=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 Here is the status of my cluster.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 ~/fio_test# ceph -s</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 &nbsp; &nbsp; cluster b2e0b4db-6342-490e-9c28-0aadf0188023</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&gt;&gt;=
 &nbsp; &nbsp; &nbsp;health HEALTH_WARN clock skew detected on mon.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;serv=
er-name-2&gt;, mon. &lt;server-name-3&gt;</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 &nbsp; &nbsp; &nbsp;monmap e1: 3 mons at</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&lt;ser=
ver-name-1&gt;=3Dxxx.xxx.xxx.xxx:6789/0,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;serv=
er-name-2&gt;=3Dxxx.xxx.xxx.xxx:6789/0,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;serv=
er-name-3&gt;=3Dxxx.xxx.xxx.xxx:6789/0}, election epoch 64,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; quorum 0=
,1,2 &lt;server-name-1&gt;,&lt;server-name-2&gt;,&lt;server-name-3&gt;</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 &nbsp; &nbsp; &nbsp;osdmap e391: 30 osds: 30 up, 30 in</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 &nbsp; &nbsp; &nbsp; pgmap v5202: 30912 pgs: 30912 active&#43;clean; 8494 =
MB</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data, 27=
912 MB used, 11145 GB / 11172 GB avail</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 &nbsp; &nbsp; &nbsp;mdsmap e1: 0/0/1 up</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 I started with rados bench command to benchmark the read</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performa=
nce of this Cluster on a large pool (~10K PGs) and found</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; that eac=
h rados client has a limitation. Each client can only</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drive up=
 to a certain mark. Each server &nbsp;node cpu utilization</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shows it=
 is &nbsp;around 85-90% idle and the admin node (from where</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rados cl=
ient is running) is around ~80-85% idle. I am trying</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with 4K =
object size.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Not=
e that rados bench with 4k objects is different from rbd</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with 4k-=
sized I/Os - rados bench sends each request to a new</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object, =
while rbd objects are 4M by default.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 Now, I started running more clients on the admin node and the</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performa=
nce is scaling till it hits the client cpu limit. Server</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; still ha=
s the cpu of 30-35% idle. With small object size I must</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; say that=
 the ceph per osd cpu utilization is not promising!</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 After this, I started testing the rados block interface with</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel r=
bd module from my admin node.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 I have created 8 images mapped on the pool having around 10K</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PGs and =
I am not able to scale up the performance by running fio</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (either =
by creating a software raid or running on individual</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/rbd=
* instances). For example, running multiple fio</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance=
s (one in /dev/rbd1 and the other in /dev/rbd2) &nbsp;the</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; performa=
nce I am getting is half of what I am getting if running</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; one inst=
ance. Here is my fio job script.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 [random-reads]</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 ioengine=3Dlibaio</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 iodepth=3D32</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 filename=3D/dev/rbd1</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 rw=3Drandread</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 bs=3D4k</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 direct=3D1</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 size=3D2G</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 numjobs=3D64</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 Let me know if I am following the proper procedure or not.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 But, If my understanding is correct, kernel rbd module is</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acting a=
s a client to the cluster and in one admin node I can</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; run only=
 one of such kernel instance.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 If so, I am then limited to the client bottleneck that I</p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stated e=
arlier. The cpu utilization of the server side is around</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85-90% i=
dle, so, it is clear that client is not driving.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;=
 My question is, is there any way to hit the cluster &nbsp;with</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; more cli=
ent from a single box while testing the rbd module ?</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; You=
 can run multiple librbd instances easily (for example with</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multiple=
 runs of the rbd bench-write command).</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; The=
 kernel rbd driver uses the same rados client instance for</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multiple=
 block devices by default. There's an option (noshare)</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to use a=
 new rados client instance for a newly mapped device,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but it's=
 not exposed by the rbd cli. You need to use the sysfs</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interfac=
e that 'rbd map' uses instead.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Onc=
e you've used rbd map once on a machine, the kernel will</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; already =
have the auth key stored, and you can use:</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ech=
o '1.2.3.4:6789 name=3Dadmin,key=3Dclient.admin,noshare</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; poolname=
</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ima=
gename' &gt; /sys/bus/rbd/add</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Whe=
re 1.2.3.4:6789 is the address of a monitor, and you're</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connecti=
ng as client.admin.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; You=
 can use 'rbd unmap' as usual.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Jos=
h</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; ___=
_____________________________</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; PLE=
ASE NOTE: The information contained in this electronic mail</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =
is intended only for the use of the designated</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recipien=
t(s) named above. If the reader of this message is not</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the inte=
nded recipient, you are hereby notified that you have</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; received=
 this message in error and that any review,</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dissemin=
ation, distribution, or copying of this message is</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strictly=
 prohibited. If you have received this communication in</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error, p=
lease notify the sender by telephone or e-mail (as shown</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; above) i=
mmediately and destroy any and all copies of this</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =
in your possession (whether hard copies or</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; electron=
ically stored copies).</p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&gt;</p>=

<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;</p>=

<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; --</p>
<p class=3D"MsoPlainText">&gt; To unsubscribe from this list: send the line=
 &quot;unsubscribe ceph-devel&quot;</p>
<p class=3D"MsoPlainText">&gt; in the body of a message to <a href=3D"mailt=
o:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">
<span style=3D"color:windowtext; text-decoration:none">majordomo-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org</span></a> More majordomo
</p>
<p class=3D"MsoPlainText">&gt; info at &nbsp;<a href=3D"http://vger.kernel.=
org/majordomo-info.html"><span style=3D"color:windowtext; text-decoration:n=
one">http://vger.kernel.org/majordomo-info.html</span></a></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; ____________________________________________=
___</p>
<p class=3D"MsoPlainText">&gt; ceph-users mailing list</p>
<p class=3D"MsoPlainText">&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org"=
><span style=3D"color:windowtext; text-decoration:none">ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com</span></a></p>
<p class=3D"MsoPlainText">&gt; <a href=3D"http://lists.ceph.com/listinfo.cg=
i/ceph-users-ceph.com">
<span style=3D"color:windowtext; text-decoration:none">http://lists.ceph.co=
m/listinfo.cgi/ceph-users-ceph.com</span></a></p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; </p>
<p class=3D"MsoPlainText">&gt; </p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"2"><br>
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this
 message in error and that any review, dissemination, distribution, or copy=
ing of this message is strictly prohibited. If you have received this commu=
nication in error, please notify the sender by telephone or e-mail (as show=
n above) immediately and destroy
 any and all copies of this message in your possession (whether hard copies=
 or electronically stored copies).<br>
<br>
</font>
<br clear=3Dall> =

</body>
</html>


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F199232F5SACMBXIP01sdcor_--

--===============1910409712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1910409712==--
