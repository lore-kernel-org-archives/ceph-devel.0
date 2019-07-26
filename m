From: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Fri, 26 Jul 2019 12:31:59 +0530
Message-ID: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1219209013617629813=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1219209013617629813==
Content-Type: multipart/alternative; boundary="0000000000001feefb058e901f1f"

--0000000000001feefb058e901f1f
Content-Type: text/plain; charset="UTF-8"

 I have a rbd mirroring setup with primary and secondary clusters as peers
and I have a pool enabled image mode.., In this i created a rbd image ,
enabled with journaling.
But whenever i enable mirroring on the image,  I m getting error in
rbdmirror.log and  osd.log.
I have increased the timeouts.. nothing worked and couldnt traceout the
error
please guide me to solve this error.

*Logs*
http://paste.openstack.org/show/754766/

-- 


*Regards,Ajitha R*

--0000000000001feefb058e901f1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><p dir=
=3D"ltr" style=3D"font-family:sans-serif">=C2=A0I have a rbd mirroring=20
setup with primary and secondary clusters as peers and I have a pool enable=
d=20
image mode.., In this i created a rbd image , enabled with journaling.</p>B=
ut
 whenever i enable mirroring on the image,=C2=A0 I m getting error in rbdmi=
rror.log and=C2=A0=20
osd.log. <br></div><div>I have increased the timeouts.. nothing worked and =
couldnt traceout the error<br clear=3D"all"></div><div dir=3D"ltr">please g=
uide me to solve this error.<br><br></div><div><b>Logs</b><br><a href=3D"ht=
tp://paste.openstack.org/show/754766/">http://paste.openstack.org/show/7547=
66/</a><br><br></div><div dir=3D"ltr">-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr"><b><i style=3D"background-color:rgb(255,255,2=
55);color:rgb(102,0,0)">Regards,<span></span><br>Ajitha R</i><br></b></div>=
</div></div></div></div></div>

--0000000000001feefb058e901f1f--

--===============1219209013617629813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1219209013617629813==--
