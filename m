From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: PG folder hierarchy
Date: Wed, 26 Feb 2014 11:13:36 +0800
Message-ID: <21B7D175-AB24-45A8-B64F-AA7BA2E3A215@yahoo.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/mixed; boundary="===============1750766068=="
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
To: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1750766068==
Content-Type: multipart/alternative; boundary="Apple-Mail=_995EF221-B531-4A79-A74F-A220F28EA2E7"


--Apple-Mail=_995EF221-B531-4A79-A74F-A220F28EA2E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello,
Most recently when looking at PG=92s folder splitting, I found that =
there was only one sub folder in the top 3 / 4 levels and start having =
16 sub folders starting from level 6, what is the design consideration =
behind this?

For example, if the PG root folder is =913.1905_head=92, in the first =
level, it only has one sub folder =91DIR_5=92 and then one sub folder =
=91DIR_0=92, and then =91DIR_9=92, under which there are two sub folders =
=91DIR_1=92 and =91DIR_9=92, starting from which, the next level has 16 =
sub folders.

If we start splitting into 16 sub folders in the very first level, we =
may potential gain better performance with less dentry lookup (though =
most likely the root level been cached).

Thanks,
Guang=

--Apple-Mail=_995EF221-B531-4A79-A74F-A220F28EA2E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><font =
size=3D"4">Hello,</font><div><font size=3D"4">Most recently when looking =
at PG=92s folder splitting, I found that there was only one sub folder =
in the top 3 / 4 levels and start having 16 sub folders starting from =
level 6, what is the design consideration behind =
this?</font></div><div><font size=3D"4"><br></font></div><div><font =
size=3D"4">For exam<font color=3D"#11053b">ple, if the PG root folder =
is&nbsp;=913.<b>1905</b>_head=92, in the first level, it only has one =
sub folder&nbsp;=91DIR_5=92 and then one sub folder&nbsp;=91DIR_0=92, =
and then&nbsp;=91DIR_9=92, under which there are two sub =
folders&nbsp;=91DIR_1=92 and&nbsp;=91DIR_9=92, starting from which, the =
next level has 16 sub =
folders.</font></font></div><div><br></div><div><font color=3D"#11053b" =
size=3D"4">If we start splitting into 16 sub folders in the very first =
level, we may potential gain better performance with less&nbsp;dentry =
lookup (though most likely the root level been =
cached).</font></div><div><font size=3D"4"><font =
color=3D"#11053b"><br></font></font></div><div><font size=3D"4"><font =
color=3D"#11053b">Thanks,</font></font></div><div><font size=3D"4"><font =
color=3D"#11053b">Guang</font></font></div></body></html>=

--Apple-Mail=_995EF221-B531-4A79-A74F-A220F28EA2E7--

--===============1750766068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1750766068==--
