From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 08:05:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502260802460.25838@cobra.newdream.net>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
	<CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com>
	<alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
	<D1147C43.12E64%mk7193@yp.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-243683843-1424966752=:25838"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <D1147C43.12E64%mk7193-CivJcMWXhi0@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-243683843-1424966752=:25838
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Feb 2015, Michael Kuriger wrote:
> I=B9d also like to set this up.  I=B9m not sure where to begin.  When y=
ou say
> enabled by default, where is it enabled?

The civetweb frontend is built into the radosgw process, so for the most=20
part you just have to get radosgw started and configured.  It isn't well=20
documented yet, but basically just skip everything that has anythig to do=
=20
with fastcgi or apache.  For example, if you follow the docs, you can jum=
p=20
straight to here:

	http://docs.ceph.com/docs/master/install/install-ceph-gateway/#id5

(or maybe set up the wildcard DNS if you want to get fancy).

If you're on firefly, you also need to add the line below to ceph.conf to=
=20
enable civetweb; for giant and hammer radosgw will listen on port 7480 by=
=20
default.

sage


>=20
> Many thanks,
> Mike
>=20
>=20
> On 2/25/15, 1:49 PM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> >On Wed, 25 Feb 2015, Robert LeBlanc wrote:
> >> We tried to get radosgw working with Apache + mod_fastcgi, but due t=
o
> >> the changes in radosgw, Apache, mode_*cgi, etc and the documentation
> >> lagging and not having a lot of time to devote to it, we abandoned i=
t.
> >> Where it the documentation for civetweb? If it is appliance like and
> >> easy to set-up, we would like to try it to offer some feedback on yo=
ur
> >> question.
> >
> >In giant and hammer, it is enabled by default on port 7480.  On firefl=
y,
> >you need to add the line
> >
> > rgw frontends =3D fastcgi, civetweb port=3D7480
> >
> >to ceph.conf (you can of course adjust the port number if you like) an=
d
> >radosgw will run standalone w/ no apache or anything else.
> >
> >sage
> >
> >
> >>=20
> >> Thanks,
> >> Robert LeBlanc
> >>=20
> >> On Wed, Feb 25, 2015 at 12:31 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote=
:
> >> > Hey,
> >> >
> >> > We are considering switching to civetweb (the embedded/standalone =
rgw
> >>web
> >> > server) as the primary supported RGW frontend instead of the curre=
nt
> >> > apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here
> >>means
> >> > both the primary platform the upstream development focuses on and
> >>what the
> >> > downstream Red Hat product will officially support.
> >> >
> >> > How many people are using RGW standalone using the embedded civetw=
eb
> >> > server instead of apache?  In production?  At what scale?  What
> >> > version(s) (civetweb first appeared in firefly and we've backporte=
d
> >>most
> >> > fixes).
> >> >
> >> > Have you seen any problems?  Any other feedback?  The hope is to
> >>(vastly)
> >> > simplify deployment.
> >> >
> >> > Thanks!
> >> > sage
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> >=20
> >>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.ceph.com_=
listin
> >>fo.cgi_ceph-2Dusers-2Dceph.com&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p=
1AamzLOS
> >>ncm6Vfn0C_UQ&r=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3=
RMufAb9w
> >>81RjI2K1ZU&s=3DVsyJ8UHWG0ApL86WXaeD5eOV5SRA7VmGeSkKGws3qMI&e=3D
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at
> >>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__vger.kernel.org=
_major
> >>domo-2Dinfo.html&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p1AamzLOSncm6Vf=
n0C_UQ&r
> >>=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3RMufAb9w81RjI2=
K1ZU&s=3Di
> >>RNo1K7oJZ-14R-LWuNvEI0WoOr5UuaDkm3IQx77VIo&e=3D
> >>=20
> >>=20
> >_______________________________________________
> >ceph-users mailing list
> >ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.ceph.com_l=
istinf
> >o.cgi_ceph-2Dusers-2Dceph.com&d=3DAwICAg&c=3DlXkdEK1PC7UK9oKA-BBSI8p1A=
amzLOSnc
> >m6Vfn0C_UQ&r=3DCSYA9OS6Qd7fQySI2LDvlQ&m=3DkDLPSKEyNK6uMLfvU8U7GTva3RMu=
fAb9w81R
> >jI2K1ZU&s=3DVsyJ8UHWG0ApL86WXaeD5eOV5SRA7VmGeSkKGws3qMI&e=3D=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-243683843-1424966752=:25838
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-243683843-1424966752=:25838--
