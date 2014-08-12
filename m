From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: wired output of ceph df : Firefly 0.80.5
Date: Tue, 12 Aug 2014 16:52:55 +0300
Message-ID: <97499908-D142-4F14-92BB-5214561F04B3@csc.fi>
References: <F690D436-ABCA-45D4-9583-492EED969300@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============0972487427=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <F690D436-ABCA-45D4-9583-492EED969300-Gn+qtVAUx6s@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0972487427==
Content-Type: multipart/alternative; boundary="Apple-Mail=_829868E0-8B25-4037-B2CB-E505B694A178"


--Apple-Mail=_829868E0-8B25-4037-B2CB-E505B694A178
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Forgot to mention i am observing  EB  in ceph -s output  ,  does it mean =
Exabyte  ;-)


# ceph -s
    cluster 009d3518-e60d-4f74-a26d-c08c1976263c
     health HEALTH_WARN 'cache-pool' at/near target max
     monmap e3: 3 mons at=20
     mdsmap e14: 1/1/1 up {0=3Dstorage0101-ib=3Dup:active}
     osdmap e194215: 402 osds: 402 up, 402 in
      pgmap v743051: 31168 pgs, 22 pools, 8 EB data, 378 kobjects
            17508 GB used, 1284 TB / 1301 TB avail
               31168 active+clean


- Karan Singh -


On 12 Aug 2014, at 16:45, Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org> wrote:

> Hello Developers=20
>=20
> I have encountered some wired output of ceph df command , suddenly
>=20
>=20
> When i was writing some data on cache-pool , and checked its used % , =
i found some used as 8E ( don=92t know what is this ) and the used % for =
cache-pool was 0
>=20
>=20
> # ceph df
> GLOBAL:
>     SIZE      AVAIL     RAW USED     %RAW USED
>     1301T     1284T     17518G       1.31
> POOLS:
>     NAME                   ID     USED       %USED     OBJECTS
>     data                   0      801M       0         2
>     metadata               1      801M       0         22
>     rbd                    2      0          0         0
>     .rgw                   3      3524       0         26
>     .rgw.root              4      778        0         3
>     .rgw.control           5      0          0         8
>     .rgw.buckets           6      8201M      0         2298
>     .rgw.buckets.index     7      0          0         13
>     .users.swift           8      7          0         1
>     volumes                9      1106G      0.08      283387
>     images                 10     40960k     0         8
>     backups                11     0          0         0
>     .rgw.gc                12     0          0         32
>     .users.uid             13     848        0         5
>     .users                 14     16         0         2
>     .log                   15     153k       0         37
>                            16     0          0         0
>     hpsl4540               21     110G       0         28152
>     hpdl380                22     245G       0.02      62688
>     EC-2-2                 23     6338G      0.48      4859
>     cache-pool             24     8E         0         5849       		=
	## What is the meaning of E here , also please note used % for =
cache-pool is 0 here
>     ssd                    25     25196M     0         5464
>=20
>=20
> After some time when cache-poo used value changed to 7E and used % as =
644301.19  . While there were no objects in the cache-pool
>=20
>=20
> # ceph df
> GLOBAL:
>     SIZE      AVAIL     RAW USED     %RAW USED
>     1301T     1284T     17508G       1.31
> POOLS:
>     NAME                   ID     USED       %USED         OBJECTS
>     data                   0      801M       0             2
>     metadata               1      801M       0             22
>     rbd                    2      0          0             0
>     .rgw                   3      3524       0             26
>     .rgw.root              4      778        0             3
>     .rgw.control           5      0          0             8
>     .rgw.buckets           6      8201M      0             2298
>     .rgw.buckets.index     7      0          0             13
>     .users.swift           8      7          0             1
>     volumes                9      1106G      0.08          283387
>     images                 10     40960k     0             8
>     backups                11     0          0             0
>     .rgw.gc                12     0          0             32
>     .users.uid             13     848        0             5
>     .users                 14     16         0             2
>     .log                   15     153k       0             37
>                            16     0          0             0
>     hpsl4540               21     110G       0             28152
>     hpdl380                22     245G       0.02          62688
>     EC-2-2                 23     6338G      0.48          4843
>     cache-pool             24     7E         644301.19     1056        =
               ## The used % for cache-pool has become 644301.19=20
>     ssd                    25     25196M     0             5464
> #
>=20
>=20
> # rados -p cache-pool ls                        =20
> #
>=20
>=20
>=20
>=20
> Is this a bug , if yes , then is is already known. Do you want me to =
raise a bug ticket in tracker.ceph.com ?
>=20
>=20
>=20
> ****************************************************************
> Karan Singh=20
> Cloud computing group
> CSC - IT Center for Science,
> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
> tel. +358 9 4572001
> fax +358 9 4572302
> http://www.csc.fi/
> ****************************************************************
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_829868E0-8B25-4037-B2CB-E505B694A178
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
apple-content-edited=3D"true"><div style=3D"orphans: auto; text-align: =
start; text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"color: rgb(0, 0, 0); letter-spacing: normal; text-transform: =
none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; orphans: auto; text-align: start; text-indent: 0px; widows: auto; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Forgot to mention i am observing <b>&nbsp;EB =
&nbsp;</b>in ceph -s output &nbsp;, &nbsp;does it mean Exabyte =
&nbsp;;-)</div><div style=3D"color: rgb(0, 0, 0); letter-spacing: =
normal; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; orphans: auto; text-align: start; =
text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; orphans: auto; =
text-align: start; text-indent: 0px; widows: auto; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div><div style=3D"orphans: auto; text-align: =
start; text-indent: 0px; widows: auto; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;"># ceph -s</div><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;">&nbsp; &nbsp; cluster =
009d3518-e60d-4f74-a26d-c08c1976263c</div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">&nbsp; &nbsp; &nbsp;health HEALTH_WARN 'cache-pool' =
at/near target max</div><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">&nbsp; =
&nbsp; &nbsp;monmap e3: 3 mons at&nbsp;</div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">&nbsp; &nbsp; &nbsp;mdsmap e14: 1/1/1 up =
{0=3Dstorage0101-ib=3Dup:active}</div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">&nbsp; &nbsp; &nbsp;osdmap e194215: 402 osds: 402 =
up, 402 in</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">&nbsp; <b>&nbsp; &nbsp; =
pgmap v743051: 31168 pgs, 22 pools, 8 EB data, 378 =
kobjects</b></div><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 17508 GB used, 1284 TB / 1301 TB =
avail</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;31168 active+clean</div><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;"><br></div><div style=3D"word-wrap:=
 break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">- =
Karan Singh -</div></div><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; orphans: auto; =
text-align: start; text-indent: 0px; widows: auto; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br></div></div>
</div>
<br><div><div>On 12 Aug 2014, at 16:45, Karan Singh &lt;<a =
href=3D"mailto:karan.singh-Gn+qtVAUx6s@public.gmane.org">karan.singh-Gn+qtVAUx6s@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hello =
Developers&nbsp;</div><div><br></div><div>I have encountered some wired =
output of ceph df command , =
suddenly</div><div><br></div><div><br></div><div>When i was writing some =
data on cache-pool , and checked its used % , i found some used as<b> =
8E</b> ( don=92t know what is this ) and the used % for cache-pool was =
0</div><div><br></div><div><br></div><div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b># ceph =
df</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>GLOBAL:</b></div><div style=3D"margin: =
0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; SIZE&nbsp; &nbsp; &nbsp; AVAIL &nbsp; &nbsp; RAW =
USED &nbsp; &nbsp; %RAW USED</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; 1301T &nbsp; &nbsp; 1284T &nbsp; &nbsp; 17518G &nbsp; &nbsp; =
&nbsp; 1.31</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>POOLS:</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; NAME &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ID &nbsp; &nbsp; USED &nbsp; &nbsp; =
&nbsp; %USED &nbsp; &nbsp; OBJECTS</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; data &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 0&nbsp; &nbsp; &nbsp; 801M &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; =
&nbsp; &nbsp; 2</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; metadata =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1&nbsp; &nbsp; &nbsp; =
801M &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 22</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; rbd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2&nbsp; &nbsp; &nbsp; 0&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 0</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; .rgw &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3&nbsp; &nbsp; &nbsp; 3524 &nbsp; =
&nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 26</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; .rgw.root&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 4&nbsp; &nbsp; &nbsp; 778&nbsp; &nbsp; &nbsp; =
&nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 3</b></div><div style=3D"margin: =
0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; .rgw.control &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
5&nbsp; &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; =
&nbsp; &nbsp; &nbsp; 8</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; =
.rgw.buckets &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6&nbsp; &nbsp; &nbsp; =
8201M&nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
2298</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; .rgw.buckets.index =
&nbsp; &nbsp; 7&nbsp; &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
0 &nbsp; &nbsp; &nbsp; &nbsp; 13</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; .users.swift &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 8&nbsp; &nbsp; =
&nbsp; 7&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
1</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; volumes&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9&nbsp; &nbsp; &nbsp; =
1106G&nbsp; &nbsp; &nbsp; 0.08&nbsp; &nbsp; &nbsp; 283387</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; images &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 10 &nbsp; &nbsp; 40960k &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; 8</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; backups&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 11 =
&nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; =
&nbsp; 0</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; =
.rgw.gc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 12 &nbsp; =
&nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
32</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; .users.uid &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 13 &nbsp; &nbsp; 848&nbsp; &nbsp; =
&nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 5</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; .users &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 14 &nbsp; &nbsp; 16 &nbsp; &nbsp; &nbsp; =
&nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 2</b></div><div style=3D"margin: =
0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; .log &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 15 &nbsp; &nbsp; 153k &nbsp; &nbsp; &nbsp; 0 &nbsp; =
&nbsp; &nbsp; &nbsp; 37</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp;&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 16 &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; 0</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; hpsl4540 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 21 =
&nbsp; &nbsp; 110G &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
28152</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; hpdl380&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 22 &nbsp; &nbsp; 245G &nbsp; =
&nbsp; &nbsp; 0.02&nbsp; &nbsp; &nbsp; 62688</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; EC-2-2 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 23 &nbsp; &nbsp; 6338G&nbsp; &nbsp; &nbsp; =
0.48&nbsp; &nbsp; &nbsp; 4859</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; cache-pool &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 24 &nbsp; =
&nbsp; 8E &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
5849&nbsp; &nbsp; &nbsp; &nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>## What is the =
meaning of E here , also please note used % for cache-pool is 0 =
here</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; ssd&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 25 &nbsp; &nbsp; 25196M =
&nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; 5464</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51); min-height: 12px;"><b></b><br></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, 51); =
min-height: 12px;"><b></b><br></div><div style=3D"margin: 0px; =
min-height: 12px;"><font color=3D"#323333" face=3D"Arial"><span =
style=3D"font-size: 11px;">After some time when cache-poo used value =
changed to </span></font><b style=3D"color: rgb(50, 51, 51); =
font-family: Arial; font-size: 11px;">7E </b><font color=3D"#323333" =
face=3D"Arial"><span style=3D"font-size: 11px;">and used % =
as&nbsp;</span></font><font color=3D"#323333" face=3D"Arial"><span =
style=3D"font-size: 11px;"><b>644301.19 &nbsp;. </b>While&nbsp;there =
were no objects in the cache-pool</span></font></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, 51); =
min-height: 12px;"><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51); min-height: =
12px;"><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b># ceph df</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>GLOBAL:</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; SIZE&nbsp; &nbsp; &nbsp; AVAIL &nbsp; &nbsp; RAW USED &nbsp; =
&nbsp; %RAW USED</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; 1301T =
&nbsp; &nbsp; 1284T &nbsp; &nbsp; 17508G &nbsp; &nbsp; &nbsp; =
1.31</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>POOLS:</b></div><div style=3D"margin: =
0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; NAME &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; ID &nbsp; &nbsp; USED &nbsp; &nbsp; &nbsp; %USED =
&nbsp; &nbsp; &nbsp; &nbsp; OBJECTS</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; data &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 0&nbsp; &nbsp; &nbsp; 801M &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 2</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; metadata &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1&nbsp; =
&nbsp; &nbsp; 801M &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 22</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; rbd&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2&nbsp; =
&nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 0</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; .rgw =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3&nbsp; =
&nbsp; &nbsp; 3524 &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 26</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; =
.rgw.root&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4&nbsp; &nbsp; =
&nbsp; 778&nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 3</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; =
.rgw.control &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5&nbsp; &nbsp; &nbsp; =
0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 8</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; =
.rgw.buckets &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6&nbsp; &nbsp; &nbsp; =
8201M&nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
2298</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; .rgw.buckets.index =
&nbsp; &nbsp; 7&nbsp; &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 13</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; .users.swift &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 8&nbsp; &nbsp; &nbsp; 7&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; volumes&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 9&nbsp; &nbsp; &nbsp; 1106G&nbsp; &nbsp; =
&nbsp; 0.08&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 283387</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; images &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 10 &nbsp; &nbsp; 40960k &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 8</b></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; backups&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 11 &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0</b></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; .rgw.gc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 12 &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 32</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>&nbsp; &nbsp; .users.uid &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 13 &nbsp; &nbsp; 848&nbsp; &nbsp; &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5</b></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; .users &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 14 &nbsp; &nbsp; 16 &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; .log &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 15 &nbsp; &nbsp; 153k &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 37</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp;&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 16 &nbsp; &nbsp; 0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0</b></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; hpsl4540 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; 21 &nbsp; &nbsp; 110G &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 28152</b></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; =
&nbsp; hpdl380&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 22 =
&nbsp; &nbsp; 245G &nbsp; &nbsp; &nbsp; 0.02&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; 62688</b></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; EC-2-2 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 23 &nbsp; &nbsp; =
6338G&nbsp; &nbsp; &nbsp; 0.48&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
4843</b></div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Arial; color: rgb(50, 51, 51);"><b>&nbsp; &nbsp; cache-pool &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 24 &nbsp; &nbsp; 7E &nbsp; &nbsp; =
&nbsp; &nbsp; 644301.19 &nbsp; &nbsp; 1056 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;## The used % for =
cache-pool has become 644301.19&nbsp;</b></div><div style=3D"margin: =
0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, =
51);"><b>&nbsp; &nbsp; ssd&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; 25 &nbsp; &nbsp; 25196M &nbsp; &nbsp; 0 =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5464</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51);"><b>#</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51); min-height: =
12px;"><b></b><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51); min-height: =
12px;"><b></b><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51);"><b># rados -p cache-pool =
ls&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;</b></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51);"><b>#</b></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Arial; color: =
rgb(50, 51, 51); min-height: 12px;"><b></b><br></div><div style=3D"margin:=
 0px; font-size: 11px; font-family: Arial; color: rgb(50, 51, 51); =
min-height: 12px;"><b></b><br></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Arial; color: rgb(50, 51, 51); min-height: =
12px;"><b></b><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Arial; color: rgb(50, 51, 51); min-height: =
12px;"><b></b><br></div></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Arial; color: rgb(50, 51, 51); min-height: 12px;">Is =
this a bug , if yes , then is is already known. Do you want me to raise =
a bug ticket in <a href=3D"http://tracker.ceph.com/">tracker.ceph.com</a> =
?</div><div><br></div><div><br></div><div apple-content-edited=3D"true">
<div style=3D"letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div style=3D"letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br class=3D"Apple-interchange-newline"><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: =
after-white-space;">******************************************************=
**********</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">Karan =
Singh&nbsp;</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">Cloud computing =
group</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">CSC - IT Center for =
Science,</div><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;">Keilaranta 14, P. O. Box =
405, FIN-02101 Espoo, Finland<br>tel. +358 9 4572001<br>fax +358 9 =
4572302<br><a href=3D"http://www.csc.fi/">http://www.csc.fi/</a></div><div=
 style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: =
after-white-space;">******************************************************=
**********</div></div></div></div>
</div>
<br></div>_______________________________________________<br>ceph-users =
mailing list<br><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br></blockquote></=
div><br></body></html>=

--Apple-Mail=_829868E0-8B25-4037-B2CB-E505B694A178--

--===============0972487427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0972487427==--
