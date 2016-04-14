From: Vincenzo Pii <vincenzo.pii-v8zYHBQrRMOHfbbb91w/0g@public.gmane.org>
Subject: Re: v10.1.2 Jewel release candidate release
Date: Thu, 14 Apr 2016 09:31:54 +0200
Message-ID: <A3CAA6F7-8759-4C19-9DA1-0C6D066A3A8E@teralytics.ch>
References: <alpine.DEB.2.11.1604131753570.31812@cpach.fuggernut.com>
	<CAJ4mKGa_APTdJzXR86_GjN141igBft=4JvY79EkS_ZkPbgcAVQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/mixed; boundary="===============0344005673=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGa_APTdJzXR86_GjN141igBft=4JvY79EkS_ZkPbgcAVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0344005673==
Content-Type: multipart/alternative; boundary="Apple-Mail=_EF3100BC-E678-446C-BC4B-5DA05B728419"


--Apple-Mail=_EF3100BC-E678-446C-BC4B-5DA05B728419
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 14 Apr 2016, at 00:09, Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> On Wed, Apr 13, 2016 at 3:02 PM, Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Hi everyone,
>>=20
>> The third (and likely final) Jewel release candidate is out.  We have =
a
>> very small number of remaining blocker issues and a bit of final =
polish
>> before we publish Jewel 10.2.0, probably next week.
>>=20
>> There are no known issues with this release that are serious enough =
to
>> warn about here.  Greg is adding some CephFS checks so that admins =
don't
>> accidentally start using less-stable features,
>=20
> s/is adding/has added/
>=20
>>        http://docs.ceph.com/docs/master/release-notes/
>=20
> As noted in another thread, there's still a big CephFS warning in the
> online docs. We'll be cleaning those up, since we now have the
> recovery tools we desire! Some things are known to still be slow or
> sub-optimal, but we consider CephFS stable and safe at this time when
> run in the default single-MDS configuration. (It won't let you do
> anything bad without very explicitly setting flags and acknowledging
> they're dangerous.)
> :)
> -Greg
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


Hi Greg,

A clarification:

When you say that things will be safe in =E2=80=9Csingle-MDS=E2=80=9D =
configuration, do you also exclude the HA setup with one active MDS and =
some passive (standby) ones? Or this would be safe as well?

Vincenzo Pii | TERALYTICS
DevOps Engineer

--Apple-Mail=_EF3100BC-E678-446C-BC4B-5DA05B728419
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 14 Apr 2016, at 00:09, Gregory Farnum &lt;<a =
href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">On Wed, Apr 13, 2016 at 3:02 PM, Sage Weil &lt;<a =
href=3D"mailto:sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Hi =
everyone,<br class=3D""><br class=3D"">The third (and likely final) =
Jewel release candidate is out. &nbsp;We have a<br class=3D"">very small =
number of remaining blocker issues and a bit of final polish<br =
class=3D"">before we publish Jewel 10.2.0, probably next week.<br =
class=3D""><br class=3D"">There are no known issues with this release =
that are serious enough to<br class=3D"">warn about here. &nbsp;Greg is =
adding some CephFS checks so that admins don't<br class=3D"">accidentally =
start using less-stable features,<br class=3D""></blockquote><br =
class=3D"">s/is adding/has added/<br class=3D""><br class=3D""><blockquote=
 type=3D"cite" class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a =
href=3D"http://docs.ceph.com/docs/master/release-notes/" =
class=3D"">http://docs.ceph.com/docs/master/release-notes/</a><br =
class=3D""></blockquote><br class=3D"">As noted in another thread, =
there's still a big CephFS warning in the<br class=3D"">online docs. =
We'll be cleaning those up, since we now have the<br class=3D"">recovery =
tools we desire! Some things are known to still be slow or<br =
class=3D"">sub-optimal, but we consider CephFS stable and safe at this =
time when<br class=3D"">run in the default single-MDS configuration. (It =
won't let you do<br class=3D"">anything bad without very explicitly =
setting flags and acknowledging<br class=3D"">they're dangerous.)<br =
class=3D"">:)<br class=3D"">-Greg<br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></div></div></blockquote></div><div class=3D""><br =
class=3D""></div><div class=3D"">Hi Greg,</div><div class=3D""><br =
class=3D""></div><div class=3D"">A clarification:</div><div class=3D""><br=
 class=3D""></div><div class=3D"">When you say that things will be safe =
in =E2=80=9Csingle-MDS=E2=80=9D configuration, do you also exclude the =
HA setup with one active MDS and some passive (standby) ones? Or this =
would be safe as well?</div><br class=3D""><div class=3D"">
<span style=3D"color: rgb(38, 127, 207);" class=3D"">Vincenzo =
Pii</span><span style=3D"color: rgb(78, 78, 78);" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>| TERA</span><span =
style=3D"color: rgb(38, 127, 207);" class=3D"">LYTICS</span><br =
class=3D""><b class=3D""><span style=3D"color: rgb(78, 78, 78);" =
class=3D"">DevOps Engineer</span></b>
</div>
<br class=3D""></body></html>=

--Apple-Mail=_EF3100BC-E678-446C-BC4B-5DA05B728419--

--===============0344005673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0344005673==--
