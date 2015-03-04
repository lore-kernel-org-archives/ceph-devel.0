From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] v0.93 Hammer release candidate released
Date: Wed, 4 Mar 2015 09:02:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503040900440.25972@cobra.newdream.net>
References: <alpine.DEB.2.00.1502271408230.1577@cobra.newdream.net> <1425461806.2315.38.camel@cloud-solutions.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1156463760-1425488578=:25972"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59401 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758705AbbCDRC7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 12:02:59 -0500
In-Reply-To: <1425461806.2315.38.camel@cloud-solutions.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Lemarchand <thomas.lemarchand@cloud-solutions.fr>
Cc: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1156463760-1425488578=:25972
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2015, Thomas Lemarchand wrote:
> Thanks to all Ceph developers for the good work !
>=20
> I see some love given to CephFS. When will you consider CephFS to be
> production ready ?

The key missing piece is fsck (check and repair).  That's where our=20
efforts are focused now.  I think infernalis will have something pretty=20
reasonable?

> I use CephFS in production since Giant, and apart from the "cache
> pressure health warning" bug, now resolved, I didn't have a single
> problem.

That's great to hear!

sage

>=20
> --=20
> Thomas Lemarchand
> Cloud Solutions SAS - Responsable des syst=C3=A8mes d'information
>=20
>=20
>=20
> On ven., 2015-02-27 at 14:10 -0800, Sage Weil wrote:
> > This is the first release candidate for Hammer, and includes all of
> > the features that will be present in the final release.  We welcome
> > and encourage any and all testing in non-production clusters to ident=
ify
> > any problems with functionality, stability, or performance before the
> > final Hammer release.
> >=20
> > We suggest some caution in one area: librbd.  There is a lot of new
> > functionality around object maps and locking that is disabled by
> > default but may still affect stability for existing images.  We are
> > continuing to shake out those bugs so that the final Hammer release
> > (probably v0.94) will be stable.
> >=20
> > Major features since Giant include:
> >=20
> > * cephfs: journal scavenger repair tool (John Spray)
> > * crush: new and improved straw2 bucket type (Sage Weil, Christina=20
> >   Anderson, Xiaoxi Chen)
> > * doc: improved guidance for CephFS early adopters (John Spray)
> > * librbd: add per-image object map for improved performance (Jason=20
> >   Dillaman)
> > * librbd: copy-on-read (Min Chen, Li Wang, Yunchuan Wen, Cheng Cheng)
> > * librados: fadvise-style IO hints (Jianpeng Ma)
> > * mds: many many snapshot-related fixes (Yan, Zheng)
> > * mon: new 'ceph osd df' command (Mykola Golub)
> > * mon: new 'ceph pg ls ...' command (Xinxin Shu)
> > * osd: improved performance for high-performance backends
> > * osd: improved recovery behavior (Samuel Just)
> > * osd: improved cache tier behavior with reads (Zhiqiang Wang)
> > * rgw: S3-compatible bucket versioning support (Yehuda Sadeh)
> > * rgw: large bucket index sharding (Guang Yang, Yehuda Sadeh)
> > * RDMA "xio" messenger support (Matt Benjamin, Vu Pham)
> >=20
> > Upgrading
> > ---------
> >=20
> > * No special restrictions when upgrading from firefly or giant
> >=20
> > Notable Changes
> > ---------------
> >=20
> > * build: CMake support (Ali Maredia, Casey Bodley, Adam Emerson, Marc=
us=20
> >   Watts, Matt Benjamin)
> > * ceph-disk: do not re-use partition if encryption is required (Loic=20
> >   Dachary)
> > * ceph-disk: support LUKS for encrypted partitions (Andrew Bartlett, =
Loic=20
> >   Dachary)
> > * ceph-fuse,libcephfs: add support for O_NOFOLLOW and O_PATH (Greg Fa=
rnum)
> > * ceph-fuse,libcephfs: resend requests before completing cap reconnec=
t=20
> >   (#10912 Yan, Zheng)
> > * ceph-fuse: select kernel cache invalidation mechanism based on kern=
el=20
> >   version (Greg Farnum)
> > * ceph-objectstore-tool: improved import (David Zafman)
> > * ceph-objectstore-tool: misc improvements, fixes (#9870 #9871 David=20
> >   Zafman)
> > * ceph: add 'ceph osd df [tree]' command (#10452 Mykola Golub)
> > * ceph: fix 'ceph tell ...' command validation (#10439 Joao Eduardo L=
uis)
> > * ceph: improve 'ceph osd tree' output (Mykola Golub)
> > * cephfs-journal-tool: add recover_dentries function (#9883 John Spra=
y)
> > * common: add newline to flushed json output (Sage Weil)
> > * common: filtering for 'perf dump' (John Spray)
> > * common: fix Formatter factory breakage (#10547 Loic Dachary)
> > * common: make json-pretty output prettier (Sage Weil)
> > * crush: new and improved straw2 bucket type (Sage Weil, Christina=20
> >   Anderson, Xiaoxi Chen)
> > * crush: update tries stats for indep rules (#10349 Loic Dachary)
> > * crush: use larger choose_tries value for erasure code rulesets (#10=
353=20
> >   Loic Dachary)
> > * debian,rpm: move RBD udev rules to ceph-common (#10864 Ken Dreyer)
> > * debian: split python-ceph into python-{rbd,rados,cephfs} (Boris Ran=
to)
> > * doc: CephFS disaster recovery guidance (John Spray)
> > * doc: CephFS for early adopters (John Spray)
> > * doc: fix OpenStack Glance docs (#10478 Sebastien Han)
> > * doc: misc updates (#9793 #9922 #10204 #10203 Travis Rhoden, Hazem,=20
> >   Ayari, Florian Coste, Andy Allan, Frank Yu, Baptiste Veuillez-Maina=
rd,=20
> >   Yuan Zhou, Armando Segnini, Robert Jansen, Tyler Brekke, Viktor Sup=
run)
> > * doc: replace cloudfiles with swiftclient Python Swift example (Tim=20
> >   Freund)
> > * erasure-code: add mSHEC erasure code support (Takeshi Miyamae)
> > * erasure-code: improved docs (#10340 Loic Dachary)
> > * erasure-code: set max_size to 20 (#10363 Loic Dachary)
> > * libcephfs,ceph-fuse: fix getting zero-length xattr (#10552 Yan, Zhe=
ng)
> > * librados: add blacklist_add convenience method (Jason Dillaman)
> > * librados: expose rados_{read|write}_op_assert_version in C API (Kim=
=20
> >   Vandry)
> > * librados: fix pool name caching (#10458 Radoslaw Zarzynski)
> > * librados: fix resource leak, misc bugs (#10425 Radoslaw Zarzynski)
> > * librados: fix some watch/notify locking (Jason Dillaman, Josh Durgi=
n)
> > * libradosstriper: fix write_full when ENOENT (#10758 Sebastien Ponce=
)
> > * librbd: CRC protection for RBD image map (Jason Dillaman)
> > * librbd: add per-image object map for improved performance (Jason=20
> >   Dillaman)
> > * librbd: add support for an "object map" indicating which objects ex=
ist=20
> >   (Jason Dillaman)
> > * librbd: adjust internal locking (Josh Durgin, Jason Dillaman)
> > * librbd: better handling of watch errors (Jason Dillaman)
> > * librbd: coordinate maint operations through lock owner (Jason Dilla=
man)
> > * librbd: copy-on-read (Min Chen, Li Wang, Yunchuan Wen, Cheng Cheng,=
=20
> >   Jason Dillaman)
> > * librbd: enforce write ordering with a snapshot (Jason Dillaman)
> > * librbd: fadvise-style hints; add misc hints for certain operations=20
> >   (Jianpeng Ma)
> > * librbd: fix coverity false-positives (Jason Dillaman)
> > * librbd: fix snap create races (Jason Dillaman)
> > * librbd: flush AIO operations asynchronously (#10714 Jason Dillaman)
> > * librbd: make async versions of long-running maint operations (Jason=
=20
> >   Dillaman)
> > * librbd: mock tests (Jason Dillaman)
> > * librbd: optionally blacklist clients before breaking locks (#10761 =
Jason=20
> >   Dillaman)
> > * librbd: prevent copyup during shrink (Jason Dillaman)
> > * mds: add cephfs-table-tool (John Spray)
> > * mds: avoid sending traceless replies in most cases (Yan, Zheng)
> > * mds: export dir asok command (John Spray)
> > * mds: fix stray/purge perfcounters (#10388 John Spray)
> > * mds: handle heartbeat_reset during shutdown (#10382 John Spray)
> > * mds: many many snapshot-related fixes (Yan, Zheng)
> > * mds: refactor, improve Session storage (John Spray)
> > * misc coverity fixes (Danny Al-Gaaf)
> > * mon: add noforward flag for some mon commands (Mykola Golub)
> > * mon: disallow empty pool names (#10555 Wido den Hollander)
> > * mon: do not deactivate last mds (#10862 John Spray)
> > * mon: drop old ceph_mon_store_converter (Sage Weil)
> > * mon: fix 'ceph pg dump_stuck degraded' (Xinxin Shu)
> > * mon: fix 'profile osd' use of config-key function on mon (#10844 Jo=
ao=20
> >   Eduardo Luis)
> > * mon: fix compatset initalization during mkfs (Joao Eduardo Luis)
> > * mon: fix feature tracking during elections (Joao Eduardo Luis)
> > * mon: fix mds gid/rank/state parsing (John Spray)
> > * mon: ignore failure reports from before up_from (#10762 Dan van der=
=20
> >   Ster, Sage Weil)
> > * mon: improved corrupt CRUSH map detection (Joao Eduardo Luis)
> > * mon: include pg_temp count in osdmap summary (Sage Weil)
> > * mon: log health summary to cluster log (#9440 Joao Eduardo Luis)
> > * mon: make 'mds fail' idempotent (John Spray)
> > * mon: make pg dump {sum,pgs,pgs_brief} work for format=3Dplain (#596=
3 #6759=20
> >   Mykola Golub)
> > * mon: new pool safety flags nodelete, nopgchange, nosizechange (#979=
2=20
> >   Mykola Golub)
> > * mon: new, friendly 'ceph pg ls ...' command (Xinxin Shu)
> > * mon: prevent MDS transition from STOPPING (#10791 Greg Farnum)
> > * mon: propose all pending work in one transaction (Sage Weil)
> > * mon: remove pg_temps for nonexistent pools (Joao Eduardo Luis)
> > * mon: require mon_allow_pool_delete option to remove pools (Sage Wei=
l)
> > * mon: set globalid prealloc to larger value (Sage Weil)
> > * mon: skip zeroed osd stats in get_rule_avail (#10257 Joao Eduardo L=
uis)
> > * mon: validate min_size range (Jianpeng Ma)
> > * msgr: async: bind threads to CPU cores, improved poll (Haomai Wang)
> > * msgr: fix crc configuration (Mykola Golub)
> > * msgr: misc unit tests (Haomai Wang)
> > * msgr: xio: XioMessenger RDMA support (Casey Bodley, Vu Pham, Matt=20
> >   Benjamin)
> > * osd, librados: fadvise-style librados hints (Jianpeng Ma)
> > * osd, librados: fix xattr_cmp_u64 (Dongmao Zhang)
> > * osd,mon: add 'norebalance' flag (Kefu Chai)
> > * osd,mon: specify OSD features explicitly in MOSDBoot (#10911 Sage W=
eil)
> > * osd: add option to prioritize heartbeat network traffic (Jian Wen)
> > * osd: add support for the SHEC erasure-code algorithm (****, Loic=20
> >   Dachary)
> > * osd: allow recovery while below min_size (Samuel Just)
> > * osd: allow recovery with fewer than min_size OSDs (Samuel Just)
> > * osd: allow writes to degraded objects (Samuel Just)
> > * osd: allow writes to degraded objects (Samuel Just)
> > * osd: avoid publishing unchanged PG stats (Sage Weil)
> > * osd: cache recent ObjectContexts (Dong Yuan)
> > * osd: clear cache on interval change (Samuel Just)
> > * osd: do no proxy reads unless target OSDs are new (#10788 Sage Weil=
)
> > * osd: do not update digest on inconsistent object (#10524 Samuel Jus=
t)
> > * osd: don't record digests for snapdirs (#10536 Samuel Just)
> > * osd: fix OSDCap parser on old (el6) boost::spirit (#10757 Kefu Chai=
)
> > * osd: fix OSDCap parsing on el6 (#10757 Kefu Chai)
> > * osd: fix ObjectStore::Transaction encoding version (#10734 Samuel J=
ust)
> > * osd: fix auth object selection during repair (#10524 Samuel Just)
> > * osd: fix bug in pending digest updates (#10840 Samuel Just)
> > * osd: fix cancel_proxy_read_ops (Sage Weil)
> > * osd: fix cleanup of interrupted pg deletion (#10617 Sage Weil)
> > * osd: fix journal wrapping bug (#10883 David Zafman)
> > * osd: fix leak in SnapTrimWQ (#10421 Kefu Chai)
> > * osd: fix memstore free space calculation (Xiaoxi Chen)
> > * osd: fix mixed-version peering issues (Samuel Just)
> > * osd: fix object digest update bug (#10840 Samuel Just)
> > * osd: fix ordering issue with new transaction encoding (#10534 Dong =
Yuan)
> > * osd: fix past_interval generation (#10427 #10430 David Zafman)
> > * osd: fix short read handling on push (#8121 David Zafman)
> > * osd: fix watch timeout cache state update (#10784 David Zafman)
> > * osd: force promotion of watch/notify ops (Zhiqiang Wang)
> > * osd: improve idempotency detection across cache promotion/demotion=20
> >   (#8935 Sage Weil, Samuel Just)
> > * osd: include activating peers in blocked_by (#10477 Sage Weil)
> > * osd: jerasure and gf-complete updates from upstream (#10216 Loic=20
> >   Dachary)
> > * osd: journal: check fsync/fdatasync result (Jianpeng Ma)
> > * osd: journal: fix hang on shutdown (#10474 David Zafman)
> > * osd: journal: fix header.committed_up_to (Xinze Chi)
> > * osd: journal: initialize throttle (Ning Yao)
> > * osd: journal: misc bug fixes (#6003 David Zafman, Samuel Just)
> > * osd: misc cleanup (Xinze Chi, Yongyue Sun)
> > * osd: new 'activating' state between peering and active (Sage Weil)
> > * osd: preserve reqids for idempotency checks for promote/demote (Sag=
e=20
> >   Weil, Zhiqiang Wang, Samuel Just)
> > * osd: remove dead locking code (Xinxin Shu)
> > * osd: restrict scrub to certain times of day (Xinze Chi)
> > * osd: rocksdb: fix shutdown (Hoamai Wang)
> > * pybind: fix memory leak in librados bindings (Billy Olsen)
> > * qa: fix mds tests (#10539 John Spray)
> > * qa: ignore duplicates in rados ls (Josh Durgin)
> > * qa: improve hadoop tests (Noah Watkins)
> > * qa: reorg fs quota tests (Greg Farnum)
> > * rados: fix usage (Jianpeng Ma)
> > * radosgw-admin: add replicalog update command (Yehuda Sadeh)
> > * rbd-fuse: clean up on shutdown (Josh Durgin)
> > * rbd: add 'merge-diff' function (MingXin Liu, Yunchuan Wen, Li Wang)
> > * rbd: fix buffer handling on image import (#10590 Jason Dillaman)
> > * rbd: leave exclusive lockin goff by default (Jason Dillaman)
> > * rbd: update init-rbdmap to fix dup mount point (Karel Striegel)
> > * rbd: use IO hints for import, export, and bench operations (#10462 =
Jason=20
> >   Dillaman)
> > * rbd_recover_tool: RBD image recovery tool (Min Chen)
> > * rgw: S3-style object versioning support (Yehuda Sadeh)
> > * rgw: check keystone auth for S3 POST requests (#10062 Abhishek=20
> >   Lekshmanan)
> > * rgw: extend replica log API (purge-all) (Yehuda Sadeh)
> > * rgw: fail S3 POST if keystone not configured (#10688 Valery Tschopp=
,=20
> >   Yehuda Sadeh)
> > * rgw: fix XML header on get ACL request (#10106 Yehuda Sadeh)
> > * rgw: fix bucket removal with data purge (Yehuda Sadeh)
> > * rgw: fix replica log indexing (#8251 Yehuda Sadeh)
> > * rgw: fix swift metadata header name (Dmytro Iurchenko)
> > * rgw: remove multipart entries from bucket index on abort (#10719 Ye=
huda=20
> >   Sadeh)
> > * rgw: respond with 204 to POST on containers (#10667 Yuan Zhou)
> > * rgw: reuse fcgx connection struct (#10194 Yehuda Sadeh)
> > * rgw: support multiple host names (#7467 Yehuda Sadeh)
> > * rgw: swift: dump container's custom metadata (#10665 Ahmad Faheem,=20
> >   Dmytro Iurchenko)
> > * rgw: swift: support Accept header for response format (#10746 Dmytr=
o=20
> >   Iurchenko)
> > * rgw: swift: support for X-Remove-Container-Meta-{key} (#10475 Dmytr=
o=20
> >   Iurchenko)
> > * rpm: move rgw logrotate to radosgw subpackage (Ken Dreyer)
> > * tests: centos-6 dockerfile (#10755 Loic Dachary)
> > * tests: unit tests for shared_cache (Dong Yuan)
> > * vstart.sh: work with cmake (Yehuda Sadeh)
> >=20
> > Getting Ceph
> > ------------
> >=20
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://ceph.com/download/ceph-0.93.tar.gz
> > * For packages, see http://ceph.com/docs/master/install/get-packages
> > * For ceph-deploy, see http://ceph.com/docs/master/install/install-ce=
ph-deploy
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >=20
>=20
>=20
> --=20
> This message has been scanned for viruses and
> dangerous content by MailScanner, and is
> believed to be clean.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1156463760-1425488578=:25972--
