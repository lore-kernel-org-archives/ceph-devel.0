From: Abhay Sachan <abhaysac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph-create-keys hung
Date: Thu, 3 Oct 2013 19:14:55 +0530
Message-ID: <CAK72ynaw9YqN8AUae2N1ZdkCaMhCEbQ8tKn_tYB=RUk6e7RFdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0270330251=="
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
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0270330251==
Content-Type: multipart/alternative; boundary=001a11c3fba24f2c9704e7d665cc

--001a11c3fba24f2c9704e7d665cc
Content-Type: text/plain; charset=UTF-8

Hi All,
I have tried setting up a ceph cluster with 3 nodes (3 monitors). I am
using RHEL 6.4 as OS with dumpling(0.67.3) release. Ceph cluster creation
(using ceph-deploy as well as mkcephfs), ceph-creates-keys doesn't return
on any of the servers. Whereas, if I create a cluster with only 1 node (1
monitor), key creation goes through. Has anybody seen this problem or any
ideas what I might be missing??

Regards,
Abhay

--001a11c3fba24f2c9704e7d665cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi All,<br></div>I have tried setting up a ceph =
cluster with 3 nodes (3 monitors). I am using RHEL 6.4 as OS with dumpling(=
0.67.3) release. Ceph cluster creation (using ceph-deploy as well as mkceph=
fs), ceph-creates-keys doesn&#39;t return on any of the servers. Whereas, i=
f I create a cluster with only 1 node (1 monitor), key creation goes throug=
h. Has anybody seen this problem or any ideas what I might be missing??<br>

<br></div><div>Regards,<br></div>Abhay<br></div>

--001a11c3fba24f2c9704e7d665cc--

--===============0270330251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0270330251==--
