From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Problem installing ceph from package manager / ceph
	repositories
Date: Tue, 10 Jun 2014 11:30:28 +0300
Message-ID: <4DC842D9-8254-4519-9034-1E76F0BF3C84@csc.fi>
References: <4849752F-2209-4D3F-B934-C670ADBB9CDC@csc.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: multipart/mixed; boundary="===============0863960586=="
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
To: Ceph Community <ceph-community-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0863960586==
Content-Type: multipart/alternative; boundary="Apple-Mail=_254EA45A-8F65-402C-A183-102DC1DC98D8"


--Apple-Mail=_254EA45A-8F65-402C-A183-102DC1DC98D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello Cephers

First of all this problem is not related to ceph-deploy , ceph-deploy =
1.5.4 works like charm :-) , thanks for Alfredo=20

Problem : =20

1. When installing Ceph using package manger ( # yum install ceph  or  # =
yum update cehp) that uses ceph repositories (cep.repo) , the package =
manager does not respect the ceph.repo file and takes ceph package =
directly from EPEL . But when i disable EPEL repo and again try to =
install ceph , it takes from ceph repo.  This is a new problem and =
earlier i have not faced this , though i have done several ceph cluster =
installation with package manager. I don=92t want EPEL version of Ceph.

2. When i uninstall ceph , from system its repository file i.e. =
ceph.repo is getting removed . Is this normal , i have not seen this =
before.


Any one else facing the same problem or have solution to this.


Regards
Karan Singh=

--Apple-Mail=_254EA45A-8F65-402C-A183-102DC1DC98D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><blockquote style=3D"margin: 0 0 0 40px; border: =
none; padding: 0px;"></blockquote><blockquote style=3D"margin: 0 0 0 =
40px; border: none; padding: 0px;"></blockquote><span style=3D"font-size: =
large;">Hello Cephers</span><font size=3D"4"><br></font><font =
size=3D"4"><br></font><span style=3D"font-size: large;">First of all =
this problem is not related to ceph-deploy , ceph-deploy 1.5.4 works =
like charm :-) , thanks for Alfredo&nbsp;</span><br><font =
size=3D"4"><br></font><span style=3D"font-size: large;">Problem : =
&nbsp;</span><br><font size=3D"4"><br>1. When installing Ceph using =
package manger ( # yum install ceph &nbsp;or &nbsp;# yum update cehp) =
that uses ceph&nbsp;repositories (cep.repo) , the package manager does =
not respect the ceph.repo file and takes ceph package directly from EPEL =
.&nbsp;But when i disable EPEL repo and again try to install ceph , it =
takes from ceph repo. &nbsp;This is a new problem and earlier =
i&nbsp;have not faced this , though i have done several ceph cluster =
installation with package manager. I&nbsp;don=92t want EPEL version of =
Ceph.<br></font><font size=3D"4"><br></font><span style=3D"font-size: =
large;">2. When i uninstall ceph , from system its repository file i.e. =
ceph.repo is getting removed . Is this normal , i have not seen this =
before.</span><br><font size=3D"4"><br><br></font><span =
style=3D"font-size: large;">Any one&nbsp;else facing the same problem or =
have solution to this.</span><div><font size=3D"4"><br><br></font><span =
style=3D"font-size: large;">Regards</span><br><font size=3D"4"><div><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;"><div><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div apple-content-edited=3D"true"><font =
size=3D"4">Karan =
Singh</font></div></div></div></div></div></font></div></body></html>=

--Apple-Mail=_254EA45A-8F65-402C-A183-102DC1DC98D8--

--===============0863960586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0863960586==--
