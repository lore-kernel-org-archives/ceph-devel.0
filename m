From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: Problem installing ceph from package manager /
	ceph repositories
Date: Tue, 10 Jun 2014 15:40:41 +0300
Message-ID: <39BBDA4C-5558-4E0B-A1D3-58CE722B7542@csc.fi>
References: <4849752F-2209-4D3F-B934-C670ADBB9CDC@csc.fi>
	<4DC842D9-8254-4519-9034-1E76F0BF3C84@csc.fi>
	<C108D0D0-F5F3-4E73-B12E-2196C8FD652B@cern.ch>
	<CANtztVwCJx_=bR-mpct0i3j=xaMxreRJw0X9PF1CE7X07o-jgA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: multipart/mixed; boundary="===============1741123086=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANtztVwCJx_=bR-mpct0i3j=xaMxreRJw0X9PF1CE7X07o-jgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, Dan Van Der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1741123086==
Content-Type: multipart/alternative; boundary="Apple-Mail=_7D252F28-7AF1-4BB9-8655-DA325CE2DAD9"


--Apple-Mail=_7D252F28-7AF1-4BB9-8655-DA325CE2DAD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Thanks Dan / Alfredo

Yep priority=3D1  helped a little bit and yum-plugin-priority fixed all.

- karan -

On 10 Jun 2014, at 15:22, Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, Jun 10, 2014 at 4:34 AM, Dan Van Der Ster
> <daniel.vanderster-vJEk5272eHo@public.gmane.org> wrote:
>> Hi,
>>=20
>> On 10 Jun 2014, at 10:30, Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org> wrote:
>>=20
>> Hello Cephers
>>=20
>> First of all this problem is not related to ceph-deploy , ceph-deploy =
1.5.4
>> works like charm :-) , thanks for Alfredo
>>=20
>> Problem :
>>=20
>> 1. When installing Ceph using package manger ( # yum install ceph  or =
 # yum
>> update cehp) that uses ceph repositories (cep.repo) , the package =
manager
>> does not respect the ceph.repo file and takes ceph package directly =
from
>> EPEL . But when i disable EPEL repo and again try to install ceph , =
it takes
>> from ceph repo.  This is a new problem and earlier i have not faced =
this ,
>> though i have done several ceph cluster installation with package =
manager. I
>> don=92t want EPEL version of Ceph.
>>=20
>>=20
>> You probably need to tweak the repo priorities. We use priority=3D30 =
for
>> epel.repo, priority=3D5 for ceph.repo.
>>=20
>=20
> This is exactly what ceph-deploy is now doing. It is installing the
> priorities plugin for yum
> and then setting a very low number for ceph.repo (1 I believe)
>=20
> This is explained in the last release announcement for ceph-deploy and
> for more details
> you can see this ticket:  http://tracker.ceph.com/issues/8533
>=20
>> Cheers, Dan
>>=20
>>=20
>> -- Dan van der Ster || Data & Storage Services || CERN IT Department =
--
>>=20
>>=20
>> 2. When i uninstall ceph , from system its repository file i.e. =
ceph.repo is
>> getting removed . Is this normal , i have not seen this before.
>>=20
>>=20
>> Any one else facing the same problem or have solution to this.
>>=20
>>=20
>> Regards
>> Karan Singh
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_7D252F28-7AF1-4BB9-8655-DA325CE2DAD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Thanks =
Dan / Alfredo<div><br></div><div>Yep priority=3D1 &nbsp;helped a little =
bit and yum-plugin-priority fixed all.<div =
apple-content-edited=3D"true"><div style=3D"color: rgb(0, 0, 0); =
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
after-white-space;"><br class=3D"Apple-interchange-newline">- karan =
-</div></div></div>
</div>
<br><div><div>On 10 Jun 2014, at 15:22, Alfredo Deza &lt;<a =
href=3D"mailto:alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On Tue, Jun 10, 2014 at 4:34 AM, =
Dan Van Der Ster<br>&lt;<a =
href=3D"mailto:daniel.vanderster-vJEk5272eHo@public.gmane.org">daniel.vanderster-vJEk5272eHo@public.gmane.org</a>&gt=
; wrote:<br><blockquote type=3D"cite">Hi,<br><br>On 10 Jun 2014, at =
10:30, Karan Singh &lt;<a =
href=3D"mailto:karan.singh-Gn+qtVAUx6s@public.gmane.org">karan.singh-Gn+qtVAUx6s@public.gmane.org</a>&gt; =
wrote:<br><br>Hello Cephers<br><br>First of all this problem is not =
related to ceph-deploy , ceph-deploy 1.5.4<br>works like charm :-) , =
thanks for Alfredo<br><br>Problem :<br><br>1. When installing Ceph using =
package manger ( # yum install ceph &nbsp;or &nbsp;# yum<br>update cehp) =
that uses ceph repositories (cep.repo) , the package manager<br>does not =
respect the ceph.repo file and takes ceph package directly from<br>EPEL =
. But when i disable EPEL repo and again try to install ceph , it =
takes<br>from ceph repo. &nbsp;This is a new problem and earlier i have =
not faced this ,<br>though i have done several ceph cluster installation =
with package manager. I<br>don=92t want EPEL version of =
Ceph.<br><br><br>You probably need to tweak the repo priorities. We use =
priority=3D30 for<br>epel.repo, priority=3D5 for =
ceph.repo.<br><br></blockquote><br>This is exactly what ceph-deploy is =
now doing. It is installing the<br>priorities plugin for yum<br>and then =
setting a very low number for ceph.repo (1 I believe)<br><br>This is =
explained in the last release announcement for ceph-deploy and<br>for =
more details<br>you can see this ticket: &nbsp;<a =
href=3D"http://tracker.ceph.com/issues/8533">http://tracker.ceph.com/issue=
s/8533</a><br><br><blockquote type=3D"cite">Cheers, Dan<br><br><br>-- =
Dan van der Ster || Data &amp; Storage Services || CERN IT Department =
--<br><br><br>2. When i uninstall ceph , from system its repository file =
i.e. ceph.repo is<br>getting removed . Is this normal , i have not seen =
this before.<br><br><br>Any one else facing the same problem or have =
solution to this.<br><br><br>Regards<br>Karan =
Singh<br>_______________________________________________<br>ceph-users =
mailing list<br><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</blockquote></div>=
</blockquote></div><br></div></body></html>=

--Apple-Mail=_7D252F28-7AF1-4BB9-8655-DA325CE2DAD9--

--===============1741123086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1741123086==--
