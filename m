From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Maximum RBD image name length
Date: Thu, 19 May 2016 11:51:52 -0400
Message-ID: <CA+aFP1CRtwa=rOqafGRdBe1ei5cVeSA60E3aBCgEFjMygntBEg@mail.gmail.com>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028575803=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0028575803==
Content-Type: multipart/alternative; boundary=485b395e7de7ee47f2053333f3a5

--485b395e7de7ee47f2053333f3a5
Content-Type: text/plain; charset=UTF-8

As of today, neither the rbd CLI nor librbd imposes any limit on the
maximum length of an RBD image name, whereas krbd has roughly a 100
character limit and the OSDs have a default object name limit of roughly
2000 characters. While there is a patch under review to increase the krbd
limit, it would still be bounded to a maximum in the low thousands of
characters.

Starting with the Kraken release, we would like to add validation for a
sensible maximum image name length when creating new images .  I am looking
for feedback from any users who require very long RBD image names (>100
characters) to help guide this limit.

Thanks,

-- 
Jason

--485b395e7de7ee47f2053333f3a5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As of today, neither the rbd CLI nor librbd imposes a=
ny limit on the maximum length of an RBD image name, whereas krbd has rough=
ly a 100 character limit and the OSDs have a default object name limit of r=
oughly 2000 characters. While there is a patch under review to increase the=
 krbd limit, it would still be bounded to a maximum in the low thousands of=
 characters.=C2=A0</div><div><br></div><div>Starting with the Kraken releas=
e, we would like to add validation for a sensible maximum image name length=
 when creating new images .=C2=A0 I am looking for feedback from any users =
who require very long RBD image names (&gt;100 characters) to help guide th=
is limit.</div><div><br></div><div>Thanks,</div><div><div><br>-- <br>Jason<=
br></div></div></div>

--485b395e7de7ee47f2053333f3a5--

--===============0028575803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0028575803==--
