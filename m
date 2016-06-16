From: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Performance drop when object count in a pool hits a
	threshold
Date: Thu, 16 Jun 2016 12:03:50 +0000
Message-ID: <CA+e22Sf=wB0YjcEt_KTFKJuNhMdYYXK03V7Z_butCM-oy-Ux7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0350661379=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0350661379==
Content-Type: multipart/alternative; boundary=001a1134fd0a892d8f053564084d

--001a1134fd0a892d8f053564084d
Content-Type: text/plain; charset=UTF-8

Hi All,

I have a repeatable condition when the object count in a pool gets to
320-330 million the object write time dramatically and almost instantly
increases as much as 10X, exhibited by fs_apply_latency going from 10ms to
100s of ms.

Can someone point me in a direction / have an explanation ?

I can add a new pool and it performs normally.

Config is generally
3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD with
NVME for journals. Centos 7.2, XFS

Jewell is the release; inserting objects with librados via some Python test
code.

Best Regards
Wade

--001a1134fd0a892d8f053564084d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div style=3D"white-space:pre-wrap">Hi All,<br><br>I have a repeatable cond=
ition when the object count in a pool gets to 320-330 million the object wr=
ite time dramatically and almost instantly increases as much as 10X, exhibi=
ted by fs_apply_latency going from 10ms to 100s of ms. <br><br>Can someone =
point me in a direction / have an explanation ?<br><br>I can add a new pool=
 and it performs normally. <br><br>Config is generally<br>3 Nodes 24 physic=
al core each, 768GB Ram each, 16 OSD / node , all SSD with NVME for journal=
s. Centos 7.2, XFS<br><br>Jewell is the release; inserting objects with lib=
rados via some Python test code. <br><br>Best Regards<br>Wade<br></div>

--001a1134fd0a892d8f053564084d--

--===============0350661379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0350661379==--
