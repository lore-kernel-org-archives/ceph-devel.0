From: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Subject: Re: PG inconsistency
Date: Mon, 10 Nov 2014 11:29:36 -0800
Message-ID: <CADHZLBZunhc32Gnk7+BvR5-pYX+n3J5nWRpocfxkik9qEa=8vw@mail.gmail.com>
References: <BLU175-W41E1F32E90ED411A4477FFDF840@phx.gbl>
	<alpine.DEB.2.00.1411070213510.15135@cobra.newdream.net>
	<BLU175-W4789CCDB578B9A70E1CC8ADF800@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526617343=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU175-W4789CCDB578B9A70E1CC8ADF800-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1526617343==
Content-Type: multipart/alternative; boundary=047d7bae47a20c410d05078630b0

--047d7bae47a20c410d05078630b0
Content-Type: text/plain; charset=UTF-8

For #1, it depends what you mean by fast.  I wouldn't worry about it taking
15 minutes.

If you mark the old OSD out, ceph will start remapping data immediately,
including a bunch of PGs on unrelated OSDs.  Once you replace the disk, and
put the same OSDID back in the same host, the CRUSH map will be back to
what it was before you started.  All of those remaps on unrelated OSDs will
reverse.  They'll complete fairly quickly, because they only have to
backfill the data that was written during the remap.


I prefer #1.  ceph pg repair will just overwrite the replicas with whatever
the primary OSD has, which may copy bad data from your bad OSD over good
replicas.  So #2 has the potential to corrupt the data.  #1 will delete the
data you know is bad, leaving only good data behind to replicate.  Once
ceph pg repair gets more intelligent, I'll revisit this.

I also prefer the simplicity.  If it's dead or corrupt, they're treated the
same.




On Sun, Nov 9, 2014 at 7:25 PM, GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org> wrote:

>
> In terms of disk replacement, to avoid migrating data back and forth, are
> the below two approaches reasonable?
>  1. Keep the OSD in and do an ad-hoc disk replacement and provision a new
> OSD (so that keep the OSD id as the same), and then trigger data migration.
> In this way the data migration only happens once, however, it does require
> operators to replace the disk very fast.
>  2. Move the data on the broken disk to a new disk completely and use Ceph
> to repair bad objects.
>
> Thanks,
> Guang
>

--047d7bae47a20c410d05078630b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For #1, it depends what you mean by fast.=C2=A0 I wouldn&#=
39;t worry about it taking 15 minutes.<div><br></div><div><div>If you mark =
the old OSD out, ceph will start remapping data immediately, including a bu=
nch of PGs on unrelated OSDs.=C2=A0 Once you replace the disk, and put the =
same OSDID back in the same host, the CRUSH map will be back to what it was=
 before you started.=C2=A0 All of those remaps on unrelated OSDs will rever=
se.=C2=A0 They&#39;ll complete fairly quickly, because they only have to ba=
ckfill the data that was written during the remap.</div><div><br></div><div=
><br></div><div>I prefer #1. =C2=A0ceph pg repair will just overwrite the r=
eplicas with whatever the primary OSD has, which may copy bad data from you=
r bad OSD over good replicas.=C2=A0 So #2 has the potential to corrupt the =
data. =C2=A0#1 will delete the data you know is bad, leaving only good data=
 behind to replicate.=C2=A0 Once ceph pg repair gets more intelligent, I&#3=
9;ll revisit this.</div><div><br></div><div>I also prefer the simplicity.=
=C2=A0 If it&#39;s dead or corrupt, they&#39;re treated the same.</div><div=
><br></div><div><br></div><div><br></div><div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Sun, Nov 9, 2014 at 7:25 PM, GuangYang <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org" target=3D"_blank"=
>yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><br>
In terms of disk replacement, to avoid migrating data back and forth, are t=
he below two approaches reasonable?<br>
=C2=A01. Keep the OSD in and do an ad-hoc disk replacement and provision a =
new OSD (so that keep the OSD id as the same), and then trigger data migrat=
ion. In this way the data migration only happens once, however, it does req=
uire operators to replace the disk very fast.<br>
=C2=A02. Move the data on the broken disk to a new disk completely and use =
Ceph to repair bad objects.<br>
<br>
Thanks,<br>
Guang<br></blockquote><div><br></div><div>=C2=A0</div></div></div></div></d=
iv></div>

--047d7bae47a20c410d05078630b0--

--===============1526617343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1526617343==--
