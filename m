From: Imran Khan <khan.imran2591-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Deploying ceph using Dell equallogic storage arrays
Date: Wed, 21 Jan 2015 12:02:30 +0500
Message-ID: <CACbsoAAepyLz2HrCLR6KjtvLRb+M703pn7TG5aXYCgS1Xc3ubg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0704835892=="
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
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0704835892==
Content-Type: multipart/alternative; boundary=001a1134930e96d151050d242389

--001a1134930e96d151050d242389
Content-Type: text/plain; charset=UTF-8

Dear concerned,

Can I use Dell's equallogic storage arrays (model PS-4110) to configure
different OSDs on these storage arrays (maybe by creating different
volumes). If this is possible, then how can should I set about deploying
Ceph in my system (some user guide or introductory document will be nice).

I am deploying my OpenStack cloud and currently these storage blades can be
configured as Cinder Volumes, I have iSCSI access to my storage arrays from
all my blades.

I don't have any real experience with Ceph but I know that normal blade
servers can easily be configured as Ceph storage clusters in HA mode with
monitors et al.

What I want is to use my storage arrays as Ceph Storage Clusters.

Warm regards,
Khan, Imran

--001a1134930e96d151050d242389
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear concerned,<div><br></div><div>Can I use Dell&#39;s eq=
uallogic storage arrays (model PS-4110) to configure different OSDs on thes=
e storage arrays (maybe by creating different volumes). If this is possible=
, then how can should I set about deploying Ceph in my system (some user gu=
ide or introductory document will be nice).=C2=A0</div><div><br></div><div>=
I am deploying my OpenStack cloud and currently these storage blades can be=
 configured as Cinder Volumes, I have iSCSI access to my storage arrays fro=
m all my blades.=C2=A0</div><div><br></div><div>I don&#39;t have any real e=
xperience with Ceph but I know that normal blade servers can easily be conf=
igured as Ceph storage clusters in HA mode with monitors et al.=C2=A0</div>=
<div><br></div><div>What I want is to use my storage arrays as Ceph Storage=
 Clusters.</div><div><br></div><div>Warm regards,<br clear=3D"all"><div><di=
v class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr">Khan, Imran</div><div dir=3D"ltr"><br></div></div></di=
v></div></div></div>
</div></div>

--001a1134930e96d151050d242389--

--===============0704835892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0704835892==--
