From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: RBD v1 image format ...
Date: Wed, 11 Jan 2017 11:09:46 -0500
Message-ID: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1699911658=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1699911658==
Content-Type: multipart/alternative; boundary=001a113fbc445d47880545d3d4eb

--001a113fbc445d47880545d3d4eb
Content-Type: text/plain; charset=UTF-8

I would like to propose that starting with the Luminous release of Ceph,
RBD will no longer support the creation of v1 image format images via the
rbd CLI and librbd.

We previously made the v2 image format the default and deprecated the v1
format under the Jewel release. It is important to note that we would still
support the use of v1 images by the CLI, VMs, etc for Luminous.

Any objections or concerns?

-- 
Jason

--001a113fbc445d47880545d3d4eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would like to propose that starting with the Luminous re=
lease of Ceph, RBD will no longer support the creation of v1 image format i=
mages via the rbd CLI and librbd.<div><br></div><div>We previously made the=
 v2 image format the default and deprecated the v1 format under the Jewel r=
elease. It is important to note that we would still support the use of v1 i=
mages by the CLI, VMs, etc for Luminous.=C2=A0</div><div><br></div><div>Any=
 objections or concerns?<br><br>-- <br>Jason</div></div>

--001a113fbc445d47880545d3d4eb--

--===============1699911658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1699911658==--
