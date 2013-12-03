From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Radosgw on Ubuntu vs CentOS
Date: Tue, 3 Dec 2013 08:06:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312030804430.18059@cobra.newdream.net>
References: <CAM2OCdNxBuLExC1N_e3Cag0gZ=845eVmgcECSEokG4TrR60yhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1286455201-1386086780=:18059"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAM2OCdNxBuLExC1N_e3Cag0gZ=845eVmgcECSEokG4TrR60yhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Andy McCrae <andy.mccrae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1286455201-1386086780=:18059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2013, Andy McCrae wrote:
> Hi ceph-users,
> I've been playing around with radosgw and I notice there is an inconsis=
tency
> between the Ubuntu and CentOS startup scripts.
>=20
> On Ubuntu, if I run a start ceph-all (which will start radosgw), or I r=
un
> the init script /etc/init.d/radosgw start - the radosgw process starts =
up
> fine, but running as root.
>=20
> On CentOS the init script starts radosgw as the "apache" user by defaul=
t.
>=20
> I can see the Ubuntu init script is specifying "www-data" which would b=
e in
> keeping with the CentOS init script, but the process runs as root.
>=20
> + start-stop-daemon --start -u www-data -x /usr/bin/radosgw -- -n
> client.radosgw.ubunTest
> 2013-12-03 15:13:26.449087 7fee1d33b780 -1 WARNING: libcurl doesn't sup=
port
> curl_multi_wait()
> 2013-12-03 15:13:26.449093 7fee1d33b780 -1 WARNING: cross zone / region
> transfer performance may be affected
> root@ubunTest:~# ps -ef | grep radosgw
> root =A0 =A0 28528 =A0 =A0 1 =A00 15:13 ? =A0 =A0 =A0 =A000:00:00 /usr/=
bin/radosgw -n
> client.radosgw.ubunTest
>=20
>=20
> The question is, do we consider this a bug in that radosgw shouldn't ru=
n as
> root by default, or should the CentOS/RHEL (rpm) init scripts start rad=
osgw
> as root - I'd assume the former.

I think it's a bug.  There is no real need for radosgw to run as root,=20
except that it needs to log to /var/log/radosgw/*.  We should update the=20
packaging (rpm and deb) to create a radosgw user (and/or a ceph group?)=20
and then make the two environments behave consistently.

Anyone with strong opinions in this area interested?

sage

--557981400-1286455201-1386086780=:18059
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1286455201-1386086780=:18059--
