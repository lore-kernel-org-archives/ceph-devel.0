From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ec pool history objects
Date: Mon, 15 Jun 2015 18:04:19 +0800
Message-ID: <CANE=7sWM_ghX_w_zVxLczs1ns4UFpd33sSsvGKruEV96hUmL_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0672402875=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0672402875==
Content-Type: multipart/alternative; boundary=047d7bd76788cc2dd605188b9461

--047d7bd76788cc2dd605188b9461
Content-Type: text/plain; charset=UTF-8

hi, all:

    when I use ec poll, I see there are some object history for object
xxxxxx.

    Such as: xxxxxx__head_610951D6__2_fe1_2, xxxxxx__head_610951D6__2_fe2_2
xxxxxx__head_610951D6__2_ffffffffffffffff_2

    I think this object is used for roll_back when not all shards have
written object to filestore. Is it right?

    If that, why not delete this history objects when all shards has
written object to filestore?

-- 
Regards,
xinze

--047d7bd76788cc2dd605188b9461
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:14px"><div>hi, all:</div><div><br>=
</div><div>=C2=A0 =C2=A0 when I use ec poll, I see there are some object hi=
story for object xxxxxx.</div><div><br></div><div>=C2=A0 =C2=A0 Such as: xx=
xxxx__head_610951D6__2_fe1_2, xxxxxx__head_610951D6__2_fe2_2 xxxxxx__head_6=
10951D6__2_ffffffffffffffff_2</div></div><div style=3D"font-size:14px"><br>=
</div><div style=3D"font-size:14px">=C2=A0 =C2=A0 I think this object is us=
ed for roll_back when not all shards have written object to filestore. Is i=
t right?</div><div style=3D"font-size:14px"><br></div><div style=3D"font-si=
ze:14px">=C2=A0 =C2=A0 If that, why not delete this history objects when al=
l shards has written object to filestore?=C2=A0</div><div><br></div>-- <br>=
<div class=3D"gmail_signature">Regards,<br>xinze</div>
</div>

--047d7bd76788cc2dd605188b9461--

--===============0672402875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0672402875==--
