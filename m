From: Sherry Shahbazi <shoosah-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster is unreachable because of
	authentication	failure
Date: Sat, 18 Jan 2014 00:55:04 -0800 (PST)
Message-ID: <1390035304.76532.YahooMailNeo@web121101.mail.ne1.yahoo.com>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>
Reply-To: Sherry Shahbazi <shoosah-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1350326722=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1350326722==
Content-Type: multipart/alternative; boundary="-876742037-1124017723-1390035304=:76532"

---876742037-1124017723-1390035304=:76532
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guang, =0A=0ACan you check the privileges of ceph.conf and ceph.client.a=
dmin.keyring as they should look like the following:=0A=0A-rw-r--r-- 1 root=
 root 719 Jan 17 17:34 ceph.conf=0A-rw-r--r-- 1 root root 64 Jan 17 11:58 c=
eph.client.admin.keyring=0A=0ARegards=0ASherry=0A=0A=0A=0AOn Wednesday, Jan=
uary 15, 2014 1:57 AM, GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org> wrote:=0A =0AHi cep=
h-users and ceph-devel,=0AI came across an issue after restarting monitors =
of the cluster, that authentication fails which prevents running any ceph c=
ommand.=0A=0AAfter we did some maintenance work, I restart OSD, however, I =
found that the OSD would not join the cluster automatically after being res=
tarted, though TCP dump showed it had already sent messenger to monitor tel=
ling add me into the cluster.=0A=0ASo that I suspected there might be some =
issues of monitor and I restarted monitor one by one (3 in total), however,=
 after restarting monitors, all ceph command would fail saying authenticati=
on timeout=E2=80=A6=0A=0A2014-01-14 12:00:30.499397 7fc7f195e700=C2=A0 0 mo=
nclient(hunting): authenticate timed out after 300=0A2014-01-14 12:00:30.49=
9440 7fc7f195e700=C2=A0 0 librados: client.admin authentication error (110)=
 Connection timed out=0AError connecting to cluster: Error=0A=0AAny idea wh=
y such error happened (restarting OSD would result in the same error)?=0A=
=0AI am thinking the authentication information is persisted in mon local d=
isk and is there a chance those data got corrupted?=0A=0AThanks,=0AGuang=0A=
_______________________________________________=0Aceph-users mailing list=
=0Aceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=0Ahttp://lists.ceph.com/listinfo.cgi/ceph-user=
s-ceph.com
---876742037-1124017723-1390035304=:76532
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:14pt">Hi Guang, <br clear=3D"none"><br clear=3D"none">Can you check=
 the privileges of ceph.conf and ceph.client.admin.keyring as they should l=
ook like the following:<br clear=3D"none"><br clear=3D"none">-rw-r--r-- 1 r=
oot root 719 Jan 17 17:34 ceph.conf<br clear=3D"none">-rw-r--r-- 1 root roo=
t 64 Jan 17 11:58 ceph.client.admin.keyring<br clear=3D"none"><br clear=3D"=
none">Regards<br clear=3D"none">Sherry<div style=3D"display: block;" class=
=3D"yahoo_quoted"> <br> <br> <div style=3D"font-family: HelveticaNeue, Helv=
etica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 14pt;">=
 <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial=
, Lucida Grande, sans-serif; font-size: 12pt;"> <div dir=3D"ltr"> <font fac=
e=3D"Arial" size=3D"2"> On Wednesday, January 15, 2014 1:57 AM, GuangYang
 &lt;yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org&gt; wrote:<br> </font> </div>  <div class=3D"y_ms=
g_container">Hi ceph-users and ceph-devel,<br>I came across an issue after =
restarting monitors of the cluster, that authentication fails which prevent=
s running any ceph command.<br><br>After we did some maintenance work, I re=
start OSD, however, I found that the OSD would not join the cluster automat=
ically after being restarted, though TCP dump showed it had already sent me=
ssenger to monitor telling add me into the cluster.<br><br>So that I suspec=
ted there might be some issues of monitor and I restarted monitor one by on=
e (3 in total), however, after restarting monitors, all ceph command would =
fail saying authentication timeout=E2=80=A6<br><br>2014-01-14 12:00:30.4993=
97 7fc7f195e700&nbsp; 0 monclient(hunting): authenticate timed out after 30=
0<br>2014-01-14 12:00:30.499440 7fc7f195e700&nbsp; 0 librados: client.admin=
 authentication error (110) Connection timed out<br>Error connecting to
 cluster: Error<br><br>Any idea why such error happened (restarting OSD wou=
ld result in the same error)?<br><br>I am thinking the authentication infor=
mation is persisted in mon local disk and is there a chance those data got =
corrupted?<br><br>Thanks,<br>Guang<br>_____________________________________=
__________<br>ceph-users mailing list<br><a ymailto=3D"mailto:ceph-users@li=
sts.ceph.com" href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFI@public.gmane.org=
ph.com</a><br><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph=
.com" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.=
com</a><br><br></div>  </div> </div>  </div> </div></body></html>
---876742037-1124017723-1390035304=:76532--

--===============1350326722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1350326722==--
