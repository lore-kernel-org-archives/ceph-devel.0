From: Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
Subject: Re: RBD behavior for reads to a volume with no data
	written
Date: Tue, 2 May 2017 10:24:31 -0700
Message-ID: <CAAD08TC_-mPpGOFipgxpPbftFNyhCEMq+1uu3Mf7c0D3TZWTJA@mail.gmail.com>
References: <CAAD08TBLF3TWP=JaXrq05D-5CZhtf79ahg-ooxao3AzR+7_ARg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0370287558=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAD08TBLF3TWP=JaXrq05D-5CZhtf79ahg-ooxao3AzR+7_ARg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0370287558==
Content-Type: multipart/alternative; boundary=f403043c4bec125bf9054e8dd0e0

--f403043c4bec125bf9054e8dd0e0
Content-Type: text/plain; charset=UTF-8

I wanted to add that I was particularly interested about the behavior with
filestore, but was also curious how this works on bluestore.

Prashant

On Mon, May 1, 2017 at 10:04 PM, Prashant Murthy <pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org>
wrote:

> Hi all,
>
> I was wondering what happens when reads are issued to an RBD device with
> no previously written data. Can somebody explain how such requests flow
> from rbd (client) into OSDs and whether any of these reads would hit the
> disks at all or whether OSD metadata would recognize that there is no data
> at the offsets requested and returns a bunch of zeros back to the client?
>
> Thanks,
> Prashant
>
> --
> Prashant Murthy
> Sr Director, Software Engineering | Salesforce
> Mobile: 919-961-3041 <(919)%20961-3041>
>
>
> --
>



-- 
Prashant Murthy
Sr Director, Software Engineering | Salesforce
Mobile: 919-961-3041 <(919)%20961-3041>


--

--f403043c4bec125bf9054e8dd0e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I wanted to add that I was particularly interested about t=
he behavior with filestore, but was also curious how this works on bluestor=
e. =C2=A0<div><br></div><div>Prashant</div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Mon, May 1, 2017 at 10:04 PM, Prashant Murthy =
<span dir=3D"ltr">&lt;<a href=3D"mailto:pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org" target=3D"_=
blank">pmurthy-7yRcRoh4mDtoiYX5Tdu9fQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr">Hi all,=C2=A0<div><br></div><div>I was wonderin=
g what happens when reads are issued to an RBD device with no previously wr=
itten data. Can somebody explain how such requests flow from rbd (client) i=
nto OSDs and whether any of these reads would hit the disks at all or wheth=
er OSD metadata would recognize that there is no data at the offsets reques=
ted and returns a bunch of zeros back to the client? =C2=A0</div><div><br><=
/div><div>Thanks,</div><div>Prashant</div><span class=3D"m_5116591711045347=
817HOEnZb"><font color=3D"#888888"><div><div><br></div>-- <br><div class=3D=
"m_5116591711045347817m_-644972376694415374gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div>Prashant Murthy<br></div>Sr Director, S=
oftware Engineering | Salesforce<br>Mobile: <a href=3D"tel:(919)%20961-3041=
" value=3D"+19199613041" target=3D"_blank">919-961-3041</a></div><div dir=
=3D"ltr"><br></div><div><img src=3D"http://www.salesforce.com/common/assets=
/images/email/salesforce-email-signature.png" width=3D"200" height=3D"46"><=
br><font color=3D"#ffffff">--</font></div></div></div></div></div></div></d=
iv></div>
</div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_5116591711045347817gmail_signature" data-smartmail=3D"gmail_signature=
"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div di=
r=3D"ltr"><div>Prashant Murthy<br></div>Sr Director, Software Engineering |=
 Salesforce<br>Mobile: <a href=3D"tel:(919)%20961-3041" value=3D"+191996130=
41" target=3D"_blank">919-961-3041</a></div><div dir=3D"ltr"><br></div><div=
><img src=3D"http://www.salesforce.com/common/assets/images/email/salesforc=
e-email-signature.png" width=3D"200" height=3D"46"><br><font color=3D"#ffff=
ff">--</font></div></div></div></div></div></div></div></div>
</div></div>

--f403043c4bec125bf9054e8dd0e0--

--===============0370287558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0370287558==--
