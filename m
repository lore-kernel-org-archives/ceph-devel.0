From: Alex Gorbachev <ag-VxEtxStO0vCD5NdjQRoWIEEOCMrvLtNR@public.gmane.org>
Subject: Re: Ceph + VMWare
Date: Tue, 18 Oct 2016 23:10:42 -0400
Message-ID: <CADb9452marymBx0LWf+wqAEy972_veyp4-6KwKZy+6zfdTKbxg@mail.gmail.com>
References: <CAAZbbf1HGbZVbB1m5vPd+afWb0pZz4haQhua4FcQa-31FPg=0g@mail.gmail.com>
	<CADb9453mfXcgxMuOMvbz12XDB02bbzuaV-Jtoiqd04n7XuSzJg@mail.gmail.com>
	<7668a4fa-ad86-30c8-f211-3969b21c58e4@univ-lorraine.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0295750554=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <7668a4fa-ad86-30c8-f211-3969b21c58e4-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0295750554==
Content-Type: multipart/alternative; boundary=001a114dc77e8e0697053f2f27fd

--001a114dc77e8e0697053f2f27fd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 18, 2016, Fr=C3=A9d=C3=A9ric Nass <frederic.nass@univ-l=
orraine.fr>
wrote:

> Hi Alex,
>
> Just to know, what kind of backstore are you using whithin Storcium ? vdi=
sk_fileio
> or vdisk_blockio ?
>
> I see your agents can handle both : http://www.spinics.net/lists/
> ceph-users/msg27817.html
>
Hi Fr=C3=A9d=C3=A9ric,

We use all of them, and NFS as well, which has been performing quite well.
Vdisk_fileio is a bit dangerous in write cache mode.  Also, for some
reason, object size of 16MB for RBD does better with VMWare.

Storcium gives you a choice for each LUN.  The challenge has been figuring
out optimal workloads under highly varied use cases.  I see better results
with NVMe journals and write combining HBAs, e.g. Areca.

Regards,
Alex

> Regards,
>
> Fr=C3=A9d=C3=A9ric.
>
> Le 06/10/2016 =C3=A0 16:01, Alex Gorbachev a =C3=A9crit :
>
> On Wed, Oct 5, 2016 at 2:32 PM, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> <ja=
vascript:_e(%7B%7D,'cvml','pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org');> wrote:
>
> Hey guys,
>
> Starting to buckle down a bit in looking at how we can better set up
> Ceph for VMWare integration, but I need a little info/help from you
> folks.
>
> If you currently are using Ceph+VMWare, or are exploring the option,
> I'd like some simple info from you:
>
> 1) Company
> 2) Current deployment size
> 3) Expected deployment growth
> 4) Integration method (or desired method) ex: iscsi, native, etc
>
> Just casting the net so we know who is interested and might want to
> help us shape and/or test things in the future if we can make it
> better. Thanks.
>
>
> Hi Patrick,
>
> We have Storcium certified with VMWare, and we use it ourselves:
>
> Ceph Hammer latest
>
> SCST redundant Pacemaker based delivery front ends - our agents are
> published on github
>
> EnhanceIO for read caching at delivery layer
>
> NFS v3, and iSCSI and FC delivery
>
> Our deployment size we use ourselves is 700 TB raw.
>
> Challenges are as others described, but HA and multi host access works
> fine courtesy of SCST.  Write amplification is a challenge on spinning
> disks.
>
> Happy to share more.
>
> Alex
>
>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hathttp://ceph.com  ||  http://community.r=
edhat.com
> @scuttlemonkey || @ceph
> _______________________________________________
> ceph-users mailing listceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:_e(%7B%7D,'c=
vml','ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org');>http://lists.ceph.com/listinfo.cgi/ceph-=
users-ceph.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <javascript:_e(%7B%7D,=
'cvml','majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org');>
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

--=20
--
Alex Gorbachev
Storcium

--001a114dc77e8e0697053f2f27fd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 18, 2016, Fr=C3=A9d=C3=A9ric Nass &lt;<a href=3D"mailto=
:frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org">frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>Hi Alex,</p>
    <p>Just to know, what kind of backstore are you using whithin
      Storcium ? <span>vdisk_fileio or vdisk_blockio ?</span></p>
    <p><span>I see your agents can handle both :
        <a href=3D"http://www.spinics.net/lists/ceph-users/msg27817.html" t=
arget=3D"_blank">http://www.spinics.net/lists/<wbr>ceph-users/msg27817.html=
</a></span></p></div></blockquote><div>Hi=C2=A0<font size=3D"2"><span style=
=3D"background-color:rgba(255,255,255,0)">Fr=C3=A9d=C3=A9ric,</span></font>=
</div><div><font size=3D"2"><span style=3D"background-color:rgba(255,255,25=
5,0)"><br></span></font></div><div><font size=3D"2"><span style=3D"backgrou=
nd-color:rgba(255,255,255,0)">We use all of them, and NFS as well, which ha=
s been performing quite well.=C2=A0 Vdisk_fileio is a bit dangerous in writ=
e cache mode.=C2=A0 Also, for some reason, object size of 16MB for RBD does=
 better with VMWare.</span></font></div><div><font size=3D"2"><span style=
=3D"background-color:rgba(255,255,255,0)"><br></span></font></div><div><fon=
t size=3D"2"><span style=3D"background-color:rgba(255,255,255,0)">Storcium =
gives you a choice for each LUN.=C2=A0 The challenge has been figuring out =
optimal workloads under highly varied use cases.=C2=A0 I see better results=
 with NVMe journals and write combining HBAs, e.g. Areca.</span></font></di=
v><div><font size=3D"2"><span style=3D"background-color:rgba(255,255,255,0)=
"><br></span></font></div><div><font size=3D"2"><span style=3D"background-c=
olor:rgba(255,255,255,0)">Regards,</span></font></div><div><font size=3D"2"=
><span style=3D"background-color:rgba(255,255,255,0)">Alex</span></font></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div bgcolor=3D"#FFFFFF" text=3D"#000000"=
>
    <p><span>Regards,</span></p>
    <p><span>Fr=C3=A9d=C3=A9ric.<br>
      </span></p>
    <br>
    <div>Le 06/10/2016 =C3=A0 16:01, Alex Gorbachev a
      =C3=A9crit=C2=A0:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On Wed, Oct 5, 2016 at 2:32 PM, Patrick McGarry <a href=3D"javas=
cript:_e(%7B%7D,&#39;cvml&#39;,&#39;pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&#39;);" target=3D"_=
blank">&lt;pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre>Hey guys,

Starting to buckle down a bit in looking at how we can better set up
Ceph for VMWare integration, but I need a little info/help from you
folks.

If you currently are using Ceph+VMWare, or are exploring the option,
I&#39;d like some simple info from you:

1) Company
2) Current deployment size
3) Expected deployment growth
4) Integration method (or desired method) ex: iscsi, native, etc

Just casting the net so we know who is interested and might want to
help us shape and/or test things in the future if we can make it
better. Thanks.

</pre>
      </blockquote>
      <pre>Hi Patrick,

We have Storcium certified with VMWare, and we use it ourselves:

Ceph Hammer latest

SCST redundant Pacemaker based delivery front ends - our agents are
published on github

EnhanceIO for read caching at delivery layer

NFS v3, and iSCSI and FC delivery

Our deployment size we use ourselves is 700 TB raw.

Challenges are as others described, but HA and multi host access works
fine courtesy of SCST.  Write amplification is a challenge on spinning
disks.

Happy to share more.

Alex

</pre>
      <blockquote type=3D"cite">
        <pre>--

Best Regards,

Patrick McGarry
Director Ceph Community || Red Hat
<a href=3D"http://ceph.com" target=3D"_blank">http://ceph.com</a>  ||  <a h=
ref=3D"http://community.redhat.com" target=3D"_blank">http://community.redh=
at.com</a>
@scuttlemonkey || @ceph
______________________________<wbr>_________________
ceph-users mailing list
<a href=3D"javascript:_e(%7B%7D,&#39;cvml&#39;,&#39;ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om&#39;);" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-users-ceph.<wbr>co=
m</a>
</pre>
      </blockquote>
      <pre>--
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in
the body of a message to <a href=3D"javascript:_e(%7B%7D,&#39;cvml&#39;,&#3=
9;majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&#39;);" target=3D"_blank">majordomo-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org</a>
More majordomo info at  <a href=3D"http://vger.kernel.org/majordomo-info.ht=
ml" target=3D"_blank">http://vger.kernel.org/<wbr>majordomo-info.html</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote><br><br>-- <br><div dir=3D"ltr">--<div>Alex Gorbachev</div><di=
v>Storcium</div></div><br>

--001a114dc77e8e0697053f2f27fd--

--===============0295750554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0295750554==--
