From: Travis Rhoden <trhoden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Scaling RBD module
Date: Tue, 24 Sep 2013 17:09:33 -0400
Message-ID: <CACkq2mrfO+eFCYaEdoTQpJ2tOoDyVCkedSMAAztnQVYPBsv7gw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
	<523A4EFB.8040601@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A6AF@SACMBXIP01.sdcorp.global.sandisk.com>
	<523B4F39.9080109@inktank.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A738@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1792789244=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A738-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Josh Durgin <josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1792789244==
Content-Type: multipart/alternative; boundary=001a11335194d964b404e7278e8c

--001a11335194d964b404e7278e8c
Content-Type: text/plain; charset=ISO-8859-1

This "noshare" option may have just helped me a ton -- I sure wish I would
have asked similar questions sooner, because I have seen the same failure
to scale.  =)

One question -- when using the "noshare" option (or really, even without
it) are there any practical limits on the number of RBDs that can be
mounted?  I have servers with ~100 RBDs on them each, and am wondering if I
switch them all over to using "noshare" if anything is going to blow up,
use a ton more memory, etc.  Even without noshare, are there any known
limits to how many RBDs can be mapped?

Thanks!

 - Travis


On Thu, Sep 19, 2013 at 8:03 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>wrote:

> Thanks Josh !
> I am able to successfully add this noshare option in the image mapping
> now. Looking at dmesg output, I found that was indeed the secret key
> problem. Block performance is scaling now.
>
> Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:
> ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Josh Durgin
> Sent: Thursday, September 19, 2013 12:24 PM
> To: Somnath Roy
> Cc: Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirban Ray;
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Re: [ceph-users] Scaling RBD module
>
> On 09/19/2013 12:04 PM, Somnath Roy wrote:
> > Hi Josh,
> > Thanks for the information. I am trying to add the following but hitting
> some permission issue.
> >
> > root@emsclient:/etc# echo <mon-1>:6789,<mon-2>:6789,<mon-3>:6789
> > name=admin,key=client.admin,noshare test_rbd ceph_block_test' >
> > /sys/bus/rbd/add
> > -bash: echo: write error: Operation not permitted
>
> If you check dmesg, it will probably show an error trying to authenticate
> to the cluster.
>
> Instead of key=client.admin, you can pass the base64 secret value as shown
> in 'ceph auth list' with the secret=XXXXXXXXXXXXXXXXXXXXX option.
>
> BTW, there's a ticket for adding the noshare option to rbd map so using
> the sysfs interface like this is never necessary:
>
> http://tracker.ceph.com/issues/6264
>
> Josh
>
> > Here is the contents of rbd directory..
> >
> > root@emsclient:/sys/bus/rbd# ll
> > total 0
> > drwxr-xr-x  4 root root    0 Sep 19 11:59 ./
> > drwxr-xr-x 30 root root    0 Sep 13 11:41 ../
> > --w-------  1 root root 4096 Sep 19 11:59 add
> > drwxr-xr-x  2 root root    0 Sep 19 12:03 devices/
> > drwxr-xr-x  2 root root    0 Sep 19 12:03 drivers/
> > -rw-r--r--  1 root root 4096 Sep 19 12:03 drivers_autoprobe
> > --w-------  1 root root 4096 Sep 19 12:03 drivers_probe
> > --w-------  1 root root 4096 Sep 19 12:03 remove
> > --w-------  1 root root 4096 Sep 19 11:59 uevent
> >
> >
> > I checked even if I am logged in as root , I can't write anything on
> /sys.
> >
> > Here is the Ubuntu version I am using..
> >
> > root@emsclient:/etc# lsb_release -a
> > No LSB modules are available.
> > Distributor ID: Ubuntu
> > Description:    Ubuntu 13.04
> > Release:        13.04
> > Codename:       raring
> >
> > Here is the mount information....
> >
> > root@emsclient:/etc# mount
> > /dev/mapper/emsclient--vg-root on / type ext4 (rw,errors=remount-ro)
> > proc on /proc type proc (rw,noexec,nosuid,nodev) sysfs on /sys type
> > sysfs (rw,noexec,nosuid,nodev) none on /sys/fs/cgroup type tmpfs (rw)
> > none on /sys/fs/fuse/connections type fusectl (rw) none on
> > /sys/kernel/debug type debugfs (rw) none on /sys/kernel/security type
> > securityfs (rw) udev on /dev type devtmpfs (rw,mode=0755) devpts on
> > /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
> > tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
> > none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
> > none on /run/shm type tmpfs (rw,nosuid,nodev) none on /run/user type
> > tmpfs (rw,noexec,nosuid,nodev,size=104857600,mode=0755)
> > /dev/sda1 on /boot type ext2 (rw)
> > /dev/mapper/emsclient--vg-home on /home type ext4 (rw)
> >
> >
> > Any idea what went wrong here ?
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Josh Durgin [mailto:josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org]
> > Sent: Wednesday, September 18, 2013 6:10 PM
> > To: Somnath Roy
> > Cc: Sage Weil; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Anirban Ray;
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > Subject: Re: [ceph-users] Scaling RBD module
> >
> > On 09/17/2013 03:30 PM, Somnath Roy wrote:
> >> Hi,
> >> I am running Ceph on a 3 node cluster and each of my server node is
> running 10 OSDs, one for each disk. I have one admin node and all the nodes
> are connected with 2 X 10G network. One network is for cluster and other
> one configured as public network.
> >>
> >> Here is the status of my cluster.
> >>
> >> ~/fio_test# ceph -s
> >>
> >>     cluster b2e0b4db-6342-490e-9c28-0aadf0188023
> >>      health HEALTH_WARN clock skew detected on mon. <server-name-2>,
> mon. <server-name-3>
> >>      monmap e1: 3 mons at {<server-name-1>=xxx.xxx.xxx.xxx:6789/0,
> <server-name-2>=xxx.xxx.xxx.xxx:6789/0,
> <server-name-3>=xxx.xxx.xxx.xxx:6789/0}, election epoch 64, quorum 0,1,2
> <server-name-1>,<server-name-2>,<server-name-3>
> >>      osdmap e391: 30 osds: 30 up, 30 in
> >>       pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB data, 27912
> MB used, 11145 GB / 11172 GB avail
> >>      mdsmap e1: 0/0/1 up
> >>
> >>
> >> I started with rados bench command to benchmark the read performance of
> this Cluster on a large pool (~10K PGs) and found that each rados client
> has a limitation. Each client can only drive up to a certain mark. Each
> server  node cpu utilization shows it is  around 85-90% idle and the admin
> node (from where rados client is running) is around ~80-85% idle. I am
> trying with 4K object size.
> >
> > Note that rados bench with 4k objects is different from rbd with
> 4k-sized I/Os - rados bench sends each request to a new object, while rbd
> objects are 4M by default.
> >
> >> Now, I started running more clients on the admin node and the
> performance is scaling till it hits the client cpu limit. Server still has
> the cpu of 30-35% idle. With small object size I must say that the ceph per
> osd cpu utilization is not promising!
> >>
> >> After this, I started testing the rados block interface with kernel rbd
> module from my admin node.
> >> I have created 8 images mapped on the pool having around 10K PGs and I
> am not able to scale up the performance by running fio (either by creating
> a software raid or running on individual /dev/rbd* instances). For example,
> running multiple fio instances (one in /dev/rbd1 and the other in
> /dev/rbd2)  the performance I am getting is half of what I am getting if
> running one instance. Here is my fio job script.
> >>
> >> [random-reads]
> >> ioengine=libaio
> >> iodepth=32
> >> filename=/dev/rbd1
> >> rw=randread
> >> bs=4k
> >> direct=1
> >> size=2G
> >> numjobs=64
> >>
> >> Let me know if I am following the proper procedure or not.
> >>
> >> But, If my understanding is correct, kernel rbd module is acting as a
> client to the cluster and in one admin node I can run only one of such
> kernel instance.
> >> If so, I am then limited to the client bottleneck that I stated
> earlier. The cpu utilization of the server side is around 85-90% idle, so,
> it is clear that client is not driving.
> >>
> >> My question is, is there any way to hit the cluster  with more client
> from a single box while testing the rbd module ?
> >
> > You can run multiple librbd instances easily (for example with multiple
> runs of the rbd bench-write command).
> >
> > The kernel rbd driver uses the same rados client instance for multiple
> block devices by default. There's an option (noshare) to use a new rados
> client instance for a newly mapped device, but it's not exposed by the rbd
> cli. You need to use the sysfs interface that 'rbd map' uses instead.
> >
> > Once you've used rbd map once on a machine, the kernel will already have
> the auth key stored, and you can use:
> >
> > echo '1.2.3.4:6789 name=admin,key=client.admin,noshare poolname
> > imagename' > /sys/bus/rbd/add
> >
> > Where 1.2.3.4:6789 is the address of a monitor, and you're connecting
> as client.admin.
> >
> > You can use 'rbd unmap' as usual.
> >
> > Josh
> >
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message
> is intended only for the use of the designated recipient(s) named above. If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies
> or electronically stored copies).
> >
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
>  http://vger.kernel.org/majordomo-info.html
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11335194d964b404e7278e8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This &quot;noshare&quot; option may have just helped =
me a ton -- I sure wish I would have asked similar questions sooner, becaus=
e I have seen the same failure to scale.=A0 =3D)<br><br>One question -- whe=
n using the &quot;noshare&quot; option (or really, even without it) are the=
re any practical limits on the number of RBDs that can be mounted?=A0 I hav=
e servers with ~100 RBDs on them each, and am wondering if I switch them al=
l over to using &quot;noshare&quot; if anything is going to blow up, use a =
ton more memory, etc.=A0 Even without noshare, are there any known limits t=
o how many RBDs can be mapped?<br>

<br>Thanks!<br><br></div>=A0- Travis<br></div><div class=3D"gmail_extra"><b=
r><br><div class=3D"gmail_quote">On Thu, Sep 19, 2013 at 8:03 PM, Somnath R=
oy <span dir=3D"ltr">&lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" target=
=3D"_blank">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Thanks Josh !<br>
I am able to successfully add this noshare option in the image mapping now.=
 Looking at dmesg output, I found that was indeed the secret key problem. B=
lock performance is scaling now.<br>
<br>
Regards<br>
Somnath<br>
<div><div class=3D"h5"><br>
-----Original Message-----<br>
From: <a href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-owner@=
vger.kernel.org</a> [mailto:<a href=3D"mailto:ceph-devel-owner-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org">ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>] On Behalf Of Josh Durgin<br>
Sent: Thursday, September 19, 2013 12:24 PM<br>
To: Somnath Roy<br>
Cc: Sage Weil; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@vge=
r.kernel.org</a>; Anirban Ray; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org"=
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
Subject: Re: [ceph-users] Scaling RBD module<br>
<br>
On 09/19/2013 12:04 PM, Somnath Roy wrote:<br>
&gt; Hi Josh,<br>
&gt; Thanks for the information. I am trying to add the following but hitti=
ng some permission issue.<br>
&gt;<br>
&gt; root@emsclient:/etc# echo &lt;mon-1&gt;:6789,&lt;mon-2&gt;:6789,&lt;mo=
n-3&gt;:6789<br>
&gt; name=3Dadmin,key=3Dclient.admin,noshare test_rbd ceph_block_test&#39; =
&gt;<br>
&gt; /sys/bus/rbd/add<br>
&gt; -bash: echo: write error: Operation not permitted<br>
<br>
If you check dmesg, it will probably show an error trying to authenticate t=
o the cluster.<br>
<br>
Instead of key=3Dclient.admin, you can pass the base64 secret value as show=
n in &#39;ceph auth list&#39; with the secret=3DXXXXXXXXXXXXXXXXXXXXX optio=
n.<br>
<br>
BTW, there&#39;s a ticket for adding the noshare option to rbd map so using=
 the sysfs interface like this is never necessary:<br>
<br>
<a href=3D"http://tracker.ceph.com/issues/6264" target=3D"_blank">http://tr=
acker.ceph.com/issues/6264</a><br>
<br>
Josh<br>
<br>
&gt; Here is the contents of rbd directory..<br>
&gt;<br>
&gt; root@emsclient:/sys/bus/rbd# ll<br>
&gt; total 0<br>
&gt; drwxr-xr-x =A04 root root =A0 =A00 Sep 19 11:59 ./<br>
&gt; drwxr-xr-x 30 root root =A0 =A00 Sep 13 11:41 ../<br>
&gt; --w------- =A01 root root 4096 Sep 19 11:59 add<br>
&gt; drwxr-xr-x =A02 root root =A0 =A00 Sep 19 12:03 devices/<br>
&gt; drwxr-xr-x =A02 root root =A0 =A00 Sep 19 12:03 drivers/<br>
&gt; -rw-r--r-- =A01 root root 4096 Sep 19 12:03 drivers_autoprobe<br>
&gt; --w------- =A01 root root 4096 Sep 19 12:03 drivers_probe<br>
&gt; --w------- =A01 root root 4096 Sep 19 12:03 remove<br>
&gt; --w------- =A01 root root 4096 Sep 19 11:59 uevent<br>
&gt;<br>
&gt;<br>
&gt; I checked even if I am logged in as root , I can&#39;t write anything =
on /sys.<br>
&gt;<br>
&gt; Here is the Ubuntu version I am using..<br>
&gt;<br>
&gt; root@emsclient:/etc# lsb_release -a<br>
&gt; No LSB modules are available.<br>
&gt; Distributor ID: Ubuntu<br>
&gt; Description: =A0 =A0Ubuntu 13.04<br>
&gt; Release: =A0 =A0 =A0 =A013.04<br>
&gt; Codename: =A0 =A0 =A0 raring<br>
&gt;<br>
&gt; Here is the mount information....<br>
&gt;<br>
&gt; root@emsclient:/etc# mount<br>
&gt; /dev/mapper/emsclient--vg-root on / type ext4 (rw,errors=3Dremount-ro)=
<br>
&gt; proc on /proc type proc (rw,noexec,nosuid,nodev) sysfs on /sys type<br=
>
&gt; sysfs (rw,noexec,nosuid,nodev) none on /sys/fs/cgroup type tmpfs (rw)<=
br>
&gt; none on /sys/fs/fuse/connections type fusectl (rw) none on<br>
&gt; /sys/kernel/debug type debugfs (rw) none on /sys/kernel/security type<=
br>
&gt; securityfs (rw) udev on /dev type devtmpfs (rw,mode=3D0755) devpts on<=
br>
&gt; /dev/pts type devpts (rw,noexec,nosuid,gid=3D5,mode=3D0620)<br>
&gt; tmpfs on /run type tmpfs (rw,noexec,nosuid,size=3D10%,mode=3D0755)<br>
&gt; none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=3D5242880)<b=
r>
&gt; none on /run/shm type tmpfs (rw,nosuid,nodev) none on /run/user type<b=
r>
&gt; tmpfs (rw,noexec,nosuid,nodev,size=3D104857600,mode=3D0755)<br>
&gt; /dev/sda1 on /boot type ext2 (rw)<br>
&gt; /dev/mapper/emsclient--vg-home on /home type ext4 (rw)<br>
&gt;<br>
&gt;<br>
&gt; Any idea what went wrong here ?<br>
&gt;<br>
&gt; Thanks &amp; Regards<br>
&gt; Somnath<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Josh Durgin [mailto:<a href=3D"mailto:josh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">j=
osh.durgin-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>]<br>
&gt; Sent: Wednesday, September 18, 2013 6:10 PM<br>
&gt; To: Somnath Roy<br>
&gt; Cc: Sage Weil; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-deve=
l@vger.kernel.org</a>; Anirban Ray;<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; Subject: Re: [ceph-users] Scaling RBD module<br>
&gt;<br>
&gt; On 09/17/2013 03:30 PM, Somnath Roy wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt; I am running Ceph on a 3 node cluster and each of my server node i=
s running 10 OSDs, one for each disk. I have one admin node and all the nod=
es are connected with 2 X 10G network. One network is for cluster and other=
 one configured as public network.<br>


&gt;&gt;<br>
&gt;&gt; Here is the status of my cluster.<br>
&gt;&gt;<br>
&gt;&gt; ~/fio_test# ceph -s<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 cluster b2e0b4db-6342-490e-9c28-0aadf0188023<br>
&gt;&gt; =A0 =A0 =A0health HEALTH_WARN clock skew detected on mon. &lt;serv=
er-name-2&gt;, mon. &lt;server-name-3&gt;<br>
&gt;&gt; =A0 =A0 =A0monmap e1: 3 mons at {&lt;server-name-1&gt;=3Dxxx.xxx.x=
xx.xxx:6789/0, &lt;server-name-2&gt;=3Dxxx.xxx.xxx.xxx:6789/0, &lt;server-n=
ame-3&gt;=3Dxxx.xxx.xxx.xxx:6789/0}, election epoch 64, quorum 0,1,2 &lt;se=
rver-name-1&gt;,&lt;server-name-2&gt;,&lt;server-name-3&gt;<br>


&gt;&gt; =A0 =A0 =A0osdmap e391: 30 osds: 30 up, 30 in<br>
&gt;&gt; =A0 =A0 =A0 pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB da=
ta, 27912 MB used, 11145 GB / 11172 GB avail<br>
&gt;&gt; =A0 =A0 =A0mdsmap e1: 0/0/1 up<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I started with rados bench command to benchmark the read performan=
ce of this Cluster on a large pool (~10K PGs) and found that each rados cli=
ent has a limitation. Each client can only drive up to a certain mark. Each=
 server =A0node cpu utilization shows it is =A0around 85-90% idle and the a=
dmin node (from where rados client is running) is around ~80-85% idle. I am=
 trying with 4K object size.<br>


&gt;<br>
&gt; Note that rados bench with 4k objects is different from rbd with 4k-si=
zed I/Os - rados bench sends each request to a new object, while rbd object=
s are 4M by default.<br>
&gt;<br>
&gt;&gt; Now, I started running more clients on the admin node and the perf=
ormance is scaling till it hits the client cpu limit. Server still has the =
cpu of 30-35% idle. With small object size I must say that the ceph per osd=
 cpu utilization is not promising!<br>


&gt;&gt;<br>
&gt;&gt; After this, I started testing the rados block interface with kerne=
l rbd module from my admin node.<br>
&gt;&gt; I have created 8 images mapped on the pool having around 10K PGs a=
nd I am not able to scale up the performance by running fio (either by crea=
ting a software raid or running on individual /dev/rbd* instances). For exa=
mple, running multiple fio instances (one in /dev/rbd1 and the other in /de=
v/rbd2) =A0the performance I am getting is half of what I am getting if run=
ning one instance. Here is my fio job script.<br>


&gt;&gt;<br>
&gt;&gt; [random-reads]<br>
&gt;&gt; ioengine=3Dlibaio<br>
&gt;&gt; iodepth=3D32<br>
&gt;&gt; filename=3D/dev/rbd1<br>
&gt;&gt; rw=3Drandread<br>
&gt;&gt; bs=3D4k<br>
&gt;&gt; direct=3D1<br>
&gt;&gt; size=3D2G<br>
&gt;&gt; numjobs=3D64<br>
&gt;&gt;<br>
&gt;&gt; Let me know if I am following the proper procedure or not.<br>
&gt;&gt;<br>
&gt;&gt; But, If my understanding is correct, kernel rbd module is acting a=
s a client to the cluster and in one admin node I can run only one of such =
kernel instance.<br>
&gt;&gt; If so, I am then limited to the client bottleneck that I stated ea=
rlier. The cpu utilization of the server side is around 85-90% idle, so, it=
 is clear that client is not driving.<br>
&gt;&gt;<br>
&gt;&gt; My question is, is there any way to hit the cluster =A0with more c=
lient from a single box while testing the rbd module ?<br>
&gt;<br>
&gt; You can run multiple librbd instances easily (for example with multipl=
e runs of the rbd bench-write command).<br>
&gt;<br>
&gt; The kernel rbd driver uses the same rados client instance for multiple=
 block devices by default. There&#39;s an option (noshare) to use a new rad=
os client instance for a newly mapped device, but it&#39;s not exposed by t=
he rbd cli. You need to use the sysfs interface that &#39;rbd map&#39; uses=
 instead.<br>


&gt;<br>
&gt; Once you&#39;ve used rbd map once on a machine, the kernel will alread=
y have the auth key stored, and you can use:<br>
&gt;<br>
&gt; echo &#39;<a href=3D"http://1.2.3.4:6789" target=3D"_blank">1.2.3.4:67=
89</a> name=3Dadmin,key=3Dclient.admin,noshare poolname<br>
&gt; imagename&#39; &gt; /sys/bus/rbd/add<br>
&gt;<br>
&gt; Where <a href=3D"http://1.2.3.4:6789" target=3D"_blank">1.2.3.4:6789</=
a> is the address of a monitor, and you&#39;re connecting as client.admin.<=
br>
&gt;<br>
&gt; You can use &#39;rbd unmap&#39; as usual.<br>
&gt;<br>
&gt; Josh<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above. I=
f the reader of this message is not the intended recipient, you are hereby =
notified that you have received this message in error and that any review, =
dissemination, distribution, or copying of this message is strictly prohibi=
ted. If you have received this communication in error, please notify the se=
nder by telephone or e-mail (as shown above) immediately and destroy any an=
d all copies of this message in your possession (whether hard copies or ele=
ctronically stored copies).<br>


&gt;<br>
&gt;<br>
<br>
</div></div>--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> More majordomo info at =A0<a href=3D"http:=
//vger.kernel.org/majordomo-info.html" target=3D"_blank">http://vger.kernel=
.org/majordomo-info.html</a><br>


<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--001a11335194d964b404e7278e8c--

--===============1792789244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1792789244==--
