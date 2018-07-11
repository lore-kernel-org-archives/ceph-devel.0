From: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>
Subject: Re: Luminous 12.2.6 release date?
Date: Wed, 11 Jul 2018 23:29:26 +0000
Message-ID: <ME1PR01MB0449045DA21D0F419E3C69A7815A0@ME1PR01MB0449.ausprd01.prod.outlook.com>
References: <20180710080734.GG14320@PC-198>
 <CABZ+qq=zF-EfytsGr=FJCx8u3Q6jKwviE70onHWGdHi8ysxxWw@mail.gmail.com>
 <alpine.DEB.2.11.1807111458550.15696@piezo.novalocal>
 <CALqRxCwvbNA5YyBtMck399U2Wwa5rs-y7gwVj99wZt9sWmgtaw@mail.gmail.com>,
 <alpine.DEB.2.11.1807111747410.15688@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7880299900444267600=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1807111747410.15688-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
Content-Language: en-AU
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7880299900444267600==
Content-Language: en-AU
Content-Type: multipart/alternative;
	boundary="_000_ME1PR01MB0449045DA21D0F419E3C69A7815A0ME1PR01MB0449ausp_"

--_000_ME1PR01MB0449045DA21D0F419E3C69A7815A0ME1PR01MB0449ausp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Going by http://tracker.ceph.com/issues/24597, does this only affect FileSt=
ore OSDs or are BlueStore ones affected too?


Cheers,

Linh

________________________________
From: ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Sage Weil=
 <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Sent: Thursday, 12 July 2018 3:48:10 AM
To: Ken Dreyer
Cc: ceph-users; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [ceph-users] Luminous 12.2.6 release date?

On Wed, 11 Jul 2018, Ken Dreyer wrote:
> Sage, does http://tracker.ceph.com/issues/24597<http://tracker.ceph.com/i=
ssues/24597> cover the full problem
> you're describing?

Yeah. I've added some detail to that bug. Working on fixing our rados
test suite to reproduce the issue.

sage


>
> - Ken
>
> On Wed, Jul 11, 2018 at 9:40 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > Please hold off on upgrading. We discovered a regression (in 12.2.5
> > actually) but the triggering event is OSD restarts or other peering
> > combined with RGW workloads on EC pools, so unnecessary OSD restarts
> > should be avoided with 12.2.5 until we have is sorted out.
> >
> > sage
> >
> >
> > On Wed, 11 Jul 2018, Dan van der Ster wrote:
> >
> >> And voila, I see the 12.2.6 rpms were released overnight.
> >>
> >> Waiting here for an announcement before upgrading.
> >>
> >> -- dan
> >>
> >> On Tue, Jul 10, 2018 at 10:08 AM Sean Purdy <s.purdy-jbg8n7S37wnmujpSeSYe3g@public.gmane.org>=
 wrote:
> >> >
> >> > While we're at it, is there a release date for 12.2.6? It fixes a re=
shard/versioning bug for us.
> >> >
> >> > Sean
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<http://lists.=
ceph.com/listinfo.cgi/ceph-users-ceph.com>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<http://lists.ce=
ph.com/listinfo.cgi/ceph-users-ceph.com>
> >>
> >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<http://lists.cep=
h.com/listinfo.cgi/ceph-users-ceph.com>
>
>
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<http://lists.ceph.co=
m/listinfo.cgi/ceph-users-ceph.com>

--_000_ME1PR01MB0449045DA21D0F419E3C69A7815A0ME1PR01MB0449ausp_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Going by&nbsp;<a href=3D"http://t=
racker.ceph.com/issues/24597" class=3D"OWAAutoLink" id=3D"LPlnk372133" prev=
iewremoved=3D"true">http://tracker.ceph.com/issues/24597</a>, does this onl=
y affect FileStore OSDs or are BlueStore ones affected
 too?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Cheers,</p>
<p style=3D"margin-top:0;margin-bottom:0">Linh</p>
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ceph-users &lt;ceph-u=
sers-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&gt; on behalf of Sage Weil &lt;sage-BnTBU8nroG6DGRHsOpWV0g@public.gmane.org=
t&gt;<br>
<b>Sent:</b> Thursday, 12 July 2018 3:48:10 AM<br>
<b>To:</b> Ken Dreyer<br>
<b>Cc:</b> ceph-users; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> Re: [ceph-users] Luminous 12.2.6 release date?</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div>On Wed, 11 Jul 2018, Ken Dreyer wrote:<br>
&gt; Sage, does <a href=3D"http://tracker.ceph.com/issues/24597">
http://tracker.ceph.com/issues/24597</a> cover the full problem<br>
&gt; you're describing?<br>
<br>
Yeah. I've added some detail to that bug. Working on fixing our rados <br>
test suite to reproduce the issue.<br>
<br>
sage<br>
<br>
<br>
&gt; <br>
&gt; - Ken<br>
&gt; <br>
&gt; On Wed, Jul 11, 2018 at 9:40 AM, Sage Weil &lt;sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org&gt; w=
rote:<br>
&gt; &gt; Please hold off on upgrading. We discovered a regression (in 12.2=
.5<br>
&gt; &gt; actually) but the triggering event is OSD restarts or other peeri=
ng<br>
&gt; &gt; combined with RGW workloads on EC pools, so unnecessary OSD resta=
rts<br>
&gt; &gt; should be avoided with 12.2.5 until we have is sorted out.<br>
&gt; &gt;<br>
&gt; &gt; sage<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Wed, 11 Jul 2018, Dan van der Ster wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; And voila, I see the 12.2.6 rpms were released overnight.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Waiting here for an announcement before upgrading.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -- dan<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Tue, Jul 10, 2018 at 10:08 AM Sean Purdy &lt;s.purdy@cv-li=
brary.co.uk&gt; wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; While we're at it, is there a release date for 12.2.6? I=
t fixes a reshard/versioning bug for us.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Sean<br>
&gt; &gt;&gt; &gt; _______________________________________________<br>
&gt; &gt;&gt; &gt; ceph-users mailing list<br>
&gt; &gt;&gt; &gt; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
&gt; &gt;&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com">
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; ceph-users mailing list<br>
&gt; &gt;&gt; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
&gt; &gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph=
.com">
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; ceph-users mailing list<br>
&gt; &gt; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=
">
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt; <br>
&gt; <br>
_______________________________________________<br>
ceph-users mailing list<br>
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://l=
ists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div>
</body>
</html>

--_000_ME1PR01MB0449045DA21D0F419E3C69A7815A0ME1PR01MB0449ausp_--


--===============7880299900444267600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7880299900444267600==--
