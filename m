From: Sage Weil <sage@newdream.net>
Subject: Re: v0.44 released
Date: Wed, 21 Mar 2012 12:14:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203211212570.558@cobra.newdream.net>
References: <Pine.LNX.4.64.1203210638450.28797@cobra.newdream.net>
 <CABYiri-qoXSxZ-eUmt19H3Q32DCF6eU4s3rKxj9YfsDP2U3dkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-635723547-1332357281=:558"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41473 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab2CUTOm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 15:14:42 -0400
In-Reply-To: <CABYiri-qoXSxZ-eUmt19H3Q32DCF6eU4s3rKxj9YfsDP2U3dkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-635723547-1332357281=:558
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

[CCing list, since others will surely hit this!]

On Wed, 21 Mar 2012, Andrey Korolyov wrote:
> Hi Sage,
>=20
> autogen failed at :
>=20
> cd src/leveldb && autoreconf -fvi;
> autoreconf: `configure.ac' or `configure.in' is required

We use leveldb in ceph-osd to manage the key/value data, and build it via =
=20
git submodule.  You'll need to=20

 $ git submodule init     # only once
 $ git submodule update   # whenever we change which leveldb commit we're o=
n

sage



>=20
> On Wed, Mar 21, 2012 at 5:39 PM, Sage Weil <sage@newdream.net> wrote:
> > v0.44 is ready! =A0Changes since v0.43 include:
> >
> > =A0* osd: key/value objects (objects are now blobs, key/value bundles, =
and
> > =A0 xattrs)
> > =A0* osd: cleaned up PG state, stats
> > =A0* osd: fixed transaction replay on non-btrfs after ill-timed failure=
s
> > =A0* osd: several recovery fixes
> > =A0* radosgw: improved PUT performance
> > =A0* radosgw: improved list objects performance, filtering
> > =A0* radosgw: manifests for large objects
> > =A0* radosgw: Swift/S3 ACL interoperability (last set ACL type wins)
> > =A0* librados: new key/value object API
> > =A0* Ubuntu 12.04 precise packages
> >
> > The exciting part of this release is that the key/value "object map"
> > work has been merged, along with radosgw changes to take advantage of t=
he
> > new API. =A0This allows you to use a key/value interface to manage many
> > small records in a single object, in addition of the regular object dat=
a
> > and attributes. =A0Keys in the same object are stored together on disk-=
-just
> > like object data would be--so there are locality advantages to putting
> > related keys in the same object. =A0However, there are no limits on how=
 many
> > keys per object beyond concerns about load and space balancing (all key=
s
> > in an object are stored together on the same set of Ceph OSDs). =A0This
> > provides an interesting alternative to conventional distributed key/val=
ue
> > stores like Cassandra that distribute all keys in a single namespace
> > across all nodes. =A0For example, radosgw now uses the new object map A=
PI to
> > manage the index object for each bucket.
> >
> > For v0.45, we're continuing work on RBD caching, performance and bug
> > fixes, and working around xattr size limitations in ext3/4.
> >
> > You can get v0.44 from the usual locations:
> >
> > =A0* Git at git://github.com/ceph/ceph.git
> > =A0* Tarball at http://ceph.newdream.net/download/ceph-0.44.tar.gz
> > =A0* For Debian/Ubuntu packages, see
> > =A0 http://ceph.newdream.net/docs/master/ops/install/mkcephfs/#installi=
ng-the-packages
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-635723547-1332357281=:558--
