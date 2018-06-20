From: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Subject: Re: issues with ceph nautilus version
Date: Wed, 20 Jun 2018 18:14:06 +0200
Message-ID: <CAD9yTbHvuaZcfWSKVd+bex2TPaEsrrwreoeTedPq=OpEyucH5A@mail.gmail.com>
References: <CY1PR12MB0774E4B82E4528FE9DA7D162BC770@CY1PR12MB0774.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3003737259623906659=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CY1PR12MB0774E4B82E4528FE9DA7D162BC770-1s8aH8ViOEdztePUUsNjzQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Raju Rangoju <rajur-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3003737259623906659==
Content-Type: multipart/alternative; boundary="0000000000008e5daa056f1516fd"

--0000000000008e5daa056f1516fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've also seen something similar with Luminous once on broken OSDs reportin=
g
nonsense stats that overflowed some variables and reporting 10000000% full.

In my case it was Bluestore OSDs running on too tiny VMs.

Paul


2018-06-20 17:41 GMT+02:00 Raju Rangoju <rajur-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>:

> Hi,
>
>
>
> Recently I have upgraded my ceph cluster to version 14.0.0 - nautilus(dev=
)
> from ceph version 13.0.1, after this, I noticed some weird data usage
> numbers on the cluster.
>
> Here are the issues I=E2=80=99m seeing=E2=80=A6
>
>    1. The data usage reported is much more than what is available
>
> usage:   16 EiB used, 164 TiB / 158 TiB avail
>
>
>
> before this upgradation, it used to report properly
>
> usage:   1.10T used, 157T / 158T avail
>
>
>
>    1. it reports that all the osds/pool are full
>
>
>
> Can someone please shed some light? Any helps is greatly appreciated.
>
>
>
> [root@hadoop1 my-ceph]# ceph --version
>
> ceph version 14.0.0-480-g6c1e8ee (6c1e8ee14f9b25dc96684dbc1f8c8255c47f0bb=
9)
> nautilus (dev)
>
>
>
> [root@hadoop1 my-ceph]# ceph -s
>
>   cluster:
>
>     id:     ee4660fd-167b-42e6-b27b-126526dab04d
>
>     health: HEALTH_ERR
>
>             87 full osd(s)
>
>             11 pool(s) full
>
>
>
>   services:
>
>     mon: 3 daemons, quorum hadoop1,hadoop4,hadoop6
>
>     mgr: hadoop6(active), standbys: hadoop1, hadoop4
>
>     mds: cephfs-1/1/1 up  {0=3Dhadoop3=3Dup:creating}, 2 up:standby
>
>     osd: 88 osds: 87 up, 87 in
>
>
>
>   data:
>
>     pools:   11 pools, 32588 pgs
>
>     objects: 0  objects, 0 B
>
>     usage:   16 EiB used, 164 TiB / 158 TiB avail
>
>     pgs:     32588 active+clean
>
>
>
> Thanks in advance
>
> -Raj
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


--=20
Paul Emmerich

Looking for help with your Ceph cluster? Contact us at https://croit.io

croit GmbH
Freseniusstr. 31h
81247 M=C3=BCnchen
www.croit.io
Tel: +49 89 1896585 90

--0000000000008e5daa056f1516fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve also seen something similar with Luminous on=
ce on broken OSDs reporting</div><div>nonsense stats that overflowed some v=
ariables and reporting 10000000% full.<br></div><div><br></div><div>In my c=
ase it was Bluestore OSDs running on too tiny VMs.<br></div><div><br></div>=
<div>Paul</div><div><br></div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">2018-06-20 17:41 GMT+02:00 Raju  Rangoju <span dir=3D"lt=
r">&lt;<a href=3D"mailto:rajur-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">rajur@chelsio=
.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div link=3D"#0563C1" vlink=3D"#954F72" lang=3D"EN-IN">
<div class=3D"m_-7218210564623522561WordSection1">
<p class=3D"MsoNormal">Hi,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Recently I have upgraded my ceph cluster to version =
14.0.0 - nautilus(dev) from ceph version 13.0.1, after this, I noticed some=
 weird data usage numbers on the cluster.<u></u><u></u></p>
<p class=3D"MsoNormal">Here are the issues I=E2=80=99m seeing=E2=80=A6<u></=
u><u></u></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"m_-7218210564623522561MsoListParagraph" style=3D"margin-left:0=
cm">The data usage reported is much more than what is available
<u></u><u></u></li></ol>
<p class=3D"m_-7218210564623522561MsoListParagraph">usage:=C2=A0=C2=A0 16 E=
iB used, 164 TiB / 158 TiB avail<u></u><u></u></p>
<p class=3D"m_-7218210564623522561MsoListParagraph"><u></u>=C2=A0<u></u></p=
>
<p class=3D"m_-7218210564623522561MsoListParagraph">before this upgradation=
, it used to report properly<u></u><u></u></p>
<p class=3D"m_-7218210564623522561MsoListParagraph">usage:=C2=A0=C2=A0 1.10=
T used, 157T / 158T avail<u></u><u></u></p>
<p class=3D"m_-7218210564623522561MsoListParagraph"><u></u>=C2=A0<u></u></p=
>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"m_-7218210564623522561MsoListParagraph" style=3D"margin-left:0=
cm">it reports that all the osds/pool are full<u></u><u></u></li></ol>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Can someone please shed some light? Any helps is gre=
atly appreciated.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">[root@hadoop1 my-ceph]# ceph --version<u></u><u></u>=
</p>
<p class=3D"MsoNormal">ceph version 14.0.0-480-g6c1e8ee (<wbr>6c1e8ee14f9b2=
5dc96684dbc1f8c82<wbr>55c47f0bb9) nautilus (dev)<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">[root@hadoop1 my-ceph]# ceph -s<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0 cluster:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 id:=C2=A0=C2=A0=C2=A0=C2=A0 ee466=
0fd-167b-42e6-b27b-<wbr>126526dab04d<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 health: HEALTH_ERR<u></u><u></u><=
/p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 87 full osd(s)<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 11 pool(s) full<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0 services:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 mon: 3 daemons, quorum hadoop1,ha=
doop4,hadoop6<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 mgr: hadoop6(active), standbys: h=
adoop1, hadoop4<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 mds: cephfs-1/1/1 up=C2=A0 {0=3Dh=
adoop3=3Dup:creating}, 2 up:standby<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 osd: 88 osds: 87 up, 87 in<u></u>=
<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0 data:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 pools:=C2=A0=C2=A0 11 pools, 3258=
8 pgs<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 objects: 0=C2=A0 objects, 0 B<u><=
/u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 usage:=C2=A0=C2=A0 16 EiB used, 1=
64 TiB / 158 TiB avail<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 pgs:=C2=A0=C2=A0=C2=A0=C2=A0 3258=
8 active+clean<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks in advance<u></u><u></u></p>
<p class=3D"MsoNormal">-Raj<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>

<br>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div d=
ir=3D"ltr"><div><div dir=3D"ltr">Paul Emmerich<br><br>Looking for help with=
 your Ceph cluster? Contact us at <a href=3D"https://croit.io" target=3D"_b=
lank">https://croit.io</a><br><br>croit GmbH<br>Freseniusstr. 31h<br>81247 =
M=C3=BCnchen<br><a href=3D"http://www.croit.io" target=3D"_blank">www.croit=
.io</a><br>Tel: +49 89 1896585 90<br></div></div></div></div></div></div>
</div>

--0000000000008e5daa056f1516fd--

--===============3003737259623906659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3003737259623906659==--
