From: charles L <charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: testing ceph
Date: Mon, 4 Nov 2013 16:25:38 +0100
Message-ID: <DUB116-W91D38BDD6BED25D0F26267E0F60@phx.gbl>
References: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>,
	<5272373C.4020906@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353200058=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5272373C.4020906-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0353200058==
Content-Type: multipart/alternative;
	boundary="_f5c0c06b-58bd-4f89-a6b3-634fe8b74a3d_"

--_f5c0c06b-58bd-4f89-a6b3-634fe8b74a3d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


 Pls can somebody help?  Im  getting this error.
ceph@CephAdmin:~$ ceph-deploy osd create server1:sda:/dev/sdj1[ceph_deploy.=
cli][INFO  ] Invoked (1.3): /usr/bin/ceph-deploy osd create server1:sda:/de=
v/sdj1[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks server1:/dev/s=
da:/dev/sdj1[server1][DEBUG ] connected to host: server1[server1][DEBUG ] d=
etect platform information from remote host[server1][DEBUG ] detect machine=
 type[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise[ceph_deplo=
y.osd][DEBUG ] Deploying osd to server1[server1][DEBUG ] write cluster conf=
iguration to /etc/ceph/{cluster}.conf[server1][INFO  ] Running command: sud=
o udevadm trigger --subsystem-match=3Dblock --action=3Dadd[ceph_deploy.osd]=
[DEBUG ] Preparing host server1 disk /dev/sda journal /dev/sdj1 activate Tr=
ue[server1][INFO  ] Running command: sudo ceph-disk-prepare --fs-type xfs -=
-cluster ceph -- /dev/sda /dev/sdj1[server1][ERROR ] WARNING:ceph-disk:OSD =
will not be hot-swappable if journal is not the same device as the osd data=
[server1][ERROR ] Could not create partition 1 from 34 to 2047[server1][ERR=
OR ] Error encountered=3B not saving changes.[server1][ERROR ] ceph-disk: E=
rror: Command '['sgdisk'=2C '--largest-new=3D1'=2C '--change-name=3D1:ceph =
data'=2C '--partition-guid=3D1:d3ca8a92-7ba5-412e-abf5-06af958b788d'=2C '--=
typecode=3D1:89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be'=2C '--'=2C '/dev/sda']' =
returned non-zero exit status 4[server1][ERROR ] Traceback (most recent cal=
l last):[server1][ERROR ]   File "/usr/lib/python2.7/dist-packages/ceph_dep=
loy/lib/remoto/process.py"=2C line 68=2C in run[server1][ERROR ]     report=
ing(conn=2C result=2C timeout)[server1][ERROR ]   File "/usr/lib/python2.7/=
dist-packages/ceph_deploy/lib/remoto/log.py"=2C line 13=2C in reporting[ser=
ver1][ERROR ]     received =3D result.receive(timeout)[server1][ERROR ]   F=
ile "/usr/lib/python2.7/dist-packages/ceph_deploy/lib/remoto/lib/execnet/ga=
teway_base.py"=2C line 455=2C in receive[server1][ERROR ]     raise self._g=
etremoteerror() or EOFError()[server1][ERROR ] RemoteError: Traceback (most=
 recent call last):[server1][ERROR ]   File "<string>"=2C line 806=2C in ex=
ecutetask[server1][ERROR ]   File ""=2C line 35=2C in _remote_run[server1][=
ERROR ] RuntimeError: command returned non-zero exit status: 1[server1][ERR=
OR ][server1][ERROR ][ceph_deploy.osd][ERROR ] Failed to execute command: c=
eph-disk-prepare --fs-type xfs --cluster ceph -- /dev/sda /dev/sdj1[ceph_de=
ploy][ERROR ] GenericError: Failed to create 1 OSDs





> Date: Thu=2C 31 Oct 2013 10:55:56 +0000
> From: joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
> To: charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org=3B ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: testing ceph
>=20
> On 10/31/2013 04:54 AM=2C charles L wrote:
> > Hi=2C
> > Pls is this a good setup for a production environment test of ceph? My =
focus is on the SSD ... should it be partitioned(sdf1=2C2 =2C3=2C4) and sha=
red by the four OSDs on a host? or is this a better configuration for the S=
SD to be just one partition(sdf1) while all osd uses that one partition?
> > my setup:
> > - 6 Servers with one 250gb boot disk for OS(sda)=2C
> > four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 disks (=
sdb -sde)
> > and one-60GB SSD for Osd Journal(sdf).
> > -RAM =3D 32GB on each server with 2 GB network link.
> > hostname for servers: Server1 -Server6
>=20
> Charles=2C
>=20
> What you are describing on the ceph.conf below is definitely not a good=20
> idea.  If you really want to use just one SSD and share it across=20
> multiple OSDs=2C then you have two possible approaches:
>=20
> - partition that disk and assign a *different* partition to each OSD=3B o=
r
> - keep only one partition=2C format it with some filesystem=2C and assign=
 a=20
> *different* journal file within that fs to each OSD.
>=20
> What you are describing has you using the same partition for all OSDs.=20
> This will likely create issues due to multiple OSDs writing and reading=20
> from a single journal.  TBH I'm not familiar enough with the journal=20
> mechanism to know whether the OSDs will detect that situation.
>=20
>    -Joao
>=20
> >
> > [osd.0]
> >   host =3D server1
> > devs =3D /dev/sdb
> > osd journal =3D /dev/sdf1
> > [osd.1]
> > host =3D server1
> > devs =3D /dev/sdc
> > osd journal =3D /dev/sdf2
> >
> > [osd.3]
> > host =3D server1
> > devs =3D /dev/sdd
> > osd journal =3D /dev/sdf2
> >
> > [osd.4]
> > host =3D server1
> > devs =3D /dev/sde
> > osd journal =3D /dev/sdf2
> > [osd.5]
> > host =3D server2
> > devs =3D /dev/sdb
> > osd journal =3D /dev/sdf2
> > ...
> > [osd.23]
> > host =3D server6
> > devs =3D /dev/sde
> > osd journal =3D /dev/sdf2
> >
> > Thanks. 		 	   		  --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
>=20
> --=20
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com
 		 	   		  =

--_f5c0c06b-58bd-4f89-a6b3-634fe8b74a3d_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div><br></div><div>&nbsp=3BPls =
can somebody help? &nbsp=3BIm &nbsp=3Bgetting this error.</div><div><br></d=
iv><div>ceph@CephAdmin:~$ ceph-deploy osd create server1:sda:/dev/sdj1</div=
><div>[ceph_deploy.cli][INFO &nbsp=3B] Invoked (1.3): /usr/bin/ceph-deploy =
osd create server1:sda:/dev/sdj1</div><div>[ceph_deploy.osd][DEBUG ] Prepar=
ing cluster ceph disks server1:/dev/sda:/dev/sdj1</div><div>[server1][DEBUG=
 ] connected to host: server1</div><div>[server1][DEBUG ] detect platform i=
nformation from remote host</div><div>[server1][DEBUG ] detect machine type=
</div><div>[ceph_deploy.osd][INFO &nbsp=3B] Distro info: Ubuntu 12.04 preci=
se</div><div>[ceph_deploy.osd][DEBUG ] Deploying osd to server1</div><div>[=
server1][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf</d=
iv><div>[server1][INFO &nbsp=3B] Running command: sudo udevadm trigger --su=
bsystem-match=3Dblock --action=3Dadd</div><div>[ceph_deploy.osd][DEBUG ] Pr=
eparing host server1 disk /dev/sda journal /dev/sdj1 activate True</div><di=
v>[server1][INFO &nbsp=3B] Running command: sudo ceph-disk-prepare --fs-typ=
e xfs --cluster ceph -- /dev/sda /dev/sdj1</div><div>[server1][ERROR ] WARN=
ING:ceph-disk:OSD will not be hot-swappable if journal is not the same devi=
ce as the osd data</div><div>[server1][ERROR ] Could not create partition 1=
 from 34 to 2047</div><div>[server1][ERROR ] Error encountered=3B not savin=
g changes.</div><div>[server1][ERROR ] ceph-disk: Error: Command '['sgdisk'=
=2C '--largest-new=3D1'=2C '--change-name=3D1:ceph data'=2C '--partition-gu=
id=3D1:d3ca8a92-7ba5-412e-abf5-06af958b788d'=2C '--typecode=3D1:89c57f98-2f=
e5-4dc0-89c1-f3ad0ceff2be'=2C '--'=2C '/dev/sda']' returned non-zero exit s=
tatus 4</div><div>[server1][ERROR ] Traceback (most recent call last):</div=
><div>[server1][ERROR ] &nbsp=3B File "/usr/lib/python2.7/dist-packages/cep=
h_deploy/lib/remoto/process.py"=2C line 68=2C in run</div><div>[server1][ER=
ROR ] &nbsp=3B &nbsp=3B reporting(conn=2C result=2C timeout)</div><div>[ser=
ver1][ERROR ] &nbsp=3B File "/usr/lib/python2.7/dist-packages/ceph_deploy/l=
ib/remoto/log.py"=2C line 13=2C in reporting</div><div>[server1][ERROR ] &n=
bsp=3B &nbsp=3B received =3D result.receive(timeout)</div><div>[server1][ER=
ROR ] &nbsp=3B File "/usr/lib/python2.7/dist-packages/ceph_deploy/lib/remot=
o/lib/execnet/gateway_base.py"=2C line 455=2C in receive</div><div>[server1=
][ERROR ] &nbsp=3B &nbsp=3B raise self._getremoteerror() or EOFError()</div=
><div>[server1][ERROR ] RemoteError: Traceback (most recent call last):</di=
v><div>[server1][ERROR ] &nbsp=3B File "&lt=3Bstring&gt=3B"=2C line 806=2C =
in executetask</div><div>[server1][ERROR ] &nbsp=3B File ""=2C line 35=2C i=
n _remote_run</div><div>[server1][ERROR ] RuntimeError: command returned no=
n-zero exit status: 1</div><div>[server1][ERROR ]</div><div>[server1][ERROR=
 ]</div><div>[ceph_deploy.osd][ERROR ] Failed to execute command: ceph-disk=
-prepare --fs-type xfs --cluster ceph -- /dev/sda /dev/sdj1</div><div>[ceph=
_deploy][ERROR ] GenericError: Failed to create 1 OSDs</div><div><br></div>=
<div><br></div><div><br></div><div><br></div><div><br></div><br><div>&gt=3B=
 Date: Thu=2C 31 Oct 2013 10:55:56 +0000<br>&gt=3B From: joao.luis@inktank.=
com<br>&gt=3B To: charlesboy009-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org=3B ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<b=
r>&gt=3B Subject: Re: testing ceph<br>&gt=3B <br>&gt=3B On 10/31/2013 04:54=
 AM=2C charles L wrote:<br>&gt=3B &gt=3B Hi=2C<br>&gt=3B &gt=3B Pls is this=
 a good setup for a production environment test of ceph? My focus is on the=
 SSD ... should it be partitioned(sdf1=2C2 =2C3=2C4) and shared by the four=
 OSDs on a host? or is this a better configuration for the SSD to be just o=
ne partition(sdf1) while all osd uses that one partition?<br>&gt=3B &gt=3B =
my setup:<br>&gt=3B &gt=3B - 6 Servers with one 250gb boot disk for OS(sda)=
=2C<br>&gt=3B &gt=3B four-2Tb Disks each for the OSDs i.e Total disks =3D 6=
x4 =3D 24 disks (sdb -sde)<br>&gt=3B &gt=3B and one-60GB SSD for Osd Journa=
l(sdf).<br>&gt=3B &gt=3B -RAM =3D 32GB on each server with 2 GB network lin=
k.<br>&gt=3B &gt=3B hostname for servers: Server1 -Server6<br>&gt=3B <br>&g=
t=3B Charles=2C<br>&gt=3B <br>&gt=3B What you are describing on the ceph.co=
nf below is definitely not a good <br>&gt=3B idea.  If you really want to u=
se just one SSD and share it across <br>&gt=3B multiple OSDs=2C then you ha=
ve two possible approaches:<br>&gt=3B <br>&gt=3B - partition that disk and =
assign a *different* partition to each OSD=3B or<br>&gt=3B - keep only one =
partition=2C format it with some filesystem=2C and assign a <br>&gt=3B *dif=
ferent* journal file within that fs to each OSD.<br>&gt=3B <br>&gt=3B What =
you are describing has you using the same partition for all OSDs. <br>&gt=
=3B This will likely create issues due to multiple OSDs writing and reading=
 <br>&gt=3B from a single journal.  TBH I'm not familiar enough with the jo=
urnal <br>&gt=3B mechanism to know whether the OSDs will detect that situat=
ion.<br>&gt=3B <br>&gt=3B    -Joao<br>&gt=3B <br>&gt=3B &gt=3B<br>&gt=3B &g=
t=3B [osd.0]<br>&gt=3B &gt=3B   host =3D server1<br>&gt=3B &gt=3B devs =3D =
/dev/sdb<br>&gt=3B &gt=3B osd journal =3D /dev/sdf1<br>&gt=3B &gt=3B [osd.1=
]<br>&gt=3B &gt=3B host =3D server1<br>&gt=3B &gt=3B devs =3D /dev/sdc<br>&=
gt=3B &gt=3B osd journal =3D /dev/sdf2<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B [o=
sd.3]<br>&gt=3B &gt=3B host =3D server1<br>&gt=3B &gt=3B devs =3D /dev/sdd<=
br>&gt=3B &gt=3B osd journal =3D /dev/sdf2<br>&gt=3B &gt=3B<br>&gt=3B &gt=
=3B [osd.4]<br>&gt=3B &gt=3B host =3D server1<br>&gt=3B &gt=3B devs =3D /de=
v/sde<br>&gt=3B &gt=3B osd journal =3D /dev/sdf2<br>&gt=3B &gt=3B [osd.5]<b=
r>&gt=3B &gt=3B host =3D server2<br>&gt=3B &gt=3B devs =3D /dev/sdb<br>&gt=
=3B &gt=3B osd journal =3D /dev/sdf2<br>&gt=3B &gt=3B ...<br>&gt=3B &gt=3B =
[osd.23]<br>&gt=3B &gt=3B host =3D server6<br>&gt=3B &gt=3B devs =3D /dev/s=
de<br>&gt=3B &gt=3B osd journal =3D /dev/sdf2<br>&gt=3B &gt=3B<br>&gt=3B &g=
t=3B Thanks. 		 	   		  --<br>&gt=3B &gt=3B To unsubscribe from this list: =
send the line "unsubscribe ceph-devel" in<br>&gt=3B &gt=3B the body of a me=
ssage to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>&gt=3B &gt=3B More majordomo info at =
 http://vger.kernel.org/majordomo-info.html<br>&gt=3B &gt=3B<br>&gt=3B <br>=
&gt=3B <br>&gt=3B -- <br>&gt=3B Joao Eduardo Luis<br>&gt=3B Software Engine=
er | http://inktank.com | http://ceph.com<br></div> 		 	   		  </div></body=
>
</html>=

--_f5c0c06b-58bd-4f89-a6b3-634fe8b74a3d_--

--===============0353200058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0353200058==--
