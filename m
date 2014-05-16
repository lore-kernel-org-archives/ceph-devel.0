From: Sage Weil <sage@inktank.com>
Subject: Re: Radosgw - bucket index
Date: Fri, 16 May 2014 06:09:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1472070531-1400245758=:28306"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58249 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbaEPNJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 09:09:26 -0400
In-Reply-To: <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl>
Content-ID: <alpine.DEB.2.00.1405160609250.28306@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang <yguang11@outlook.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, haomaiwang@gmail.com, Ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1472070531-1400245758=:28306
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1405160609251.28306@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

Hi Guang,

[I think the problem is that your email is HTML formatted, and vger=20
silently drops those.  Make sure your mailer is set to plain text mode.]

On Fri, 16 May 2014, Guang wrote:

>       * *Key/value OSD backend* (experimental): An alternative storage
>       backend
>       =A0for Ceph OSD processes that puts all data in a key/value
>       database like
>       =A0leveldb. =A0This provides better performance for workloads
>       dominated by
>       =A0key/value operations (like radosgw bucket indices).
>=20
> Hi Yehuda and Haomai,I managed to set up a K/V store backend and played
> around with it, as Sage mentioned in the release note, I thought K/V st=
ore
> could be the solution for radosgw?s bucket indexing feature which curre=
ntly
> has scaling problems [1], however, after playing around with K/V store =
and
> understanding the requirement for bucket indexing, I think at least for=
 now
> there is still gap to fix the bucket indexing by leveraging the K/V sto=
re.
>=20
> In my opinion, one requirement (API) to implement bucket indexing is to
> support ordered scan (prefix filter), which is not part of the API of r=
ados,
> and as K/V store does not extend the rados API (it is not supposed to) =
but
> only =A0change the underlying object store strategy. It is not likely t=
o help
> for the bucket indexing, except that we use the original way using omap=
 to
> store bucket indexing and each bucket corresponds to one object.

The rados omap API does allow a prefix filter, although it's somewhat=20
implicit:

    /**
     * omap_get_keys: keys from the object omap
     *
     * Get up to max_return keys beginning after start_after
     *
     * @param start_after [in] list keys starting after start_after
     * @parem max_return [in] list no more than max_return keys
     * @param out_keys [out] place returned values in out_keys on complet=
ion
     * @param prval [out] place error code in prval upon completion
     */
    void omap_get_keys(const std::string &start_after,
                       uint64_t max_return,
                       std::set<std::string> *out_keys,
                       int *prval);

Since all keys are sorted alphanumerically, you simply have to set=20
start_after =3D=3D your prefix, and start ignoring the results once you g=
et a=20
key that does not contain your prefix.  This could be improved by having=20
an explicit prefix argument that does this server-side, but for now at yo=
u=20
can get the right data (plus a bit a extra at the end).

Is that what you mean by prefix scan, or are you referring to the ability=
=20
to scan for rados objects that begin with a prefix?  If it's the latter,=20
you are right: objects are hashed across nodes and there is no sorted=20
object name index to allow prefix filtering.  There is a list_objects=20
filter option, but it is still O(objects in the pool).

> Did I miss anything obvious here?
>=20
> We are very interested in the effort to improve the scalability of buck=
et
> index [1] as the blueprint mentioned, here is my thoughts on top of thi=
s:
> =A01. It would be nice we can refactor the interface so that it is easy=
 to
> switch to a different underlying storage system for bucket indexing, fo=
r
> example, DynamoDB seems like being used for S3?s implementation [2], an=
d SWIFT
> uses sqllite [1] and has a flat namespace for listing purpose (with pre=
fix
> and delimiter).

radosgw is using the omap key/value API for objects, which is more or les=
s=20
equivalent to what swift is doing with sqlite.  This data passes straight=
=20
into leveldb on the backend (or whatever other backend you are using). =20
Using something like rocksdb in its place is pretty simple and ther are
unmerged patches to do that; the user would just need to adjust their=20
crush map so that the rgw index pool is mapped to a different set of OSDs=
=20
with the better k/v backend.

> =A02. As mentioned in the blueprint, if we go with the approach to do s=
harding
> for the bucket index object, what is the design choice? Are we going to
> maintain a B- tree structure get all keys sorted and sharidng on demand=
,
> like having a background thread do the sharding when it reaches a certa=
in
> threshold?=A0

I don't know... I'm sure Yehuda has a more well-formed opinion on this.  =
I=20
suspect something simpler than a B tree (like a single-level hash-based=20
fan out) would be sufficient, although you'd pay a bit of a price for=20
object enumeration.

sage



>=20
> [1]=A0https://wiki.ceph.com/Planning/Sideboard/rgw%3A_bucket_index_scal=
abilit
> y
> [2]=A0http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Q=
ueryAn
> dScan.html
> [3]=A0https://swiftstack.com/openstack-swift/architecture/
>=20
> Thanks,
> Guang
>=20
> On May 7, 2014, at 9:05 AM, Sage Weil <sage@inktank.com> wrote:
>=20
>       We did it! =A0Firefly v0.80 is built and pushed out to the
>       ceph.com
>       repositories.
>=20
>       This release will form the basis for our long-term supported
>       release
>       Firefly, v0.80.x. =A0The big new features are support for erasure
>       coding
>       and cache tiering, although a broad range of other features,
>       fixes,
>       and improvements have been made across the code base.
>       =A0Highlights include:
>=20
>       * *Erasure coding*: support for a broad range of erasure codes
>       for lower
>       =A0storage overhead and better data durability.
>       * *Cache tiering*: support for creating 'cache pools' that store
>       hot,
>       =A0recently accessed objects with automatic demotion of colder
>       data to
>       =A0a base tier. =A0Typically the cache pool is backed by faster
>       storage
>       =A0devices like SSDs.
>       * *Primary affinity*: Ceph now has the ability to skew selection
>       of
>       =A0OSDs as the "primary" copy, which allows the read workload to
>       be
>       =A0cheaply skewed away from parts of the cluster without migratin=
g
>       any
>       =A0data.
>       * *Key/value OSD backend* (experimental): An alternative storage
>       backend
>       =A0for Ceph OSD processes that puts all data in a key/value
>       database like
>       =A0leveldb. =A0This provides better performance for workloads
>       dominated by
>       =A0key/value operations (like radosgw bucket indices).
>       * *Standalone radosgw* (experimental): The radosgw process can
>       now run
>       =A0in a standalone mode without an apache (or similar) web server
>       or
>       =A0fastcgi. =A0This simplifies deployment and can improve
>       performance.
>=20
>       We expect to maintain a series of stable releases based on v0.80
>       Firefly for as much as a year. =A0In the meantime, development of
>       Ceph
>       continues with the next release, Giant, which will feature work
>       on the
>       CephFS distributed file system, more alternative storage
>       backends
>       (like RocksDB and f2fs), RDMA support, support for pyramid
>       erasure
>       codes, and additional functionality in the block device (RBD)
>       like
>       copy-on-read and multisite mirroring.
>=20
>       This release is the culmination of a huge collective effort by
>       about 100
>       different contributors. =A0Thank you everyone who has helped to
>       make this
>       possible!
>=20
>       Upgrade Sequencing
>       ------------------
>=20
>       * If your existing cluster is running a version older than v0.67
>       =A0Dumpling, please first upgrade to the latest Dumpling release
>       before
>       =A0upgrading to v0.80 Firefly. =A0Please refer to the :ref:`Dumpl=
ing
>       upgrade`
>       =A0documentation.
>=20
>       * Upgrade daemons in the following order:
>=20
>       =A0=A0=A01. Monitors
>       =A0=A0=A02. OSDs
>       =A0=A0=A03. MDSs and/or radosgw
>=20
>       =A0If the ceph-mds daemon is restarted first, it will wait until
>       all
>       =A0OSDs have been upgraded before finishing its startup sequence.
>       =A0If
>       =A0the ceph-mon daemons are not restarted prior to the ceph-osd
>       =A0daemons, they will not correctly register their new
>       capabilities
>       =A0with the cluster and new features may not be usable until they
>       are
>       =A0restarted a second time.
>=20
>       * Upgrade radosgw daemons together. =A0There is a subtle change i=
n
>       behavior
>       =A0for multipart uploads that prevents a multipart request that
>       was initiated
>       =A0with a new radosgw from being completed by an old radosgw.
>=20
>       Notable changes since v0.79
>       ---------------------------
>=20
>       * ceph-fuse, libcephfs: fix several caching bugs (Yan, Zheng)
>       * ceph-fuse: trim inodes in response to mds memory pressure
>       (Yan, Zheng)
>       * librados: fix inconsistencies in API error values (David
>       Zafman)
>       * librados: fix watch operations with cache pools (Sage Weil)
>       * librados: new snap rollback operation (David Zafman)
>       * mds: fix respawn (John Spray)
>       * mds: misc bugs (Yan, Zheng)
>       * mds: misc multi-mds fixes (Yan, Zheng)
>       * mds: use shared_ptr for requests (Greg Farnum)
>       * mon: fix peer feature checks (Sage Weil)
>       * mon: require 'x' mon caps for auth operations (Joao Luis)
>       * mon: shutdown when removed from mon cluster (Joao Luis)
>       * msgr: fix locking bug in authentication (Josh Durgin)
>       * osd: fix bug in journal replay/restart (Sage Weil)
>       * osd: many many many bug fixes with cache tiering (Samuel Just)
>       * osd: track omap and hit_set objects in pg stats (Samuel Just)
>       * osd: warn if agent cannot enable due to invalid (post-split)
>       stats (Sage Weil)
>       * rados bench: track metadata for multiple runs separately
>       (Guang Yang)
>       * rgw: fixed subuser modify (Yehuda Sadeh)
>       * rpm: fix redhat-lsb dependency (Sage Weil, Alfredo Deza)
>=20
>       For the complete release notes, please see:
>=20
>       =A0=A0http://ceph.com/docs/master/release-notes/#v0-80-firefly
>=20
>=20
>       Getting Ceph
>       ------------
>=20
>       * Git at git://github.com/ceph/ceph.git
>       * Tarball at http://ceph.com/download/ceph-0.80.tar.gz
>       * For packages, see
>       http://ceph.com/docs/master/install/get-packages
>       * For ceph-deploy, see
>       http://ceph.com/docs/master/install/install-ceph-deploy
>=20
>       --
>       To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at
>       =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
--557981400-1472070531-1400245758=:28306--
