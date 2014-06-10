From: Dan Van Der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Subject: Re: Problem installing ceph from package manager /
 ceph	repositories
Date: Tue, 10 Jun 2014 08:34:09 +0000
Message-ID: <C108D0D0-F5F3-4E73-B12E-2196C8FD652B@cern.ch>
References: <4849752F-2209-4D3F-B934-C670ADBB9CDC@csc.fi>
	<4DC842D9-8254-4519-9034-1E76F0BF3C84@csc.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0526602209=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <4DC842D9-8254-4519-9034-1E76F0BF3C84-Gn+qtVAUx6s@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0526602209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C108D0D0F5F34E73B12E2196C8FD652Bcernch_"

--_000_C108D0D0F5F34E73B12E2196C8FD652Bcernch_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 10 Jun 2014, at 10:30, Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org<mailto:karan.sing=
h@csc.fi>> wrote:

Hello Cephers

First of all this problem is not related to ceph-deploy , ceph-deploy 1.5.4=
 works like charm :-) , thanks for Alfredo

Problem :

1. When installing Ceph using package manger ( # yum install ceph  or  # yu=
m update cehp) that uses ceph repositories (cep.repo) , the package manager=
 does not respect the ceph.repo file and takes ceph package directly from E=
PEL . But when i disable EPEL repo and again try to install ceph , it takes=
 from ceph repo.  This is a new problem and earlier i have not faced this ,=
 though i have done several ceph cluster installation with package manager.=
 I don=92t want EPEL version of Ceph.


You probably need to tweak the repo priorities. We use priority=3D30 for ep=
el.repo, priority=3D5 for ceph.repo.

Cheers, Dan


-- Dan van der Ster || Data & Storage Services || CERN IT Department --


2. When i uninstall ceph , from system its repository file i.e. ceph.repo i=
s getting removed . Is this normal , i have not seen this before.


Any one else facing the same problem or have solution to this.


Regards
Karan Singh
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--_000_C108D0D0F5F34E73B12E2196C8FD652Bcernch_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <6A2A328828EB214F8C811922EAB80C02-vJEk5272eHo@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;">
Hi,<br>
<div apple-content-edited=3D"true"><br>
</div>
<div>
<div>On 10 Jun 2014, at 10:30, Karan Singh &lt;<a href=3D"mailto:karan.sing=
h@csc.fi">karan.singh-Gn+qtVAUx6s@public.gmane.org</a>&gt; wrote:</div>
<br class=3D"Apple-interchange-newline">
<blockquote type=3D"cite">
<div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line=
-break: after-white-space;">
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;"></blo=
ckquote>
<blockquote style=3D"margin: 0 0 0 40px; border: none; padding: 0px;"></blo=
ckquote>
<span style=3D"font-size: large;">Hello Cephers</span><font size=3D"4"><br>
</font><font size=3D"4"><br>
</font><span style=3D"font-size: large;">First of all this problem is not r=
elated to ceph-deploy , ceph-deploy 1.5.4 works like charm :-) , thanks for=
 Alfredo&nbsp;</span><br>
<font size=3D"4"><br>
</font><span style=3D"font-size: large;">Problem : &nbsp;</span><br>
<font size=3D"4"><br>
1. When installing Ceph using package manger ( # yum install ceph &nbsp;or =
&nbsp;# yum update cehp) that uses ceph&nbsp;repositories (cep.repo) , the =
package manager does not respect the ceph.repo file and takes ceph package =
directly from EPEL .&nbsp;But when i disable EPEL repo
 and again try to install ceph , it takes from ceph repo. &nbsp;This is a n=
ew problem and earlier i&nbsp;have not faced this , though i have done seve=
ral ceph cluster installation with package manager. I&nbsp;don=92t want EPE=
L version of Ceph.<br>
</font><font size=3D"4"><br>
</font></div>
</blockquote>
<div><br>
</div>
<div>You probably need to tweak the repo priorities. We use&nbsp;priority=
=3D30 for epel.repo,&nbsp;priority=3D5 for ceph.repo.</div>
<div><br>
</div>
<div>Cheers, Dan</div>
<div><br>
</div>
<div><br>
-- Dan van der Ster || Data &amp; Storage&nbsp;Services || CERN IT Departme=
nt --<br>
</div>
<div><br>
</div>
<br>
<blockquote type=3D"cite">
<div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line=
-break: after-white-space;">
<span style=3D"font-size: large;">2. When i uninstall ceph , from system it=
s repository file i.e. ceph.repo is getting removed . Is this normal , i ha=
ve not seen this before.</span><br>
<font size=3D"4"><br>
<br>
</font><span style=3D"font-size: large;">Any one&nbsp;else facing the same =
problem or have solution to this.</span>
<div><font size=3D"4"><br>
<br>
</font><span style=3D"font-size: large;">Regards</span><br>
<font size=3D"4">Karan Singh</font></div>
</div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br>
</blockquote>
</div>
<br>
</body>
</html>

--_000_C108D0D0F5F34E73B12E2196C8FD652Bcernch_--

--===============0526602209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0526602209==--
