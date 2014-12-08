From: Anthony Alba <ascanio.alba7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: normalizing radosgw
Date: Mon, 8 Dec 2014 13:10:23 +0800
Message-ID: <CADkWibdxvvCqpy5yb+AqnC9S=be93yajWV2M=dyfpRW5qQ7s2g@mail.gmail.com>
References: <alpine.DEB.2.00.1412061025330.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1976016962=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1412061025330.18213-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1976016962==
Content-Type: multipart/alternative; boundary=047d7bd756b098cbea0509ad71e8

--047d7bd756b098cbea0509ad71e8
Content-Type: text/plain; charset=UTF-8

Suggestion: can we look at normalizing custom cluster names as well for
RHEL-like systems?

/etc/init.d/ceph: how do you pass --cluster myname at system startup?
systemd service file uses EnvironmentFile.

What about
. /etc/sysconfig/ceph #near the top

and /etc/sysconfig/ceph contains
cluster=myname

For ceph-radosgw even this does not work.
You need
export CEPH_CONF=/etc/ceph/myname.conf

as well.

Anthony

--047d7bd756b098cbea0509ad71e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Suggestion: can we look at normalizing custom cluster names as well for RHE=
L-like systems?<div><br></div><div>/etc/init.d/ceph: how do=C2=A0you pass -=
-cluster myname at system startup?</div>systemd service file uses Environme=
ntFile.<div><br></div><div>What about</div><div>. /etc/sysconfig/ceph #near=
 the top</div><div><br></div><div>and /etc/sysconfig/ceph contains</div>clu=
ster=3Dmyname<div><br></div><div>For ceph-radosgw even this does not work.<=
/div><div>You need=C2=A0</div>export CEPH_CONF=3D/etc/ceph/myname.conf<div>=
<br></div>as well.<div><br></div><div>Anthony</div>

--047d7bd756b098cbea0509ad71e8--

--===============1976016962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1976016962==--
