From: Rafael Lopez <rafael.lopez-sFFfwlTeHG43uPMLIKxrzw@public.gmane.org>
Subject: Re: who is using nfs-ganesha and cephfs?
Date: Thu, 16 Nov 2017 19:17:21 +1100
Message-ID: <CAGpUQW0guADd12HryXum9ZnB+VYorymimgtBurWRTwL2aQkKvQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711082140180.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2539640491085506555=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1711082140180.29217-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2539640491085506555==
Content-Type: multipart/alternative; boundary="001a1140a51cdb823f055e153f83"

--001a1140a51cdb823f055e153f83
Content-Type: text/plain; charset="UTF-8"

We are running RHCS2.3 (jewel) with ganesha 2.4.2 and cephfs fsal, compiled
from srpm. experimenting with CTDB for controlling ganesha HA since we run
samba on same servers.

Haven't done much functionality/stress testing but on face value basic
stuff seems to work well (file operations).

In terms of performance, last time I tested ganesha it seemed comparable to
ceph-fuse (RHCS2.x/jewel, i think luminous ceph-fuse is better). Though I
haven't done rigorous metadata tests or multiple client tests. Also our
ganesha servers are quite small, as we are thus far only serving cephfs
natively. eg 4G ram 1 core. Here are some FIO results:

jobs in order are:
1. async 1M
2. sync 1M
3. async 4k
4. sync 4k
5. seq read 1M
6. rand read 4k

Ceph cluster is RHCS 2.3 (10.2.7)

CEPH-FUSE (10.2.x)
  WRITE: io=143652MB, aggrb=490328KB/s, minb=490328KB/s, maxb=490328KB/s,
mint=300002msec, maxt=300002msec
  WRITE: io=14341MB, aggrb=48947KB/s, minb=48947KB/s, maxb=48947KB/s,
mint=300018msec, maxt=300018msec
  WRITE: io=9808.2MB, aggrb=33478KB/s, minb=33478KB/s, maxb=33478KB/s,
mint=300001msec, maxt=300001msec
  WRITE: io=424476KB, aggrb=1414KB/s, minb=1414KB/s, maxb=1414KB/s,
mint=300003msec, maxt=300003ms
   READ: io=158069MB, aggrb=539527KB/s, minb=539527KB/s, maxb=539527KB/s,
mint=300008msec, maxt=300008msec
   READ: io=1881.2MB, aggrb=6420KB/s, minb=6420KB/s, maxb=6420KB/s,
mint=300001msec, maxt=300001msec

ganesha (nfs3)
  WRITE: io=157891MB, aggrb=538923KB/s, minb=538923KB/s, maxb=538923KB/s,
mint=300006msec, maxt=300006msec
  WRITE: io=38700MB, aggrb=132093KB/s, minb=132093KB/s, maxb=132093KB/s,
mint=300006msec, maxt=300006msec
  WRITE: io=3072.0MB, aggrb=10148KB/s, minb=10148KB/s, maxb=10148KB/s,
mint=309957msec, maxt=309957msec
  WRITE: io=397516KB, aggrb=1325KB/s, minb=1325KB/s, maxb=1325KB/s,
mint=300001msec, maxt=300001msec
   READ: io=82521MB, aggrb=281669KB/s, minb=281669KB/s, maxb=281669KB/s,
mint=300002msec, maxt=300002msec
   READ: io=1322.2MB, aggrb=4513KB/s, minb=4513KB/s, maxb=4513KB/s,
mint=300001msec, maxt=300001msec

cephfs kernel client
  WRITE: io=471041MB, aggrb=1568.8MB/s, minb=1568.8MB/s, maxb=1568.8MB/s,
mint=300394msec, maxt=300394msec
  WRITE: io=50005MB, aggrb=170680KB/s, minb=170680KB/s, maxb=170680KB/s,
mint=300006msec, maxt=300006msec
  WRITE: io=169092MB, aggrb=577166KB/s, minb=577166KB/s, maxb=577166KB/s,
mint=300000msec, maxt=300000msec
  WRITE: io=530548KB, aggrb=1768KB/s, minb=1768KB/s, maxb=1768KB/s,
mint=300003msec, maxt=300003msec
   READ: io=121501MB, aggrb=414720KB/s, minb=414720KB/s, maxb=414720KB/s,
mint=300002msec, maxt=300002msec
   READ: io=3264.6MB, aggrb=11142KB/s, minb=11142KB/s, maxb=11142KB/s,
mint=300001msec, maxt=300001msec

happy to share fio job file if anyone wants it.


On 9 November 2017 at 08:41, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Who is running nfs-ganesha's FSAL to export CephFS?  What has your
> experience been?
>
> (We are working on building proper testing and support for this into
> Mimic, but the ganesha FSAL has been around for years.)
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
*Rafael Lopez*
Research Devops Engineer
Monash University eResearch Centre

T: +61 3 9905 9118
M: +61 (0)427682670 <%2B61%204%2027682%20670>
E: rafael.lopez-sFFfwlTeHG43uPMLIKxrzw@public.gmane.org

--001a1140a51cdb823f055e153f83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We are running RHCS2.3 (jewel) with ganesha 2.4.2 and=
 cephfs fsal, compiled from srpm. experimenting with CTDB for controlling g=
anesha HA since we run samba on same servers.</div><div><br></div><div>Have=
n&#39;t done much functionality/stress testing but on face value basic stuf=
f seems to work well (file operations).</div><div><br></div><div>In terms o=
f performance, last time I tested ganesha it seemed comparable to ceph-fuse=
 (RHCS2.x/jewel, i think luminous ceph-fuse is better). Though I haven&#39;=
t done rigorous metadata tests or multiple client tests. Also our ganesha s=
ervers are quite small, as we are thus far only serving cephfs natively. eg=
 4G ram 1 core. Here are some FIO results:</div><div><br></div><div>jobs in=
 order are:</div><div>1. async 1M</div><div>2. sync 1M</div><div>3. async 4=
k</div><div>4. sync 4k</div><div>5. seq read 1M</div><div>6. rand read 4k</=
div><div><br></div><div>Ceph cluster is RHCS 2.3 (10.2.7)</div><div><br></d=
iv><div>CEPH-FUSE (10.2.x)</div><div>=C2=A0 WRITE: io=3D143652MB, aggrb=3D4=
90328KB/s, minb=3D490328KB/s, maxb=3D490328KB/s, mint=3D300002msec, maxt=3D=
300002msec</div><div>=C2=A0 WRITE: io=3D14341MB, aggrb=3D48947KB/s, minb=3D=
48947KB/s, maxb=3D48947KB/s, mint=3D300018msec, maxt=3D300018msec</div><div=
>=C2=A0 WRITE: io=3D9808.2MB, aggrb=3D33478KB/s, minb=3D33478KB/s, maxb=3D3=
3478KB/s, mint=3D300001msec, maxt=3D300001msec</div><div>=C2=A0 WRITE: io=
=3D424476KB, aggrb=3D1414KB/s, minb=3D1414KB/s, maxb=3D1414KB/s, mint=3D300=
003msec, maxt=3D300003ms</div><div>=C2=A0 =C2=A0READ: io=3D158069MB, aggrb=
=3D539527KB/s, minb=3D539527KB/s, maxb=3D539527KB/s, mint=3D300008msec, max=
t=3D300008msec</div><div>=C2=A0 =C2=A0READ: io=3D1881.2MB, aggrb=3D6420KB/s=
, minb=3D6420KB/s, maxb=3D6420KB/s, mint=3D300001msec, maxt=3D300001msec</d=
iv><div><br></div><div>ganesha (nfs3)</div><div>=C2=A0 WRITE: io=3D157891MB=
, aggrb=3D538923KB/s, minb=3D538923KB/s, maxb=3D538923KB/s, mint=3D300006ms=
ec, maxt=3D300006msec</div><div>=C2=A0 WRITE: io=3D38700MB, aggrb=3D132093K=
B/s, minb=3D132093KB/s, maxb=3D132093KB/s, mint=3D300006msec, maxt=3D300006=
msec</div><div>=C2=A0 WRITE: io=3D3072.0MB, aggrb=3D10148KB/s, minb=3D10148=
KB/s, maxb=3D10148KB/s, mint=3D309957msec, maxt=3D309957msec</div><div>=C2=
=A0 WRITE: io=3D397516KB, aggrb=3D1325KB/s, minb=3D1325KB/s, maxb=3D1325KB/=
s, mint=3D300001msec, maxt=3D300001msec</div><div>=C2=A0 =C2=A0READ: io=3D8=
2521MB, aggrb=3D281669KB/s, minb=3D281669KB/s, maxb=3D281669KB/s, mint=3D30=
0002msec, maxt=3D300002msec</div><div>=C2=A0 =C2=A0READ: io=3D1322.2MB, agg=
rb=3D4513KB/s, minb=3D4513KB/s, maxb=3D4513KB/s, mint=3D300001msec, maxt=3D=
300001msec</div><div><br></div><div>cephfs kernel client</div><div>=C2=A0 W=
RITE: io=3D471041MB, aggrb=3D1568.8MB/s, minb=3D1568.8MB/s, maxb=3D1568.8MB=
/s, mint=3D300394msec, maxt=3D300394msec</div><div>=C2=A0 WRITE: io=3D50005=
MB, aggrb=3D170680KB/s, minb=3D170680KB/s, maxb=3D170680KB/s, mint=3D300006=
msec, maxt=3D300006msec</div><div>=C2=A0 WRITE: io=3D169092MB, aggrb=3D5771=
66KB/s, minb=3D577166KB/s, maxb=3D577166KB/s, mint=3D300000msec, maxt=3D300=
000msec</div><div>=C2=A0 WRITE: io=3D530548KB, aggrb=3D1768KB/s, minb=3D176=
8KB/s, maxb=3D1768KB/s, mint=3D300003msec, maxt=3D300003msec</div><div>=C2=
=A0 =C2=A0READ: io=3D121501MB, aggrb=3D414720KB/s, minb=3D414720KB/s, maxb=
=3D414720KB/s, mint=3D300002msec, maxt=3D300002msec</div><div>=C2=A0 =C2=A0=
READ: io=3D3264.6MB, aggrb=3D11142KB/s, minb=3D11142KB/s, maxb=3D11142KB/s,=
 mint=3D300001msec, maxt=3D300001msec</div><div><br></div><div>happy to sha=
re fio job file if anyone wants it.=C2=A0</div><div><br></div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On 9 November 2017 at 08=
:41, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" ta=
rget=3D"_blank">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Who is running nfs-ganesha&#39;s FSAL to export CephFS?=C2=A0=
 What has your<br>
experience been?<br>
<br>
(We are working on building proper testing and support for this into<br>
Mimic, but the ganesha FSAL has been around for years.)<br>
<br>
Thanks!<br>
sage<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div d=
ir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><div dir=3D"ltr"><div><div style=3D"font-size:12.8px">=
<b style=3D"font-size:12.8px"><font face=3D"arial, helvetica, sans-serif">R=
afael Lopez</font></b><br></div></div><div><font face=3D"arial, helvetica, =
sans-serif">Research Devops Engineer<br></font><div style=3D"font-size:12.8=
px"><font face=3D"arial, helvetica, sans-serif">Monash University eResearch=
 Centre</font></div><div style=3D"font-size:12.8px"><font face=3D"arial, he=
lvetica, sans-serif"><br></font></div><font face=3D"arial, helvetica, sans-=
serif"><span style=3D"font-size:12.8px">T:=C2=A0</span><a href=3D"tel:%2B61=
%203%209905%209118" value=3D"+61399059214" style=3D"color:rgb(17,85,204);fo=
nt-size:12.8px" target=3D"_blank">+61 3 9905 9118</a><br style=3D"font-size=
:12.8px"><span style=3D"font-size:12.8px">M:=C2=A0</span><a href=3D"tel:%2B=
61%204%2027682%20670" value=3D"+61399059214" style=3D"font-size:12.8px;colo=
r:rgb(17,85,204)" target=3D"_blank">+61 (0)427682670</a><br style=3D"font-s=
ize:12.8px"><span style=3D"font-size:12.8px">E:=C2=A0</span><a href=3D"mail=
to:rafael.lopez-sFFfwlTeHG43uPMLIKxrzw@public.gmane.org" style=3D"color:rgb(17,85,204);font-size:12.8px"=
 target=3D"_blank">rafael.lopez-sFFfwlTeHG43uPMLIKxrzw@public.gmane.org</a><br style=3D"font-size:12.8px=
"></font><div><div><br></div></div></div></div></div></div></div></div></di=
v></div></div></div></div></div></div></div></div></div></div>
</div>

--001a1140a51cdb823f055e153f83--

--===============2539640491085506555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2539640491085506555==--
