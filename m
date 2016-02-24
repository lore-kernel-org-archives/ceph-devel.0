From: Dan van der Ster <dan@vanderster.com>
Subject: Re: v0.94.6 Hammer released
Date: Wed, 24 Feb 2016 10:31:01 +0100
Message-ID: <CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34656 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcBXJbo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 04:31:44 -0500
Received: by mail-lb0-f175.google.com with SMTP id of3so6903119lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 01:31:43 -0800 (PST)
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com. [209.85.217.174])
        by smtp.gmail.com with ESMTPSA id r191sm254329lfe.28.2016.02.24.01.31.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 01:31:41 -0800 (PST)
Received: by mail-lb0-f174.google.com with SMTP id of3so6902608lbc.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 01:31:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Thanks Sage, looking forward to some scrub randomization.

Were binaries built for el6? http://download.ceph.com/rpm-hammer/el6/x8=
6_64/

Cheers, Dan


On Tue, Feb 23, 2016 at 5:01 PM, Sage Weil <sage@redhat.com> wrote:
> This Hammer point release fixes a range of bugs, most notably a fix f=
or
> unbounded growth of the monitor=E2=80=99s leveldb store, and a workar=
ound in the
> OSD to keep most xattrs small enough to be stored inline in XFS inode=
s.
>
> We recommend that all hammer v0.94.x users upgrade.
>
> For more detailed information, see the complete changelog:
>
>   http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt
>
> Notable Changes
> ---------------
>
> * build/ops: Ceph daemon failed to start, because the service name wa=
s already used. (#13474, Chuanhong Wang)
> * build/ops: LTTng-UST tracing should be dynamically enabled (#13274,=
 Jason Dillaman)
> * build/ops: ceph upstart script rbdmap.conf incorrectly processes pa=
rameters (#13214, Sage Weil)
> * build/ops: ceph.spec.in License line does not reflect COPYING (#129=
35, Nathan Cutler)
> * build/ops: ceph.spec.in libcephfs_jni1 has no %post and %postun  (#=
12927, Owen Synge)
> * build/ops: configure.ac: no use to add "+" before ac_ext=3Dc (#1433=
0, Kefu Chai, Robin H. Johnson)
> * build/ops: deb: strip tracepoint libraries from Wheezy/Precise buil=
ds (#14801, Jason Dillaman)
> * build/ops: init script reload doesn't work on EL7 (#13709, Herv=C3=A9=
 Rousseau)
> * build/ops: init-rbdmap uses distro-specific functions (#12415, Bori=
s Ranto)
> * build/ops: logrotate reload error on Ubuntu 14.04 (#11330, Sage Wei=
l)
> * build/ops: miscellaneous spec file fixes (#12931, #12994, #12924, #=
12360, Boris Ranto, Nathan Cutler, Owen Synge, Travis Rhoden, Ken Dreye=
r)
> * build/ops: pass tcmalloc env through to ceph-os (#14802, Sage Weil)
> * build/ops: rbd-replay-* moved from ceph-test-dbg to ceph-common-dbg=
 as well (#13785, Loic Dachary)
> * build/ops: unknown argument --quiet in udevadm settle (#13560, Jaso=
n Dillaman)
> * common: Objecter: pool op callback may hang forever. (#13642, xie x=
ingguo)
> * common: Objecter: potential null pointer access when do pool_snap_l=
ist. (#13639, xie xingguo)
> * common: ThreadPool add/remove work queue methods not thread safe (#=
12662, Jason Dillaman)
> * common: auth/cephx: large amounts of log are produced by osd (#1361=
0, Qiankun Zheng)
> * common: client nonce collision due to unshared pid namespaces (#130=
32, Josh Durgin)
> * common: common/Thread:pthread_attr_destroy(thread_attr) when done w=
ith it (#12570, Piotr Da=C5=82ek)
> * common: log: Log.cc: Assign LOG_DEBUG priority to syslog calls (#13=
993, Brad Hubbard)
> * common: objecter: cancellation bugs (#13071, Jianpeng Ma)
> * common: pure virtual method called (#13636, Jason Dillaman)
> * common: small probability sigabrt when setting rados_osd_op_timeout=
 (#13208, Ruifeng Yang)
> * common: wrong conditional for boolean function KeyServer::get_auth(=
) (#9756, #13424, Nathan Cutler)
> * crush: crash if we see CRUSH_ITEM_NONE in early rule step (#13477, =
Sage Weil)
> * doc: man: document listwatchers cmd in "rados" manpage (#14556, Kef=
u Chai)
> * doc: regenerate man pages, add orphans commands to radosgw-admin(8)=
 (#14637, Ken Dreyer)
> * fs: CephFS restriction on removing cache tiers is overly strict (#1=
1504, John Spray)
> * fs: fsstress.sh fails (#12710, Yan, Zheng)
> * librados: LibRadosWatchNotify.WatchNotify2Timeout (#13114, Sage Wei=
l)
> * librbd: ImageWatcher shouldn't block the notification thread (#1437=
3, Jason Dillaman)
> * librbd: diff_iterate needs to handle holes in parent images (#12885=
, Jason Dillaman)
> * librbd: fix merge-diff for >2GB diff-files (#14030, Jason Dillaman)
> * librbd: invalidate object map on error even w/o holding lock (#1337=
2, Jason Dillaman)
> * librbd: reads larger than cache size hang (#13164, Lu Shi)
> * mds: ceph mds add_data_pool check for EC pool is wrong (#12426, Joh=
n Spray)
> * mon: MonitorDBStore: get_next_key() only if prefix matches (#11786,=
 Joao Eduardo Luis)
> * mon: OSDMonitor: do not assume a session exists in send_incremental=
() (#14236, Joao Eduardo Luis)
> * mon: check for store writeablility before participating in election=
 (#13089, Sage Weil)
> * mon: compact full epochs also (#14537, Kefu Chai)
> * mon: include min_last_epoch_clean as part of PGMap::print_summary a=
nd PGMap::dump (#13198, Guang Yang)
> * mon: map_cache can become inaccurate if osd does not receive the os=
dmaps (#10930, Kefu Chai)
> * mon: should not set isvalid =3D true when cephx_verify_authorizer r=
eturn false (#13525, Ruifeng Yang)
> * osd: Ceph Pools' MAX AVAIL is 0 if some OSDs' weight is 0 (#13840, =
Chengyuan Li)
> * osd: FileStore calls syncfs(2) even it is not supported (#12512, Ke=
fu Chai)
> * osd: FileStore: potential memory leak if getattrs fails. (#13597, x=
ie xingguo)
> * osd: IO error on kvm/rbd with an erasure coded pool tier (#12012, K=
efu Chai)
> * osd: OSD::build_past_intervals_parallel() shall reset primary and u=
p_primary when begin a new past_interval. (#13471, xiexingguo)
> * osd: ReplicatedBackend: populate recovery_info.size for clone (bug =
symptom is size mismatch on replicated backend on a clone in scrub) (#1=
2828, Samuel Just)
> * osd: ReplicatedPG: wrong result code checking logic during sparse_r=
ead (#14151, xie xingguo)
> * osd: ReplicatedPG::hit_set_trim osd/ReplicatedPG.cc: 11006: FAILED =
assert(obc) (#13192, #9732, #12968, Kefu Chai, Zhiqiang Wang, Samuel Ju=
st, David Zafman)
> * osd: avoid multi set osd_op.outdata in tier pool (#12540, Xinze Chi=
)
> * osd: bug with cache/tiering and snapshot reads (#12748, Kefu Chai)
> * osd: ceph osd pool stats broken in hammer (#13843, BJ Lougee)
> * osd: ceph-disk prepare fails if device is a symlink (#13438, Joe Ju=
lian)
> * osd: check for full before changing the cached obc (hammer) (#13098=
, Alexey Sheplyakov)
> * osd: config_opts: increase suicide timeout to 300 to match recovery=
 (#14376, Samuel Just)
> * osd: disable filestore_xfs_extsize by default (#14397, Ken Dreyer)
> * osd: do not cache unused memory in attrs (#12565, Xinze Chi, Ning Y=
ao)
> * osd: dumpling incrementals do not work properly on hammer and newer=
 (#13234, Samuel Just)
> * osd: filestore: fix peek_queue for OpSequencer (#13209, Xinze Chi)
> * osd: hit set clear repops fired in same epoch as map change -- segf=
ault since they fall into the new interval even though the repops are c=
leared (#12809, Samuel Just)
> * osd: object_info_t::decode() has wrong version (#13462, David Zafma=
n)
> * osd: osd/OSD.cc: 2469: FAILED assert(pg_stat_queue.empty()) on shut=
down (#14212, Sage Weil)
> * osd: osd/PG.cc: 288: FAILED assert(info.last_epoch_started >=3D inf=
o.history.last_epoch_started) (#14015, David Zafman)
> * osd: osd/PG.cc: 3837: FAILED assert(0 =3D=3D "Running incompatible =
OSD") (#11661, David Zafman)
> * osd: osd/ReplicatedPG: Recency fix (#14320, Sage Weil, Robert LeBla=
nc)
> * osd: pg stuck in replay (#13116, Sage Weil)
> * osd: race condition detected during send_failures (#13821, Sage Wei=
l)
> * osd: randomize scrub times (#10973, Kefu Chai)
> * osd: requeue_scrub when kick_object_context_blocked (#12515, Xinze =
Chi)
> * osd: revert: use GMT time for hitsets (#13812, Loic Dachary)
> * osd: segfault in agent_work (#13199, Samuel Just)
> * osd: should recalc the min_last_epoch_clean when decode PGMap (#131=
12, Kefu Chai)
> * osd: smaller object_info_t xattrs (#14803, Sage Weil)
> * osd: we do not ignore notify from down osds (#12990, Samuel Just)
> * rbd: QEMU hangs after creating snapshot and stopping VM (#13726, Ja=
son Dillaman)
> * rbd: TaskFinisher::cancel should remove event from SafeTimer (#1447=
6, Douglas Fuller)
> * rbd: avoid re-writing old-format image header on resize (#13674, Ja=
son Dillaman)
> * rbd: fix bench-write (#14225, Sage Weil)
> * rbd: rbd-replay does not check for EOF and goes to endless loop (#1=
4452, Mykola Golub)
> * rbd: rbd-replay-prep and rbd-replay improvements (#13221, #13220, #=
13378, Jason Dillaman)
> * rbd: verify self-managed snapshot functionality on image create (#1=
3633, Jason Dillaman)
> * rgw: Make RGW_MAX_PUT_SIZE configurable (#6999, Vladislav Odintsov,=
 Yuan Zhou)
> * rgw: Setting ACL on Object removes ETag (#12955, Brian Felton)
> * rgw: backport content-type casing (#12939, Robin H. Johnson)
> * rgw: bucket listing hangs on versioned buckets (#12913, Yehuda Sade=
h)
> * rgw: fix wrong etag calculation during POST on S3 bucket. (#11241, =
Vladislav Odintsov, Radoslaw Zarzynski)
> * rgw: get bucket location returns region name, not region api name (=
#13458, Yehuda Sadeh)
> * rgw: missing handling of encoding-type=3Durl when listing keys in b=
ucket (#12735, Jeff Weber)
> * rgw: orphan tool should be careful about removing head objects (#12=
958, Yehuda Sadeh)
> * rgw: orphans finish segfaults (#13824, Igor Fedotov)
> * rgw: rgw-admin: document orphans commands in usage (#14516, Yehuda =
Sadeh)
> * rgw: swift API returns more than real object count and bytes used w=
hen retrieving account metadata (#13140, Sangdi Xu)
> * rgw: swift use Civetweb ssl can not get right url (#13628, Weijun D=
uan)
> * rgw: value of Swift API's X-Object-Manifest header is not url_decod=
ed during segment look up (#12728, Radoslaw Zarzynski)
> * tests: fixed broken Makefiles after integration of ttng into rados =
(#13210, Sebastien Ponce)
> * tests: fsx failed to compile (#14384, Greg Farnum)
> * tests: notification slave needs to wait for master (#13810, Jason D=
illaman)
> * tests: qa: remove legacy OS support from rbd/qemu-iotests (#13483, =
#14385, Vasu Kulkarni, Jason Dillaman)
> * tests: testprofile must be removed before it is re-created (#13664,=
 Loic Dachary)
> * tools: ceph-monstore-tool must do out_store.close() (#10093, huangj=
un)
> * tools: heavy memory shuffling in rados bench (#12946, Piotr Da=C5=82=
ek)
> * tools: race condition in rados bench (#12947, Piotr Da=C5=82ek)
> * tools: tool for artificially inflate the leveldb of the mon store f=
or testing purposes  (#10093, #11815, #14217, Cilang Zhao, Bo Cai, Kefu=
 Chai, huangjun, Joao Eduardo Luis)
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-0.94.6.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ce=
ph-deploy
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
