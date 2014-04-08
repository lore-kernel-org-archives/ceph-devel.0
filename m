From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Ceph v0.79 Firefly RC :: erasure-code-profile command
	set not present
Date: Tue, 8 Apr 2014 11:57:20 +0300
Message-ID: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============2090687125=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============2090687125==
Content-Type: multipart/alternative; boundary="Apple-Mail=_4E497B4F-3892-4BE3-8485-1418F2039322"


--Apple-Mail=_4E497B4F-3892-4BE3-8485-1418F2039322
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Thanks Developers for 0.79 , happy to see its announcement.

I have been using 0.78 in order to test EC and TP , with 0.78 i was not =
able to test erasure code profile feature  ( # ceph osd =
erasure-code-profile set myprofile =85=85) as erasure-code-profile =
command set is not present in 0.78 but its mentioned in documentation.

http://ceph.com/docs/master/dev/erasure-coded-pool/#interface
https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface
https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface

I tried the same thing on 0.79 , but again looks like =93 ceph osd =
erasure-code-profile =93 command set is not implemented here as well.

Do we need to wait for 0.80 release to test erasure-code-profile  =
feature ??=20


# cat /etc/redhat-release
CentOS release 6.4 (Final)

# ceph -v
ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)

# ceph osd erasure-code-profile
no valid command found; 10 closest matches:
osd tier add-cache <poolname> <poolname> <int[0-]>
osd tier set-overlay <poolname> <poolname>
osd tier remove-overlay <poolname>
osd tier remove <poolname> <poolname>
osd tier cache-mode <poolname> none|writeback|forward|readonly
osd thrash <int[0-]>
osd tier add <poolname> <poolname> {--force-nonempty}
osd stat
osd reweight-by-utilization {<int[100-]>}
osd pool stats {<name>}
Error EINVAL: invalid command
#



****************************************************************
Karan Singh=20
CSC - IT Center for Science,
Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
mobile: +358 503 812758
tel. +358 9 4572001
fax +358 9 4572302
http://www.csc.fi/
****************************************************************


--Apple-Mail=_4E497B4F-3892-4BE3-8485-1418F2039322
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thanks =
Developers for 0.79 , happy to see its =
announcement.<div><br></div><div>I have been using 0.78 in order to test =
EC and TP , with 0.78 i was not able to test erasure code profile =
feature &nbsp;( #&nbsp;<span style=3D"background-color: white;"><font =
color=3D"#222222"><span style=3D"font-size: 1.1em; line-height: =
1.2em;">ceph osd erasure-code-profile set&nbsp;</span></font><font =
color=3D"#222222" size=3D"2"><span style=3D"line-height: =
15px;">myprofile</span></font><font color=3D"#222222"><span =
style=3D"font-size: 1.1em; line-height: 1.2em;">&nbsp;</span><font =
size=3D"2"><span style=3D"line-height: 15px;">=85=85</span></font><span =
style=3D"font-size: 1.1em; line-height: 1.2em;">) as =
erasure-code-profile command set is not&nbsp;</span><span =
style=3D"line-height: 15px;"><font size=3D"2">present in 0.78 but its =
mentioned in =
documentation.</font></span></font></span></div><div><br></div><div><a =
href=3D"http://ceph.com/docs/master/dev/erasure-coded-pool/#interface">htt=
p://ceph.com/docs/master/dev/erasure-coded-pool/#interface</a></div><div><=
a =
href=3D"https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface">htt=
ps://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface</a></div><div><=
a =
href=3D"https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface">htt=
ps://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface</a></div><div><=
br></div><div>I tried the same thing on 0.79 , but again looks like =
=93&nbsp;<span style=3D"background-color: rgb(255, 255, 255);"><font =
color=3D"#222222" size=3D"2"><span style=3D"line-height: 15px;">ceph osd =
erasure-code-profile&nbsp;=93&nbsp;command set is not implemented here =
as well.</span></font></span></div><div><br></div><div>Do we need to =
wait for 0.80 release to test erasure-code-profile &nbsp;feature =
??&nbsp;</div><div><br></div><div><br></div><div><div># cat =
/etc/redhat-release</div><div>CentOS release 6.4 =
(Final)</div><div><br></div></div><div><div># ceph -v</div><div>ceph =
version 0.79 =
(4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)</div><div><br></div><div># =
ceph osd erasure-code-profile</div><div>no valid command found; 10 =
closest matches:</div><div>osd tier add-cache &lt;poolname&gt; =
&lt;poolname&gt; &lt;int[0-]&gt;</div><div>osd tier set-overlay =
&lt;poolname&gt; &lt;poolname&gt;</div><div>osd tier remove-overlay =
&lt;poolname&gt;</div><div>osd tier remove &lt;poolname&gt; =
&lt;poolname&gt;</div><div>osd tier cache-mode &lt;poolname&gt; =
none|writeback|forward|readonly</div><div>osd thrash =
&lt;int[0-]&gt;</div><div>osd tier add &lt;poolname&gt; &lt;poolname&gt; =
{--force-nonempty}</div><div>osd stat</div><div>osd =
reweight-by-utilization {&lt;int[100-]&gt;}</div><div>osd pool stats =
{&lt;name&gt;}</div><div>Error EINVAL: invalid =
command</div><div>#</div></div><div><br></div><div><br><div =
apple-content-edited=3D"true">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><br =
class=3D"Apple-interchange-newline">**************************************=
**************************</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Karan =
Singh&nbsp;</div><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">CSC - =
IT Center for Science,</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, =
Finland<br>mobile: +358 503 812758<br>tel. +358 9 4572001<br>fax +358 9 =
4572302<br><a href=3D"http://www.csc.fi/">http://www.csc.fi/</a></div><div=
 style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">******************************************************=
**********</div></div></div>
</div>
<br></div></body></html>=

--Apple-Mail=_4E497B4F-3892-4BE3-8485-1418F2039322--

--===============2090687125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2090687125==--
