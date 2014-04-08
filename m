From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: Ceph v0.79 Firefly RC :: erasure-code-profile
	command set not present
Date: Tue, 8 Apr 2014 12:44:03 +0300
Message-ID: <6CD10D8D-16D8-4BFE-B270-D14E11D9FCF7@csc.fi>
References: <3423E02F-D2A2-4E7A-99BF-9B277FF3AB19@csc.fi>
	<5343C143.70803@catalyst.net.nz>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============1837192370=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5343C143.70803-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============1837192370==
Content-Type: multipart/alternative; boundary="Apple-Mail=_1A01E4F9-6C5B-42F1-9565-3DCBC7CC48D7"


--Apple-Mail=_1A01E4F9-6C5B-42F1-9565-3DCBC7CC48D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Thanks Mark for this quick checkup on Ubuntu distro. you saved my time , =
i was also checking the same thing.

All of my ceph components are on 0.79 , this looks to be a problem with =
ceph binaries for RHEL.

@ Ceph Developers :  Any thought on this.

# rpm -qa | egrep -i "ceph|rados|rbd"
ceph-deploy-1.4.0-0.noarch
librbd1-0.79-0.el6.x86_64
libcephfs1-0.79-0.el6.x86_64
ceph-release-1-0.el6.noarch
python-ceph-0.79-0.el6.x86_64
librados2-0.79-0.el6.x86_64
ceph-0.79-0.el6.x86_64
#


Also updated the latest latest ceph release 0.79-75 ( on a different =
machine ) , but still no LUCK.


# rpm -qa | egrep -i "ceph|rados|rbd"
libcephfs1-0.79-75.g2a6d962.el6.x86_64
ceph-deploy-1.4.0-0.noarch
librbd1-0.79-75.g2a6d962.el6.x86_64
librados2-0.79-75.g2a6d962.el6.x86_64
ceph-0.79-75.g2a6d962.el6.x86_64
ceph-release-1-0.el6.noarch
python-ceph-0.79-75.g2a6d962.el6.x86_64

# ceph osd erasure-code-profile ls
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

On 08 Apr 2014, at 12:28, Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org> =
wrote:

> Wow - that is a bit strange:
>=20
> $ cat /etc/issue
> Ubuntu 13.10 \n \l
>=20
> $ sudo ceph -v
> ceph version 0.78-569-g6a4c50d =
(6a4c50d7f27d2e7632d8c017d09e864e969a05f7)
>=20
> $ sudo ceph osd erasure-code-profile ls
> default
> myprofile
> profile
> profile1
>=20
> I'd hazard a guess that some of your ceph components are at version < =
0.78 still (partial upgrade or similar).
>=20
> Regards
>=20
> Mark
>=20
> On 08/04/14 20:57, Karan Singh wrote:
>> Thanks Developers for 0.79 , happy to see its announcement.
>>=20
>> I have been using 0.78 in order to test EC and TP , with 0.78 i was =
not
>> able to test erasure code profile feature  ( # ceph osd
>> erasure-code-profile set myprofile=85=85) as erasure-code-profile =
command
>> set is not present in 0.78 but its mentioned in documentation.
>>=20
>> http://ceph.com/docs/master/dev/erasure-coded-pool/#interface
>> https://ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface
>> https://ceph.com/docs/v0.79/dev/erasure-coded-pool/#interface
>>=20
>> I tried the same thing on 0.79 , but again looks like =93 ceph osd
>> erasure-code-profile =93 command set is not implemented here as well.
>>=20
>> Do we need to wait for 0.80 release to test erasure-code-profile
>>  feature ??
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
>> Karan Singh
>> CSC - IT Center for Science,
>> Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
>> mobile: +358 503 812758
>> tel. +358 9 4572001
>> fax +358 9 4572302
>> http://www.csc.fi/
>> ****************************************************************
>>=20
>>=20
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>=20


--Apple-Mail=_1A01E4F9-6C5B-42F1-9565-3DCBC7CC48D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thanks =
Mark for this quick checkup on Ubuntu distro. you saved my time , i was =
also checking the same thing.<div><br></div><div>All of my ceph =
components are on 0.79 , this looks to be a problem with ceph binaries =
for RHEL.</div><div><br></div><div>@ Ceph Developers : &nbsp;Any thought =
on this.</div><div><br></div><div><div># rpm -qa | egrep -i =
"ceph|rados|rbd"</div><div>ceph-deploy-1.4.0-0.noarch</div><div>librbd1-0.=
79-0.el6.x86_64</div><div>libcephfs1-0.79-0.el6.x86_64</div><div>ceph-rele=
ase-1-0.el6.noarch</div><div>python-ceph-0.79-0.el6.x86_64</div><div>libra=
dos2-0.79-0.el6.x86_64</div><div>ceph-0.79-0.el6.x86_64</div><div>#</div><=
div><br></div><div><br></div><div>Also updated the latest latest ceph =
release 0.79-75 ( on a different machine ) , but still no =
LUCK.</div><div><br></div><div><br></div><div><div># rpm -qa | egrep -i =
"ceph|rados|rbd"</div><div>libcephfs1-0.79-75.g2a6d962.el6.x86_64</div><di=
v>ceph-deploy-1.4.0-0.noarch</div><div>librbd1-0.79-75.g2a6d962.el6.x86_64=
</div><div>librados2-0.79-75.g2a6d962.el6.x86_64</div><div>ceph-0.79-75.g2=
a6d962.el6.x86_64</div><div>ceph-release-1-0.el6.noarch</div><div>python-c=
eph-0.79-75.g2a6d962.el6.x86_64</div><div><br></div><div># ceph osd =
erasure-code-profile ls</div><div>no valid command found; 10 closest =
matches:</div><div>osd tier add-cache &lt;poolname&gt; &lt;poolname&gt; =
&lt;int[0-]&gt;</div><div>osd tier set-overlay &lt;poolname&gt; =
&lt;poolname&gt;</div><div>osd tier remove-overlay =
&lt;poolname&gt;</div><div>osd tier remove &lt;poolname&gt; =
&lt;poolname&gt;</div><div>osd tier cache-mode &lt;poolname&gt; =
none|writeback|forward|readonly</div><div>osd thrash =
&lt;int[0-]&gt;</div><div>osd tier add &lt;poolname&gt; &lt;poolname&gt; =
{--force-nonempty}</div><div>osd stat</div><div>osd =
reweight-by-utilization {&lt;int[100-]&gt;}</div><div>osd pool stats =
{&lt;name&gt;}</div><div>Error EINVAL: invalid =
command</div><div>#</div></div><div><br></div><div><br></div><div><br></di=
v><div apple-content-edited=3D"true"><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div style=3D"color: rgb(0, 0, 0); letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;">******************************************************=
**********</div><div style=3D"color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
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
<br><div><div>On 08 Apr 2014, at 12:28, Mark Kirkwood &lt;<a =
href=3D"mailto:mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org">mark.kirkwood-6STWZtX7tXCb+IgNlVxDgg@public.gmane.org=
z</a>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">Wow - that is a bit strange:<br><br>$ cat =
/etc/issue<br>Ubuntu 13.10 \n \l<br><br>$ sudo ceph -v<br>ceph version =
0.78-569-g6a4c50d (6a4c50d7f27d2e7632d8c017d09e864e969a05f7)<br><br>$ =
sudo ceph osd erasure-code-profile =
ls<br>default<br>myprofile<br>profile<br>profile1<br><br>I'd hazard a =
guess that some of your ceph components are at version &lt; 0.78 still =
(partial upgrade or similar).<br><br>Regards<br><br>Mark<br><br>On =
08/04/14 20:57, Karan Singh wrote:<br><blockquote type=3D"cite">Thanks =
Developers for 0.79 , happy to see its announcement.<br><br>I have been =
using 0.78 in order to test EC and TP , with 0.78 i was not<br>able to =
test erasure code profile feature &nbsp;( # ceph =
osd<br>erasure-code-profile set myprofile=85=85) as erasure-code-profile =
command<br>set is not present in 0.78 but its mentioned in =
documentation.<br><br><a =
href=3D"http://ceph.com/docs/master/dev/erasure-coded-pool/#interface">htt=
p://ceph.com/docs/master/dev/erasure-coded-pool/#interface</a><br>https://=
ceph.com/docs/v0.78/dev/erasure-coded-pool/#interface<br>https://ceph.com/=
docs/v0.79/dev/erasure-coded-pool/#interface<br><br>I tried the same =
thing on 0.79 , but again looks like =93 ceph =
osd<br>erasure-code-profile =93 command set is not implemented here as =
well.<br><br>Do we need to wait for 0.80 release to test =
erasure-code-profile<br> &nbsp;feature ??<br><br><br># cat =
/etc/redhat-release<br>CentOS release 6.4 (Final)<br><br># ceph =
-v<br>ceph version 0.79 =
(4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)<br><br># ceph osd =
erasure-code-profile<br>no valid command found; 10 closest =
matches:<br>osd tier add-cache &lt;poolname&gt; &lt;poolname&gt; =
&lt;int[0-]&gt;<br>osd tier set-overlay &lt;poolname&gt; =
&lt;poolname&gt;<br>osd tier remove-overlay &lt;poolname&gt;<br>osd tier =
remove &lt;poolname&gt; &lt;poolname&gt;<br>osd tier cache-mode =
&lt;poolname&gt; none|writeback|forward|readonly<br>osd thrash =
&lt;int[0-]&gt;<br>osd tier add &lt;poolname&gt; &lt;poolname&gt; =
{--force-nonempty}<br>osd stat<br>osd reweight-by-utilization =
{&lt;int[100-]&gt;}<br>osd pool stats {&lt;name&gt;}<br>Error EINVAL: =
invalid =
command<br>#<br><br><br><br>**********************************************=
******************<br>Karan Singh<br>CSC - IT Center for =
Science,<br>Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, =
Finland<br>mobile: +358 503 812758<br>tel. +358 9 4572001<br>fax +358 9 =
4572302<br>http://www.csc.fi/<br>*****************************************=
***********************<br><br><br><br>___________________________________=
____________<br>ceph-users mailing =
list<br>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br>http://lists.ceph.com/listinfo.cgi/ce=
ph-users-ceph.com<br><br></blockquote><br></blockquote></div><br></div></b=
ody></html>=

--Apple-Mail=_1A01E4F9-6C5B-42F1-9565-3DCBC7CC48D7--

--===============1837192370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1837192370==--
