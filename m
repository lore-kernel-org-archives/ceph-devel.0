From: =?utf-8?Q?Steffen_W_S=C3=B8rensen?= <stefws-BUHhN+a2lJ4@public.gmane.org>
Subject: Re: [ceph-calamari] Does anyone understand Calamari??
Date: Wed, 13 May 2015 11:23:40 +0200
Message-ID: <666078A3-277A-4442-B2E4-29774B8470BB@me.com>
References: <7E8CF9C16F722345A89076330719CB1F4A82525D@EXMAIL1.taec.toshiba.com>
	<607C9580-DF69-4CA0-9D65-550700893CA8@redhat.com>
	<7E8CF9C16F722345A89076330719CB1F4A825343@EXMAIL1.taec.toshiba.com>
	<95DFDC74-A336-46C4-B72E-24E9747CDD6F@redhat.com>
	<7E8CF9C16F722345A89076330719CB1F4A8253D3@EXMAIL1.taec.toshiba.com>
	<D363AFC4-84C1-42EB-A5F0-792A88B685C4@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: multipart/mixed; boundary="===============0356627726=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-reply-to: <D363AFC4-84C1-42EB-A5F0-792A88B685C4-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel (ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0356627726==
Content-type: multipart/alternative;
 boundary="Apple-Mail=_C33E1206-9E45-4731-B64D-C7BEC302A59C"


--Apple-Mail=_C33E1206-9E45-4731-B64D-C7BEC302A59C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 13/05/2015, at 04.08, Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> Ideally I would like everything in /var/log/calmari
>=20
> be sure to set calamari.conf like so:
> [shadow_man@vpm107 ~]$ grep DEBUG /etc/calamari/calamari.conf=20
> log_level =3D DEBUG
> db_log_level =3D DEBUG
> log_level =3D DEBUG
>=20
> then restart cthulhu and apache
>=20
> visit http://essperf3/api/v2/cluster
> and http://essperf3
>=20
> and then share the logs here. Hopefully something obvious will be off =
in either calamari or cthulhu log

Since I got similar issue, I sneak my log data in here as well, no =
offence=E2=80=A6

-rw-r--r-- 1 www-data www-data   1554 May 13 11:14 info.log
-rw-r--r-- 1 root     root      29311 May 13 11:14 httpd_error.log
-rw-r--r-- 1 root     root       4599 May 13 11:14 httpd_access.log
-rw-r--r-- 1 www-data www-data    739 May 13 11:14 calamari.log
-rw-r--r-- 1 root     root     238047 May 13 11:14 cthulhu.log

root@node1:/var/log/calamari# cat calamari.log
2015-05-13 04:05:40,787 - metric_access - django.request Not Found: =
/favicon.ico
2015-05-13 04:14:02,263 - DEBUG - django.request.profile =
[17.5249576569ms] /api/v2/cluster
2015-05-13 04:14:02,263 - DEBUG - django.request.profile RPC timing for =
'list_clusters': 3.89504432678/3.89504432678/3.89504432678 avg/min/max =
ms
2015-05-13 04:14:02,263 - DEBUG - django.request.profile Total time in =
RPC: 3.89504432678ms
2015-05-13 04:14:06,172 - DEBUG - django.request.profile =
[15.8069133759ms] /api/v2/cluster
2015-05-13 04:14:06,173 - DEBUG - django.request.profile RPC timing for =
'list_clusters': 2.44808197021/2.44808197021/2.44808197021 avg/min/max =
ms
2015-05-13 04:14:06,173 - DEBUG - django.request.profile Total time in =
RPC: 2.44808197021ms

root@node1:/var/log/calamari# tail cthulhu.log
2015-05-13 11:14:46,694 - DEBUG - cthulhu nivcsw: 102
2015-05-13 11:14:46,709 - DEBUG - cthulhu Eventer.on_tick
2015-05-13 11:14:46,710 - INFO - cthulhu Eventer._emit: 2015-05-13 =
09:14:46.710030+00:00/WARNING/Cluster 'ceph' is late reporting in
2015-05-13 11:14:46,710 - INFO - sqlalchemy.engine.base.Engine BEGIN =
(implicit)
2015-05-13 11:14:46,711 - INFO - sqlalchemy.engine.base.Engine INSERT =
INTO cthulhu_event ("when", severity, message, fsid, fqdn, service_type, =
service_id) VALUES (%(when)s, %(severity)s, %(message)s, %(fsid)s, =
%(fqdn)s, %(service_type)s, %(service_id)s) RETURNING cthulhu_event.id
2015-05-13 11:14:46,711 - INFO - sqlalchemy.engine.base.Engine =
{'severity': 3, 'when': datetime.datetime(2015, 5, 13, 9, 14, 46, =
710030, tzinfo=3Dtzutc()), 'fqdn': None, 'service_type': None, =
'service_id': None, 'message': "Cluster 'ceph' is late reporting in", =
'fsid': u'16fe2dcf-2629-422f-a649-871deba78bcd'}
2015-05-13 11:14:46,713 - DEBUG - sqlalchemy.engine.base.Engine Col =
('id',)
2015-05-13 11:14:46,714 - DEBUG - sqlalchemy.engine.base.Engine Row =
(54,)
2015-05-13 11:14:46,714 - INFO - sqlalchemy.engine.base.Engine COMMIT
2015-05-13 11:14:56,710 - DEBUG - cthulhu Eventer.on_tick

root@node1:/var/log/calamari# tail httpd_error.log
[Wed May 13 04:14:05 2015] [warn]   File =
"/usr/lib/python2.7/dist-packages/git/__init__.py", line 20, in =
_init_externals
[Wed May 13 04:14:05 2015] [warn]     import gitdb
[Wed May 13 04:14:05 2015] [warn]   File =
"/usr/lib/python2.7/dist-packages/gitdb/__init__.py", line 25, in =
<module>
[Wed May 13 04:14:05 2015] [warn]     _init_externals()
[Wed May 13 04:14:05 2015] [warn]   File =
"/usr/lib/python2.7/dist-packages/gitdb/__init__.py", line 17, in =
_init_externals
[Wed May 13 04:14:05 2015] [warn]     __import__(module)
[Wed May 13 04:14:05 2015] [warn]   File =
"/usr/lib/python2.7/dist-packages/async/__init__.py", line 36, in =
<module>
[Wed May 13 04:14:05 2015] [warn]     _init_signals()
[Wed May 13 04:14:05 2015] [warn]   File =
"/usr/lib/python2.7/dist-packages/async/__init__.py", line 26, in =
_init_signals
[Wed May 13 04:14:05 2015] [warn]     signal.signal(signal.SIGINT, =
thread_interrupt_handler)

root@node1:/var/log/calamari# tail httpd_access.log
<ip> - - [13/May/2015:11:14:02 +0200] "GET =
/static/rest_framework/js/default.js HTTP/1.1" 304 209
<ip> - - [13/May/2015:11:14:04 +0200] "GET /api/v2/cluster HTTP/1.1" 200 =
2258
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/bootstrap.min.css HTTP/1.1" 304 211
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/bootstrap-tweaks.css HTTP/1.1" 304 209
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/prettify.css HTTP/1.1" 304 209
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/jquery-1.8.1-min.js HTTP/1.1" 304 211
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/bootstrap.min.js HTTP/1.1" 304 210
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/default.css HTTP/1.1" 304 209
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/prettify-min.js HTTP/1.1" 304 210
<ip> - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/default.js HTTP/1.1" 304 209

wget /api/v2/cluster returns:

GET /api/v2/cluster
HTTP 200 OK
Vary: Accept
Content-Type: text/html; charset=3Dutf-8
Allow: GET, HEAD, OPTIONS

[
    {
        "update_time": "2015-05-13T09:13:46.607104+00:00",=20
        "id": "16fe2dcf-2629-422f-a649-871deba78bcd",=20
        "name": "ceph"
    }
]


--Apple-Mail=_C33E1206-9E45-4731-B64D-C7BEC302A59C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 13/05/2015, at 04.08, Gregory Meno &lt;<a =
href=3D"mailto:gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div =
class=3D"">Ideally I would like everything in /var/log/calmari<br =
class=3D""><br class=3D"">be sure to set calamari.conf like so:<br =
class=3D"">[shadow_man@vpm107 ~]$ grep DEBUG /etc/calamari/calamari.conf =
<br class=3D"">log_level =3D DEBUG<br class=3D"">db_log_level =3D =
DEBUG<br class=3D"">log_level =3D DEBUG<br class=3D""><br class=3D"">then =
restart cthulhu and apache<br class=3D""><br class=3D"">visit <a =
href=3D"http://essperf3/api/v2/cluster" =
class=3D"">http://essperf3/api/v2/cluster</a><br class=3D"">and <a =
href=3D"http://essperf3" class=3D"">http://essperf3</a><br class=3D""><br =
class=3D"">and then share the logs here. Hopefully something obvious =
will be off in either calamari or cthulhu log<br =
class=3D""></div></blockquote></div><div class=3D"">Since I got similar =
issue, I sneak my log data in here as well, no offence=E2=80=A6</div><div =
class=3D""><br class=3D""></div><div class=3D"">-rw-r--r-- 1 www-data =
www-data &nbsp; 1554 May 13 11:14 info.log</div><div class=3D"">-rw-r--r--=
 1 root &nbsp; &nbsp; root &nbsp; &nbsp; &nbsp;29311 May 13 11:14 =
httpd_error.log</div><div class=3D"">-rw-r--r-- 1 root &nbsp; &nbsp; =
root &nbsp; &nbsp; &nbsp; 4599 May 13 11:14 httpd_access.log</div><div =
class=3D"">-rw-r--r-- 1 www-data www-data &nbsp; &nbsp;739 May 13 11:14 =
calamari.log</div><div class=3D"">-rw-r--r-- 1 root &nbsp; &nbsp; root =
&nbsp; &nbsp; 238047 May 13 11:14 cthulhu.log</div><div class=3D""><br =
class=3D""></div><div class=3D"">root@node1:/var/log/calamari# cat =
calamari.log</div><div class=3D"">2015-05-13 04:05:40,787 - =
metric_access - django.request Not Found: /favicon.ico</div><div =
class=3D"">2015-05-13 04:14:02,263 - DEBUG - django.request.profile =
[17.5249576569ms] /api/v2/cluster</div><div class=3D"">2015-05-13 =
04:14:02,263 - DEBUG - django.request.profile RPC timing for =
'list_clusters': 3.89504432678/3.89504432678/3.89504432678 avg/min/max =
ms</div><div class=3D"">2015-05-13 04:14:02,263 - DEBUG - =
django.request.profile Total time in RPC: 3.89504432678ms</div><div =
class=3D"">2015-05-13 04:14:06,172 - DEBUG - django.request.profile =
[15.8069133759ms] /api/v2/cluster</div><div class=3D"">2015-05-13 =
04:14:06,173 - DEBUG - django.request.profile RPC timing for =
'list_clusters': 2.44808197021/2.44808197021/2.44808197021 avg/min/max =
ms</div><div class=3D"">2015-05-13 04:14:06,173 - DEBUG - =
django.request.profile Total time in RPC: 2.44808197021ms</div><div =
class=3D""><br class=3D""></div><div =
class=3D"">root@node1:/var/log/calamari# tail cthulhu.log</div><div =
class=3D"">2015-05-13 11:14:46,694 - DEBUG - cthulhu nivcsw: =
102</div><div class=3D"">2015-05-13 11:14:46,709 - DEBUG - cthulhu =
Eventer.on_tick</div><div class=3D"">2015-05-13 11:14:46,710 - INFO - =
cthulhu Eventer._emit: 2015-05-13 09:14:46.710030+00:00/WARNING/Cluster =
'ceph' is late reporting in</div><div class=3D"">2015-05-13 11:14:46,710 =
- INFO - sqlalchemy.engine.base.Engine BEGIN (implicit)</div><div =
class=3D"">2015-05-13 11:14:46,711 - INFO - =
sqlalchemy.engine.base.Engine INSERT INTO cthulhu_event ("when", =
severity, message, fsid, fqdn, service_type, service_id) VALUES =
(%(when)s, %(severity)s, %(message)s, %(fsid)s, %(fqdn)s, =
%(service_type)s, %(service_id)s) RETURNING cthulhu_event.id</div><div =
class=3D"">2015-05-13 11:14:46,711 - INFO - =
sqlalchemy.engine.base.Engine {'severity': 3, 'when': =
datetime.datetime(2015, 5, 13, 9, 14, 46, 710030, tzinfo=3Dtzutc()), =
'fqdn': None, 'service_type': None, 'service_id': None, 'message': =
"Cluster 'ceph' is late reporting in", 'fsid': =
u'16fe2dcf-2629-422f-a649-871deba78bcd'}</div><div class=3D"">2015-05-13 =
11:14:46,713 - DEBUG - sqlalchemy.engine.base.Engine Col =
('id',)</div><div class=3D"">2015-05-13 11:14:46,714 - DEBUG - =
sqlalchemy.engine.base.Engine Row (54,)</div><div class=3D"">2015-05-13 =
11:14:46,714 - INFO - sqlalchemy.engine.base.Engine COMMIT</div><div =
class=3D"">2015-05-13 11:14:56,710 - DEBUG - cthulhu =
Eventer.on_tick</div><div class=3D""><br class=3D""></div><div =
class=3D"">root@node1:/var/log/calamari# tail httpd_error.log</div><div =
class=3D"">[Wed May 13 04:14:05 2015] [warn] &nbsp; File =
"/usr/lib/python2.7/dist-packages/git/__init__.py", line 20, in =
_init_externals</div><div class=3D"">[Wed May 13 04:14:05 2015] [warn] =
&nbsp; &nbsp; import gitdb</div><div class=3D"">[Wed May 13 04:14:05 =
2015] [warn] &nbsp; File =
"/usr/lib/python2.7/dist-packages/gitdb/__init__.py", line 25, in =
&lt;module&gt;</div><div class=3D"">[Wed May 13 04:14:05 2015] [warn] =
&nbsp; &nbsp; _init_externals()</div><div class=3D""><div class=3D"">[Wed =
May 13 04:14:05 2015] [warn] &nbsp; File =
"/usr/lib/python2.7/dist-packages/gitdb/__init__.py", line 17, in =
_init_externals</div><div class=3D"">[Wed May 13 04:14:05 2015] [warn] =
&nbsp; &nbsp; __import__(module)</div><div class=3D"">[Wed May 13 =
04:14:05 2015] [warn] &nbsp; File =
"/usr/lib/python2.7/dist-packages/async/__init__.py", line 36, in =
&lt;module&gt;</div><div class=3D"">[Wed May 13 04:14:05 2015] [warn] =
&nbsp; &nbsp; _init_signals()</div><div class=3D"">[Wed May 13 04:14:05 =
2015] [warn] &nbsp; File =
"/usr/lib/python2.7/dist-packages/async/__init__.py", line 26, in =
_init_signals</div><div class=3D"">[Wed May 13 04:14:05 2015] [warn] =
&nbsp; &nbsp; signal.signal(signal.SIGINT, =
thread_interrupt_handler)</div><div class=3D""><br class=3D""></div><div =
class=3D"">root@node1:/var/log/calamari# tail httpd_access.log</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:02 +0200] "GET =
/static/rest_framework/js/default.js HTTP/1.1" 304 209</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:04 +0200] "GET =
/api/v2/cluster HTTP/1.1" 200 2258</div><div class=3D"">&lt;ip&gt; - - =
[13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/bootstrap.min.css HTTP/1.1" 304 211</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/css/bootstrap-tweaks.css HTTP/1.1" 304 =
209</div><div class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] =
"GET /static/rest_framework/css/prettify.css HTTP/1.1" 304 209</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/jquery-1.8.1-min.js HTTP/1.1" 304 =
211</div><div class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] =
"GET /static/rest_framework/js/bootstrap.min.js HTTP/1.1" 304 =
210</div><div class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] =
"GET /static/rest_framework/css/default.css HTTP/1.1" 304 209</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/prettify-min.js HTTP/1.1" 304 210</div><div =
class=3D"">&lt;ip&gt; - - [13/May/2015:11:14:06 +0200] "GET =
/static/rest_framework/js/default.js HTTP/1.1" 304 209</div></div><div =
class=3D""><br class=3D""></div><div class=3D"">wget /api/v2/cluster =
returns:</div><div class=3D""><br class=3D""></div><div class=3D""><div =
class=3D"request-info" style=3D"clear: both; color: rgb(51, 51, 51); =
font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: =
14px; line-height: 20px;"><pre class=3D"prettyprint" style=3D"padding: =
8px; font-family: Monaco, Menlo, Consolas, 'Courier New', monospace; =
font-size: 12px; border-top-left-radius: 4px; border-top-right-radius: =
4px; border-bottom-right-radius: 4px; border-bottom-left-radius: 4px; =
margin-top: 0px; margin-bottom: 20px; word-break: break-all; word-wrap: =
normal; background-color: rgb(247, 247, 249); border: 1px solid rgb(225, =
225, 232); overflow: auto;"><b class=3D""><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">GET</span></b><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);"> </span><span class=3D"pun" =
style=3D"color: rgb(147, 161, 161);">/</span><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">api</span><span class=3D"pun" =
style=3D"color: rgb(147, 161, 161);">/</span><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">v2</span><span class=3D"pun" =
style=3D"color: rgb(147, 161, 161);">/</span><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">cluster</span></pre></div><div =
class=3D"response-info" style=3D"margin-bottom: 2em; color: rgb(51, 51, =
51); font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; =
font-size: 14px; line-height: 20px;"><pre class=3D"prettyprint" =
style=3D"padding: 8px; font-family: Monaco, Menlo, Consolas, 'Courier =
New', monospace; font-size: 12px; border-top-left-radius: 4px; =
border-top-right-radius: 4px; border-bottom-right-radius: 4px; =
border-bottom-left-radius: 4px; margin-top: 0px; margin-bottom: 20px; =
word-break: break-all; word-wrap: normal; background-color: rgb(247, =
247, 249); border: 1px solid rgb(225, 225, 232); overflow: auto;"><div =
class=3D"meta nocode"><b class=3D"">HTTP 200 OK</b>
<b class=3D"">Vary:</b> <span class=3D"lit" style=3D"color: rgb(25, 95, =
145);">Accept</span>
<b class=3D"">Content-Type:</b> <span class=3D"lit" style=3D"color: =
rgb(25, 95, 145);">text/html; charset=3Dutf-8</span>
<b class=3D"">Allow:</b> <span class=3D"lit" style=3D"color: rgb(25, 95, =
145);">GET, HEAD, OPTIONS</span>

</div><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">[</span><span class=3D"pln" style=3D"color: rgb(72, 72, 76);">
    </span><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">{</span><span class=3D"pln" style=3D"color: rgb(72, 72, 76);">
        </span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"update_time"</span><span class=3D"pun" style=3D"color: rgb(147, =
161, 161);">:</span><span class=3D"pln" style=3D"color: rgb(72, 72, =
76);"> </span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"2015-05-13T09:13:46.607104+00:00"</span><span class=3D"pun" =
style=3D"color: rgb(147, 161, 161);">,</span><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">=20
        </span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"id"</span><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">:</span><span class=3D"pln" style=3D"color: rgb(72, 72, 76);"> =
</span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"16fe2dcf-2629-422f-a649-871deba78bcd"</span><span class=3D"pun" =
style=3D"color: rgb(147, 161, 161);">,</span><span class=3D"pln" =
style=3D"color: rgb(72, 72, 76);">=20
        </span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"name"</span><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">:</span><span class=3D"pln" style=3D"color: rgb(72, 72, 76);"> =
</span><span class=3D"str" style=3D"color: rgb(221, 17, =
68);">"ceph"</span><span class=3D"pln" style=3D"color: rgb(72, 72, =
76);">
    </span><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">}</span><span class=3D"pln" style=3D"color: rgb(72, 72, 76);">
</span><span class=3D"pun" style=3D"color: rgb(147, 161, =
161);">]</span></pre></div><div class=3D""><br =
class=3D""></div></div></body></html>=

--Apple-Mail=_C33E1206-9E45-4731-B64D-C7BEC302A59C--

--===============0356627726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0356627726==--
