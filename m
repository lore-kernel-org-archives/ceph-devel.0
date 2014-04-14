From: Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: A simple tool to do osd crush reweigh after creating
	pool to gain better PG distribution across OSDs
Date: Mon, 14 Apr 2014 14:15:32 +0800
Message-ID: <101F1E71-1022-4D2C-BAE7-C0A645D267EF@yahoo.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============1429414340=="
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


--===============1429414340==
Content-Type: multipart/alternative; boundary="Apple-Mail=_E471B135-293D-43C6-A85E-2B4FA907D600"


--Apple-Mail=_E471B135-293D-43C6-A85E-2B4FA907D600
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi all,
In order to deal with PG uneven problem[1, 2] which further leads to =
uneven disk usage, I recently developed a simple script which aims to do =
*osd crush* reweight right after creating the pool (which has the most =
significant data, e.g. .rgw.buckets), we had good experience to tune the =
distribution difference to less than 10% with use of this tool.

Here is the tool - =
https://github.com/guangyy/ceph_misc/blob/master/osd_crush_reweight/ceph_o=
sd_crush_reweight.pl

If you have a similar experience with relatively high PG distribution =
across OSDs by default, you can check out the script and see if that =
serve your purpose or not, all reviews and suggestions (especially the =
algorithm for a even better distribution) are welcomed.


[1] https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg04216.html
[2] http://www.spinics.net/lists/ceph-devel/msg17509.html

Thanks,
Guang=

--Apple-Mail=_E471B135-293D-43C6-A85E-2B4FA907D600
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hi =
all,<div>In order to deal with PG uneven problem[1, 2] which further =
leads to uneven disk usage, I recently developed a simple script which =
aims to do *osd crush* reweight right after creating the pool (which has =
the most significant data, e.g. .rgw.buckets), we had good experience to =
tune the distribution difference to less than 10% with use of this =
tool.</div><div><br></div><div>Here is the tool -&nbsp;<a =
href=3D"https://github.com/guangyy/ceph_misc/blob/master/osd_crush_reweigh=
t/ceph_osd_crush_reweight.pl">https://github.com/guangyy/ceph_misc/blob/ma=
ster/osd_crush_reweight/ceph_osd_crush_reweight.pl</a></div><div><br></div=
><div>If you have a similar experience with relatively high PG =
distribution across OSDs by default, you can check out the script and =
see if that serve your purpose or not, all reviews and suggestions =
(especially the algorithm for a even better distribution) are =
welcomed.</div><div><br></div><div><br></div><div>[1]&nbsp;<a =
href=3D"https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg04216.ht=
ml">https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg04216.html</=
a></div><div>[2]&nbsp;<a =
href=3D"http://www.spinics.net/lists/ceph-devel/msg17509.html">http://www.=
spinics.net/lists/ceph-devel/msg17509.html</a></div><div><br></div><div>Th=
anks,</div><div>Guang</div></body></html>=

--Apple-Mail=_E471B135-293D-43C6-A85E-2B4FA907D600--

--===============1429414340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1429414340==--
