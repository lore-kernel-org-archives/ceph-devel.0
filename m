From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph mgr balancer bad distribution
Date: Fri, 2 Mar 2018 10:12:20 +0100
Message-ID: <88BB07AB-D6C8-4106-953F-2131E56081BD@profihost.ag>
References: <1ac5678e-ec95-3ab6-38bf-bdb889e1cd23@profihost.ag>
 <b5d774be-a2e2-b57c-d201-b5df71868d49@profihost.ag>
 <CABZ+qqnQ+GrhRR7+9GmuzBA3STfwmtSzfMpSU2tPZWocMGHB8A@mail.gmail.com>
 <da7136f6-cc57-0b28-428c-ccaaef34dfa7@profihost.ag>
 <CABZ+qqmONpy74yXqr7e_zt_24aaxcFomPrwz0Mu2ncf0gYW3Ng@mail.gmail.com>
 <3b2c1d04-c7bd-1906-6239-b783e4fd585a@profihost.ag>
 <CABZ+qqkKVsdr+Tch=ZOrpzbbSdmWo-eOdCspWxCRSTnK=buEFQ@mail.gmail.com>
 <bea62c27-0faf-1b47-ca1e-9577e98ec6b1@profihost.ag>
 <CABZ+qqnRwQa8Jrg9=DPc5VnzqG4cjq0RvdhfFG74NgLMs_4EwQ@mail.gmail.com>
 <CABZ+qqmUPsiUDQV4kkHAWN0v=fCosaaHs0dGvXDaKUGKC7v9=g@mail.gmail.com>
 <CABZ+qqm-gMs9COEg2TVfNwEhVja8mGox00=0y5wQB7Z2QoSjSQ@mail.gmail.com>
 <3d244da6-25c2-b6d8-d4c2-a6a28b897509@profihost.ag>
 <CABZ+qq=xs5CYAXn55JEGbA4OSZayGdvbFnpwDz7AZDa0A0T2aQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============5026208734230892794=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qq=xs5CYAXn55JEGbA4OSZayGdvbFnpwDz7AZDa0A0T2aQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spandankumarsahu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============5026208734230892794==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-3FF82A1D-1285-4052-A89E-DEECF24DB287
Content-Transfer-Encoding: 7bit


--Apple-Mail-3FF82A1D-1285-4052-A89E-DEECF24DB287
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Thanks! Your patch works great! The only problem I still see is that the bal=
ancer kicks in even when the old optimize has not finished. It seems it only=
 evaluated the degraded of value. But while remapping it can happen that non=
e are degraded but a lot are still misplaced.

I think the balancer should evaluate the ceph health status as well.

Stefan

Excuse my typo sent from my mobile phone.

> Am 01.03.2018 um 13:12 schrieb Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>:
>=20
> On Thu, Mar 1, 2018 at 1:08 PM, Stefan Priebe - Profihost AG
> <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
>> nice thanks will try that soon.
>>=20
>> Can you tell me how to change the log lever to info for the balancer modu=
le?
>=20
> debug mgr =3D 4/5
>=20
> -- dan

--Apple-Mail-3FF82A1D-1285-4052-A89E-DEECF24DB287
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Thanks! Your patch works great! The only pr=
oblem I still see is that the balancer kicks in even when the old optimize h=
as not finished. It seems it only evaluated the degraded of value. But while=
 remapping it can happen that none are degraded but a lot are still misplace=
d.<div><br></div><div>I think the balancer should evaluate the ceph health s=
tatus as well.<br><br><div id=3D"AppleMailSignature">Stefan<div><br></div><d=
iv>Excuse my typo s<span style=3D"font-size: 13pt;">ent from my mobile phone=
.</span></div></div><div><br>Am 01.03.2018 um 13:12 schrieb Dan van der Ster=
 &lt;<a href=3D"mailto:dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org">dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org</a>&gt;:<br><b=
r></div><blockquote type=3D"cite"><div><span>On Thu, Mar 1, 2018 at 1:08 PM,=
 Stefan Priebe - Profihost AG</span><br><span>&lt;<a href=3D"mailto:s.priebe=
@profihost.ag">s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org</a>&gt; wrote:</span><br><blockquote ty=
pe=3D"cite"><span>nice thanks will try that soon.</span><br></blockquote><bl=
ockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cit=
e"><span>Can you tell me how to change the log lever to info for the balance=
r module?</span><br></blockquote><span></span><br><span>debug mgr =3D 4/5</s=
pan><br><span></span><br><span>-- dan</span><br></div></blockquote></div></b=
ody></html>=

--Apple-Mail-3FF82A1D-1285-4052-A89E-DEECF24DB287--

--===============5026208734230892794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5026208734230892794==--
