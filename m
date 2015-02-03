From: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.92 released
Date: Tue, 3 Feb 2015 13:33:17 -0800
Message-ID: <CA+4uBUZTPTs3NPi7pJss19Y=1QGddQbNqQAV7hrxh1wEV0-YQQ@mail.gmail.com>
References: <alpine.DEB.2.00.1502030738070.31320@cobra.newdream.net>
Reply-To: sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1502030738070.31320-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

There seems to be a bug with the transaction encoding when upgrading
from v0.91 to v0.92.  Users probably want to hold off on upgrading to
v0.92 until http://tracker.ceph.com/issues/10734 is resolved.
-Sam

On Tue, Feb 3, 2015 at 7:40 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> This is the second-to-last chunk of new stuff before Hammer.  Big items
> include additional checksums on OSD objects, proxied reads in the
> cache tier, image locking in RBD, optimized OSD Transaction and
> replication messages, and a big pile of RGW and MDS bug fixes.
>
> Upgrading
> ---------
>
> * The experimental 'keyvaluestore-dev' OSD backend has been renamed
>   'keyvaluestore' (for simplicity) and marked as experimental.  To
>   enable this untested feature and acknowledge that you understand
>   that it is untested and may destroy data, you need to add the
>   following to your ceph.conf::
>
>     enable experimental unrecoverable data corrupting featuers =
> keyvaluestore
>
> * The following librados C API function calls take a 'flags' argument
>   whose value is now correctly interpreted:
>
>      rados_write_op_operate()
>      rados_aio_write_op_operate()
>      rados_read_op_operate()
>      rados_aio_read_op_operate()
>
>   The flags were not correctly being translated from the librados
>   constants to the internal values.  Now they are.  Any code that is
>   passing flags to these methods should be audited to ensure that they are
>   using the correct LIBRADOS_OP_FLAG_* constants.
>
> * The 'rados' CLI 'copy' and 'cppool' commands now use the copy-from
>   operation, which means the latest CLI cannot run these commands against
>   pre-firefly OSDs.
>
> * The librados watch/notify API now includes a watch_flush() operation to
>   flush the async queue of notify operations.  This should be called by
>   any watch/notify user prior to rados_shutdown().
>
> Notable Changes
> ---------------
>
> * add experimental features option (Sage Weil)
> * build: fix 'make check' races (#10384 Loic Dachary)
> * build: fix pkg names when libkeyutils is missing (Pankag Garg, Ken
>   Dreyer)
> * ceph: make 'ceph -s' show PG state counts in sorted order (Sage Weil)
> * ceph: make 'ceph tell mon.* version' work (Mykola Golub)
> * ceph-monstore-tool: fix/improve CLI (Joao Eduardo Luis)
> * ceph: show primary-affinity in 'ceph osd tree' (Mykola Golub)
> * common: add TableFormatter (Andreas Peters)
> * common: check syncfs() return code (Jianpeng Ma)
> * doc: do not suggest dangerous XFS nobarrier option (Dan van der Ster)
> * doc: misc updates (Nilamdyuti Goswami, John Wilkins)
> * install-deps.sh: do not require sudo when root (Loic Dachary)
> * libcephfs: fix dirfrag trimming (#10387 Yan, Zheng)
> * libcephfs: fix mount timeout (#10041 Yan, Zheng)
> * libcephfs: fix test (#10415 Yan, Zheng)
> * libcephfs: fix use-afer-free on umount (#10412 Yan, Zheng)
> * libcephfs: include ceph and git version in client metadata (Sage Weil)
> * librados: add watch_flush() operation (Sage Weil, Haomai Wang)
> * librados: avoid memcpy on getxattr, read (Jianpeng Ma)
> * librados: create ioctx by pool id (Jason Dillaman)
> * librados: do notify completion in fast-dispatch (Sage Weil)
> * librados: remove shadowed variable (Kefu Chain)
> * librados: translate op flags from C APIs (Matthew Richards)
> * librbd: differentiate between R/O vs R/W features (Jason Dillaman)
> * librbd: exclusive image locking (Jason Dillaman)
> * librbd: fix write vs import race (#10590 Jason Dillaman)
> * librbd: gracefully handle deleted/renamed pools (#10270 Jason Dillaman)
> * mds: asok command for fetching subtree map (John Spray)
> * mds: constify MDSCacheObjects (John Spray)
> * misc: various valgrind fixes and cleanups (Danny Al-Gaaf)
> * mon: fix 'mds fail' for standby MDSs (John Spray)
> * mon: fix stashed monmap encoding (#5203 Xie Rui)
> * mon: implement 'fs reset' command (John Spray)
> * mon: respect down flag when promoting standbys (John Spray)
> * mount.ceph: fix suprious error message (#10351 Yan, Zheng)
> * msgr: async: many fixes, unit tests (Haomai Wang)
> * msgr: simple: retry binding to port on failure (#10029 Wido den
>   Hollander)
> * osd: add fadvise flags to ObjectStore API (Jianpeng Ma)
> * osd: add get_latest_osdmap asok command (#9483 #9484 Mykola Golub)
> * osd: EIO on whole-object reads when checksum is wrong (Sage Weil)
> * osd: filejournal: don't cache journal when not using direct IO (Jianpeng
>   Ma)
> * osd: fix ioprio option (Mykola Golub)
> * osd: fix scrub delay bug (#10693 Samuel Just)
> * osd: fix watch reconnect race (#10441 Sage Weil)
> * osd: handle no-op write with snapshot (#10262 Sage Weil)
> * osd: journal: fix journal zeroing when direct IO is enabled (Xie Rui)
> * osd: keyvaluestore: cleanup dead code (Ning Yao)
> * osd, mds: 'ops' as shorthand for 'dump_ops_in_flight' on asok (Sage
>   Weil)
> * osd: memstore: fix size limit (Xiaoxi Chen)
> * osd: misc scrub fixes (#10017 Loic Dachary)
> * osd: new optimized encoding for ObjectStore::Transaction (Dong Yuan)
> * osd: optimize filter_snapc (Ning Yao)
> * osd: optimize WBThrottle map with unordered_map (Ning Yao)
> * osd: proxy reads during cache promote (Zhiqiang Wang)
> * osd: proxy read support (Zhiqiang Wang)
> * osd: remove legacy classic scrub code (Sage Weil)
> * osd: remove unused fields in MOSDSubOp (Xiaoxi Chen)
> * osd: replace MOSDSubOp messages with simpler, optimized MOSDRepOp
>   (Xiaoxi Chen)
> * osd: store whole-object checksums on scrub, write_full (Sage Weil)
> * osd: verify kernel is new enough before using XFS extsize ioctl, enable
>   by default (#9956 Sage Weil)
> * rados: use copy-from operation for copy, cppool (Sage Weil)
> * rgw: change multipart upload id magic (#10271 Yehuda Sadeh)
> * rgw: decode http query params correction (#10271 Yehuda Sadeh)
> * rgw: fix content length check (#10701 Axel Dunkel, Yehuda Sadeh)
> * rgw: fix partial GET in swift (#10553 Yehuda Sadeh)
> * rgw: fix shutdown (#10472 Yehuda Sadeh)
> * rgw: include XML ns on get ACL request (#10106 Yehuda Sadeh)
> * rgw: misc fixes (#10307 Yehuda Sadeh)
> * rgw: only track cleanup for objects we write (#10311 Yehuda Sadeh)
> * rgw: tweak error codes (#10329 #10334 Yehuda Sadeh)
> * rgw: use gc for multipart abort (#10445 Aaron Bassett, Yehuda Sadeh)
> * sysvinit: fix race in 'stop' (#10389 Loic Dachary)
> * test: fix bufferlist tests (Jianpeng Ma)
> * tests: improve docker-based tests (Loic Dachary)
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.92.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
