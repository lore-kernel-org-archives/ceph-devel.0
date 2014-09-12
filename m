From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regarding key/value interface
Date: Thu, 11 Sep 2014 18:30:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409111825480.513@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-951385807-1410485450=:513"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176-cXZ6iGhjG0i+xgsn/SD5JjJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-951385807-1410485450=:513
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Somnath,

On Fri, 12 Sep 2014, Somnath Roy wrote:
>=20
> Hi Sage/Haomai,
>=20
> If I have a key/value backend that support transaction, range queries (=
and I
> don?t need any explicit caching etc.) and I want to replace filestore (=
and
> leveldb omap) with that, =A0which interface you recommend me to derive =
from ,
> directly ObjectStore or =A0KeyValueDB ?
>=20
> I have already integrated this backend by deriving from ObjectStore
> interfaces earlier (pre keyvalueinteface days) but not tested thoroughl=
y
> enough to see what functionality is broken (Basic functionalities of RG=
W/RBD
> are working fine).
>=20
> Basically, I want to know what are the advantages (and disadvantages) o=
f
> deriving it from the new key/value interfaces ?
>=20
> Also, what state is it in ? Is it feature complete and supporting all t=
he
> ObjectStore interfaces like clone and all ?

Everything is supported, I think, for perhaps some IO hints that don't=20
make sense in a k/v context.  The big things that you get by using=20
KeyValueStore and plugging into the lower-level interface are:

 - striping of file data across keys
 - efficient clone
 - a zillion smaller methods that aren't conceptually difficult to=20
implement bug tedious and to do so.

The other nice thing about reusing this code is that you can use a leveld=
b=20
or rocksdb backend as a reference for testing or performance or whatever.

The main thing that will be a challenge going forward, I predict, is=20
making storage of the object byte payload in key/value pairs efficient.  =
I=20
think KeyValuestore is doing some simple striping, but it will suffer for=
=20
small overwrites (like 512-byte or 4k writes from an RBD).  There are=20
probably some pretty simple heuristics and tricks that can be done to=20
mitigate the most common patterns, but there is no simple solution since=20
the backends generally don't support partial value updates (I assume your=
s=20
doesn't either?).  But, any work done here will benefit the other backend=
s=20
too so that would be a win..

sage
--557981400-951385807-1410485450=:513
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-951385807-1410485450=:513--
