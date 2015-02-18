From: Andrei Mikhailovsky <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance	comparison
Date: Wed, 18 Feb 2015 15:08:22 +0000 (GMT)
Message-ID: <413428.1082.1424272098009.JavaMail.andrei@tuchka>
References: <54E37C3D.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476364152=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54E37C3D.5030702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1476364152==
Content-Type: multipart/alternative;
	boundary="----=_Part_1081_31811550.1424272098008"

------=_Part_1081_31811550.1424272098008
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Mark, many thanks for your effort and ceph performance tests. This puts things in perspective. 

Looking at the results, I was a bit concerned that the IOPs performance in niether releases come even marginally close to the capabilities of the underlying ssd device. Even the fastest PCI ssds have only managed to achieve about the 1/6th IOPs of the raw device. 

I guess there is a great deal more optimisations to be done in the upcoming LTS releases to make the IOPs rate close to the raw device performance. 

I have done some testing in the past and noticed that despite the server having a lot of unused resources (about 40-50% server idle and about 60-70% ssd idle) the ceph would not perform well when used with ssds. I was testing with Firefly + auth and my IOPs rate was around the 3K mark. Something is holding ceph back from performing well with ssds ((( 

Andrei 

----- Original Message -----

> From: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> To: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Sent: Tuesday, 17 February, 2015 5:37:01 PM
> Subject: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
> performance comparison

> Hi All,

> I wrote up a short document describing some tests I ran recently to
> look
> at how SSD backed OSD performance has changed across our LTS
> releases.
> This is just looking at RADOS performance and not RBD or RGW. It also
> doesn't offer any real explanations regarding the results. It's just
> a
> first high level step toward understanding some of the behaviors
> folks
> on the mailing list have reported over the last couple of releases. I
> hope you find it useful.

> Mark

> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

------=_Part_1081_31811550.1424272098008
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: arial,helvetica,sans-serif; font-size: 10pt; colo=
r: #000000'><br><div><span name=3D"x"></span>Mark, many thanks for your eff=
ort and ceph performance tests. This puts things in perspective.<br><br>Loo=
king at the results, I was a bit concerned that the IOPs performance in nie=
ther releases come even marginally close to the capabilities of the underly=
ing ssd device. Even the fastest PCI ssds have only managed to achieve abou=
t the 1/6th IOPs of the raw device. <br><br>I guess there is a great deal m=
ore optimisations to be done in the upcoming LTS releases to make the IOPs =
rate close to the raw device performance.<br><br>I have done some testing i=
n the past and noticed that despite the server having a lot of unused resou=
rces (about 40-50% server idle and about 60-70% ssd idle) the ceph would no=
t perform well when used with ssds. I was testing with Firefly + auth and m=
y IOPs rate was around the 3K mark. Something is holding ceph back from per=
forming well with ssds (((<br><br>Andrei<br></div><br><hr id=3D"zwchr"><blo=
ckquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px;=
 padding-left: 5px; color: rgb(0, 0, 0); font-weight: normal; font-style: n=
ormal; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font=
-size: 12pt;"><b>From: </b>"Mark Nelson" &lt;mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br><b>T=
o: </b>"ceph-devel" &lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br><b>Cc: </b>ceph-u=
sers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br><b>Sent: </b>Tuesday, 17 February, 2015 5:37:01 PM<b=
r><b>Subject: </b>[ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore pe=
rformance&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;comparison<br><br>=
Hi All,<br><br>I wrote up a short document describing some tests I ran rece=
ntly to look <br>at how SSD backed OSD performance has changed across our L=
TS releases. <br>This is just looking at RADOS performance and not RBD or R=
GW. &nbsp;It also <br>doesn't offer any real explanations regarding the res=
ults. &nbsp;It's just a <br>first high level step toward understanding some=
 of the behaviors folks <br>on the mailing list have reported over the last=
 couple of releases. &nbsp;I <br>hope you find it useful.<br><br>Mark<br><b=
r>_______________________________________________<br>ceph-users mailing lis=
t<br>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com<br></blockquote><br></div></body></html>
------=_Part_1081_31811550.1424272098008--

--===============1476364152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1476364152==--
