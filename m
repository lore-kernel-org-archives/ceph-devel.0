From: <m13913886148-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: how to use cache tiering with proxy in ceph-10.2.2
Date: Mon, 18 Jul 2016 08:19:44 +0000 (UTC)
Message-ID: <314244505.918710.1468829984467.JavaMail.yahoo@mail.yahoo.com>
References: <314244505.918710.1468829984467.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: m13913886148-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0520391139=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0520391139==
Content-Type: multipart/alternative;
	boundary="----=_Part_918709_1815498648.1468829984465"

------=_Part_918709_1815498648.1468829984465
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hello cepher!=C2=A0 =C2=A0 I have a problem like this :=C2=A0 =C2=A0 I want=
 to config a cache tiering to my ceph with writeback mode.In ceph-0.94,it r=
uns ok. IO is First through hot-pool. then it flush to cold-pool.=C2=A0 =C2=
=A0 But in ceph-10.2.2,it doesn't like tihs. IO wrties to =C2=A0hot-pool an=
d cold-pool at the same time. I think it is be associated with "proxy".=C2=
=A0 =C2=A0 So how to config a cache tiering in ceph-10.2.2 to Improve IO pe=
rformance as much as possible ?=C2=A0 =C2=A0 how to use the proxy in cache =
tiering ?
------=_Part_918709_1815498648.1468829984465
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:16px"><div id=3D"yui_3_16_0_1_1468824049903_38014">hel=
lo cepher!</div><div id=3D"yui_3_16_0_1_1468824049903_38015">&nbsp; &nbsp; =
I have a problem like this :</div><div id=3D"yui_3_16_0_1_1468824049903_380=
16">&nbsp; &nbsp; I want to config a cache tiering to my ceph with writebac=
k mode.In ceph-0.94,it runs ok. IO is First through hot-pool. then it flush=
 to cold-pool.</div><div id=3D"yui_3_16_0_1_1468824049903_38017">&nbsp; &nb=
sp; But in ceph-10.2.2,it doesn't like tihs. IO wrties to &nbsp;hot-pool an=
d cold-pool at the same time. I think it is be associated with "proxy".</di=
v><div id=3D"yui_3_16_0_1_1468824049903_38018">&nbsp; &nbsp; So how to conf=
ig a cache tiering in ceph-10.2.2 to Improve IO performance as much as poss=
ible ?</div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1468824049903_38019">&nbsp;=
 &nbsp; how to use the proxy in cache tiering ?</div></div></body></html>
------=_Part_918709_1815498648.1468829984465--

--===============0520391139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0520391139==--
