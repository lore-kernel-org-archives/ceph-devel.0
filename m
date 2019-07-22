From: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Failed to get omap key when mirroring of image is
 enabled
Date: Mon, 22 Jul 2019 05:55:31 +0530
Message-ID: <CAEbG6hHOe0Q8-dcgBxbW2GX+21BuETso9orZY-9sW37Y5rDwKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3035034521777127450=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============3035034521777127450==
Content-Type: multipart/alternative; boundary="000000000000d3aa43058e3a1dca"

--000000000000d3aa43058e3a1dca
Content-Type: text/plain; charset="UTF-8"

 I have a rbd mirroring setup with primary and secondary clusters as peers
and I have a pool enabled image mode.., In this i created a rbd image ,
enabled with journaling.

But whenever i enable mirroring on the image,  I m getting error in
osd.log. I couldnt trace it out. please guide me to solve this error.
I think initially it worked fine. but after ceph process restart. these
error coming


Secondary.osd.0.log

2019-07-22 05:36:17.371771 7ffbaa0e9700  0 <cls>
/build/ceph-12.2.12/src/cls/journal/cls_journal.cc:61: failed to get omap
key: client_a5c76849-ba16-480a-a96b-ebfdb7f6ac65
2019-07-22 05:36:17.388552 7ffbaa0e9700  0 <cls>
/build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set
earlier than minimum: 0 < 1
2019-07-22 05:36:17.413102 7ffbaa0e9700  0 <cls>
/build/ceph-12.2.12/src/cls/journal/cls_journal.cc:61: failed to get omap
key: order
2019-07-22 05:36:23.341490 7ffbab8ec700  0 <cls>
/build/ceph-12.2.12/src/cls/rbd/cls_rbd.cc:4125: error retrieving image id
for global id '9e36b9f8-238e-4a54-a055-19b19447855e': (2) No such file or
directory


primary-osd.0.log

2019-07-22 05:16:49.287769 7fae12db1700  0 log_channel(cluster) log [DBG] :
1.b deep-scrub ok
2019-07-22 05:16:54.078698 7fae125b0700  0 log_channel(cluster) log [DBG] :
1.1b scrub starts
2019-07-22 05:16:54.293839 7fae125b0700  0 log_channel(cluster) log [DBG] :
1.1b scrub ok
2019-07-22 05:17:04.055277 7fae12db1700  0 <cls>
/build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set
earlier than minimum: 0 < 1

2019-07-22 05:33:21.540986 7fae135b2700  0 <cls>
/build/ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set
earlier than minimum: 0 < 1
2019-07-22 05:35:27.447820 7fae12db1700  0 <cls>
/build/ceph-12.2.12/src/cls/rbd/cls_rbd.cc:4125: error retrieving image id
for global id '8a61f694-f650-4ba1-b768-c5e7629ad2e0': (2) No such file or
directory


-- 


*Regards,Ajitha R*

--000000000000d3aa43058e3a1dca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p dir=3D"ltr" style=3D"font-family:sans-serif">=C2=
=A0I have a rbd mirroring=20
setup with primary and secondary clusters as peers and I have a pool enable=
d=20
image mode.., In this i created a rbd image , enabled with journaling.</p><=
p dir=3D"ltr" style=3D"font-family:sans-serif">But whenever i enable mirror=
ing on the image,=C2=A0 I m getting error in osd.log. I couldnt trace it ou=
t. please guide me to solve this error.<br></p></div><div>I think initially=
 it worked fine. but after ceph process restart. these error coming <br></d=
iv><div><br></div><div><br></div><div>Secondary.osd.0.log</div><div><br></d=
iv><div>2019-07-22 05:36:17.371771 7ffbaa0e9700 =C2=A00 &lt;cls&gt; /build/=
ceph-12.2.12/src/cls/journal/cls_journal.cc:61: failed to get omap key: cli=
ent_a5c76849-ba16-480a-a96b-ebfdb7f6ac65</div>2019-07-22 05:36:17.388552 7f=
fbaa0e9700 =C2=A00 &lt;cls&gt; /build/ceph-12.2.12/src/cls/journal/cls_jour=
nal.cc:472: active object set earlier than minimum: 0 &lt; 1<br>2019-07-22 =
05:36:17.413102 7ffbaa0e9700 =C2=A00 &lt;cls&gt; /build/ceph-12.2.12/src/cl=
s/journal/cls_journal.cc:61: failed to get omap key: order<br>2019-07-22 05=
:36:23.341490 7ffbab8ec700 =C2=A00 &lt;cls&gt; /build/ceph-12.2.12/src/cls/=
rbd/cls_rbd.cc:4125: error retrieving image id for global id &#39;9e36b9f8-=
238e-4a54-a055-19b19447855e&#39;: (2) No such file or directory<br><br><div=
><br></div><div>primary-osd.0.log</div><div><br></div><div>2019-07-22 05:16=
:49.287769 7fae12db1700 =C2=A00 log_channel(cluster) log [DBG] : 1.b deep-s=
crub ok<br>2019-07-22 05:16:54.078698 7fae125b0700 =C2=A00 log_channel(clus=
ter) log [DBG] : 1.1b scrub starts<br>2019-07-22 05:16:54.293839 7fae125b07=
00 =C2=A00 log_channel(cluster) log [DBG] : 1.1b scrub ok<br>2019-07-22 05:=
17:04.055277 7fae12db1700 =C2=A00 &lt;cls&gt; /build/ceph-12.2.12/src/cls/j=
ournal/cls_journal.cc:472: active object set earlier than minimum: 0 &lt; 1=
<br><br>2019-07-22 05:33:21.540986 7fae135b2700 =C2=A00 &lt;cls&gt; /build/=
ceph-12.2.12/src/cls/journal/cls_journal.cc:472: active object set earlier =
than minimum: 0 &lt; 1<br>2019-07-22 05:35:27.447820 7fae12db1700 =C2=A00 &=
lt;cls&gt; /build/ceph-12.2.12/src/cls/rbd/cls_rbd.cc:4125: error retrievin=
g image id for global id &#39;8a61f694-f650-4ba1-b768-c5e7629ad2e0&#39;: (2=
) No such file or directory<br><br></div><br>-- <br><div dir=3D"ltr" class=
=3D"m_-7686208623902720713gmail_signature" data-smartmail=3D"gmail_signatur=
e"><div dir=3D"ltr"><b><i style=3D"background-color:rgb(255,255,255);color:=
rgb(102,0,0)">Regards,<span></span><br>Ajitha R</i><br></b></div></div></di=
v>

--000000000000d3aa43058e3a1dca--

--===============3035034521777127450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3035034521777127450==--
