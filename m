From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: Ceph v0.79 Firefly RC :: erasure-code-profile
	command set not present
Date: Thu, 10 Apr 2014 17:31:42 +0300
Message-ID: <9E109788-4A93-4D3B-8861-EEB51F110C30@csc.fi>
References: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
	<alpine.DEB.2.00.1404080801250.28550@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============0037501770=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1404080801250.28550-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0037501770==
Content-Type: multipart/alternative; boundary="Apple-Mail=_C97EAA13-DE30-4E44-B2F1-534CAB565CF5"


--Apple-Mail=_C97EAA13-DE30-4E44-B2F1-534CAB565CF5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Finally everything worked with ceph version 0.79-125 .

I agree with you , version 0.79 does have erasure-code-profile command =
set , But This mess was due to ceph init script which was missing =
"/lib/lsb/init-functions=94 file which is blocking ceph services to get =
started.

Thanks Sage / Alfredo for your timely support.

****************************************************************
Karan Singh=20
CSC - IT Center for Science,
Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
mobile: +358 503 812758
tel. +358 9 4572001
fax +358 9 4572302
http://www.csc.fi/
****************************************************************

On 08 Apr 2014, at 18:01, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, 8 Apr 2014, Karan Singh wrote:
>> Thanks Developers for 0.79 , happy to see its announcement.
>> I have been using 0.78 in order to test EC and TP , with 0.78 i was =
not able
>> to test erasure code profile feature  ( # ceph osd =
erasure-code-profile
>> set myprofile ??) as erasure-code-profile command set is not present =
in 0.78 but
>> its mentioned in documentation.
>>=20
>> http://ceph.com/docs/master/dev/erasure-coded-pool/#interface
>> https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface
>> https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface
>>=20
>> I tried the same thing on 0.79 , but again looks like ? ceph osd
>> erasure-code-profile ? command set is not implemented here as well.
>>=20
>> Do we need to wait for 0.80 release to test erasure-code-profile  =
feature
>> ??=20
>>=20
>>=20
>> # cat /etc/redhat-release
>> CentOS release 6.4 (Final)
>>=20
>> # ceph -v
>> ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
>>=20
>> # ceph osd erasure-code-profile
>> no valid command found; 10 closest matches:
>=20
> Did you restart the ceph-mon daemons?
>=20
> sage
>=20
>=20
>> osd tier add-cache <poolname> <poolname> <int[0-]>
>> osd tier set-overlay <poolname> <poolname>
>> osd tier remove-overlay <poolname>
>> osd tier remove <poolname> <poolname>
>> osd tier cache-mode <poolname> none|writeback|forward|readonly
>> osd thrash <int[0-]>
>> osd tier add <poolname> <poolname> {--force-nonempty}
>> osd stat
>> osd reweight-by-utilization {<int[100-]>}
>> osd pool stats {<name>}
>> Error EINVAL: invalid command
>> #
>>=20
>>=20
>>=20
>> ****************************************************************
>> Karan Singh=20
>> CSC - IT Center for Science,
>> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
>> mobile: +358 503 812758
>> tel. +358 9 4572001
>> fax +358 9 4572302
>> http://www.csc.fi/
>> ****************************************************************


--Apple-Mail=_C97EAA13-DE30-4E44-B2F1-534CAB565CF5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Finally everything worked with<b>&nbsp;ceph =
version 0.79-125 </b>.</div><div><br></div><div>I agree with you , =
version 0.79 does have erasure-code-profile command set , But This mess =
was due to ceph init script which was missing "/lib/lsb/init-functions=94 =
file which is blocking ceph services to get =
started.</div><div><br></div>Thanks Sage / Alfredo for your timely =
support.<br><div apple-content-edited=3D"true">
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
<br><div><div>On 08 Apr 2014, at 18:01, Sage Weil &lt;<a =
href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On Tue, 8 Apr 2014, Karan Singh =
wrote:<br><blockquote type=3D"cite">Thanks Developers for 0.79 , happy =
to see its announcement.<br>I have been using 0.78 in order to test EC =
and TP , with 0.78 i was not able<br>to test erasure code profile =
feature &nbsp;( #&nbsp;ceph osd =
erasure-code-profile<br>set&nbsp;myprofile&nbsp;??) as =
erasure-code-profile command set is not&nbsp;present in 0.78 but<br>its =
mentioned in documentation.<br><br><a =
href=3D"http://ceph.com/docs/master/dev/erasure-coded-pool/#interface">htt=
p://ceph.com/docs/master/dev/erasure-coded-pool/#interface</a><br>https://=
ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface<br>https://ceph.com/=
docs/v0.79/dev/erasure-coded-pool/#interface<br><br>I tried the same =
thing on 0.79 , but again looks like ?&nbsp;ceph =
osd<br>erasure-code-profile&nbsp;?&nbsp;command set is not implemented =
here as well.<br><br>Do we need to wait for 0.80 release to test =
erasure-code-profile &nbsp;feature<br>??&nbsp;<br><br><br># cat =
/etc/redhat-release<br>CentOS release 6.4 (Final)<br><br># ceph =
-v<br>ceph version 0.79 =
(4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)<br><br># ceph osd =
erasure-code-profile<br>no valid command found; 10 closest =
matches:<br></blockquote><br>Did you restart the ceph-mon =
daemons?<br><br>sage<br><br><br><blockquote type=3D"cite">osd tier =
add-cache &lt;poolname&gt; &lt;poolname&gt; &lt;int[0-]&gt;<br>osd tier =
set-overlay &lt;poolname&gt; &lt;poolname&gt;<br>osd tier remove-overlay =
&lt;poolname&gt;<br>osd tier remove &lt;poolname&gt; =
&lt;poolname&gt;<br>osd tier cache-mode &lt;poolname&gt; =
none|writeback|forward|readonly<br>osd thrash &lt;int[0-]&gt;<br>osd =
tier add &lt;poolname&gt; &lt;poolname&gt; {--force-nonempty}<br>osd =
stat<br>osd reweight-by-utilization {&lt;int[100-]&gt;}<br>osd pool =
stats {&lt;name&gt;}<br>Error EINVAL: invalid =
command<br>#<br><br><br><br>**********************************************=
******************<br>Karan Singh&nbsp;<br>CSC - IT Center for =
Science,<br>Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, =
Finland<br>mobile: +358 503 812758<br>tel. +358 9 4572001<br>fax +358 9 =
4572302<br><a =
href=3D"http://www.csc.fi/">http://www.csc.fi/</a><br>********************=
********************************************</blockquote></div></blockquot=
e></div><br></body></html>=

--Apple-Mail=_C97EAA13-DE30-4E44-B2F1-534CAB565CF5--

--===============0037501770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0037501770==--
