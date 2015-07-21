From: Sage Weil <sage@redhat.com>
Subject: v0.80.10 Firefly released
Date: Tue, 21 Jul 2015 09:55:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507210955080.4141@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51597 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbGUQzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 12:55:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This is a bugfix release for Firefly.

We recommend that all Firefly users upgrade at their convenience.

Notable Changes
---------------

* rgw: check for timestamp for s3 keystone auth (#10062, Abhishek Lekshmanan)
* mon: PGMonitor: several stats output error fixes (#10257, Joao Eduardo Luis)
* osd: pg stuck stale after create with activation delay (#11197, Samuel Just)
* mon: OSDMonitor: fallback to json-pretty in case of invalid formatter (#9538, Loic Dachary)
* osd: ENOENT on clone (#11199, Samuel Just)
* doc: Fix ceph command manpage to match ceph -h (#10676, David Zafman)
* rgw: Swift API. Support for X-Remove-Container-Meta-{key} header. (#10475, Dmytro Iurchenko)
* rgw: fail s3 POST auth if keystone not configured (#10698, Yehuda Sadeh)
* mds: fix assertion caused by system clock backwards (#11053, Yan, Zheng)
* osd: check that source OSD is valid for MOSDRepScrub (#9555, Sage Weil)
* osd: requeue blocked op before flush it was blocked on (#10512, Sage Weil)
* osd: ReplicatedPG: fail a non-blocking flush if the object is being scrubbed (#8011, Samuel Just)
* tools: Fix do_autogen.sh so that -L is allowed (#11303, Alfredo Deza)
* tools: ceph-objectstore-tool: Use exit status 11 for incompatible import attemp... (#11139, David Zafman)
* fs: mount.ceph: avoid spurious error message (#10351, Yan, Zheng)
* tests: force checkout of submodules (#11157, Loic Dachary)
* osd: FAILED assert(soid < scrubber.start || soid >= scrubber.end) (#11156, Samuel Just)
* osd: cache tiering: fix the atime logic of the eviction (#9915, Zhiqiang Wang)
* tools: ceph-objectstore-tool: Output only unsupported features when incomatible (#11176, David Zafman)
* osd: PG::all_unfound_are_queried_or_lost for non-existent osds (#10976, Mykola Golub)
* rgw: Swift API. Dump container's custom metadata. (#10665, Dmytro Iurchenko)
* osd: cancel_pull: requeue waiters (#11244, Samuel Just)
* librbd: snap_remove should ignore -ENOENT errors (#11113, Jason Dillaman)
* common: SimpleMessenger: allow RESETSESSION whenever we forget an endpoint (#10080, Greg Farnum)
* osd: load_pgs: we need to handle the case where an upgrade from earlier versions which ignored non-existent pgs resurrects a pg with a prehistoric osdmap (#11429, Samuel Just)
* rgw: merge manifests correctly when there's prefix override (#11622, Yehuda Sadeh)
* mon: ignore osd failures from before up_from (#10762, Sage Weil)
* common: WorkQueue: make wait timeout on empty queue configurable (#10817, Samuel Just)
* osd: DBObjectMap: lock header_lock on sync() (#9891, Samuel Just)
* rgw: civetweb should use unique request id (#11720, Orit Wasserman)
* librados: fix resources leakage in RadosClient::connect() (#10425, Radoslaw Zarzynski)
* osd: fix negative degraded objects during backfilling (#7737, Guang Yang)
* osd: FileJournal: fix journalq population in do_read_entry() (#6003, Samuel Just)
* common: Rados.shutdown() dies with Illegal instruction (core dumped) (#10153, Federico Simoncelli)
* osd: ReplicatedPG::scan_range: an object can disappear between the list and t... (#10150, Samuel Just)
* osd: PGLog: include rollback_info_trimmed_to in (read|write)_log (#10157, Samuel Just)
* osd: PG: always clear_primary_state (#10059, Samuel Just)
* crush: set_choose_tries = 100 for erasure code rulesets (#10353, Loic Dachary)
* build/ops: ceph.spec.in: package mkcephfs on EL6 (#11955, Ken Dreyer)
* doc: backport ceph-disk man page to Firefly (#10724, Nilamdyuti Goswami)
* librados: Fix memory leak in python rados bindings (#10723, Josh Durgin)
* osd: ReplicatedPG::on_change: clean up callbacks_for_degraded_object (#8753, Samuel Just)
* librados: Translate operation flags from C APIs (#10497, Matt Richards)
* common: messages/MWatchNotify: include an error code in the message (#9193, Sage Weil)
* mon: Monitor: fix timecheck rounds period (#10546, Joao Eduardo Luis)
* mon: OSDMonitor: do not trust small values in osd epoch cache (#10787, Sage Weil)
* rgw: keystone token cache does not work correctly (#11125, Yehuda Sadeh)
* librbd: acquire cache_lock before refreshing parent (#5488, Jason Dillaman)
* objecter: fix map skipping (#9986, Ding Dinghua)
* osd: get the currently atime of the object in cache pool for eviction (#9985, Sage Weil)
* rgw: don't allow negative / invalid content length (#11890, Yehuda Sadeh)
* osd: ObjectStore: Don't use largest_data_off to calc data_align. (#10014, Jianpeng Ma)
* osd: osd_types: op_queue_age_hist and fs_perf_stat should be in osd_stat_t::o... (#10259, Samuel Just)
* osd: erasure-code-profile set races with erasure-code-profile rm (#11144, Loic Dachary)
* build/ops: debian: ceph-test and rest-bench debug packages should require their respective binary packages (#11673, Ken Dreyer)
* mon: MonCap: take EntityName instead when expanding profiles (#10844, Joao Eduardo Luis)
* rgw: use correct objv_tracker for bucket instance (#11416, Yehuda Sadeh)
* rgw: generate new tag for object when setting object attrs (#11256, Yehuda Sadeh)
* rgw: generate the "Date" HTTP header for civetweb. (#11871,11891, Radoslaw Zarzynski)
* rgw: shouldn't need to disable rgw_socket_path if frontend is configured (#11160, Yehuda Sadeh)
* rgw: flush xml header on get acl request (#10106, Yehuda Sadeh)
* rgw: send appropriate op to cancel bucket index pending operation (#10770, Yehuda Sadeh)
* tools: Backport ceph-objectstore-tool changes to firefly (#12327, David Zafman)
* osd: do not ignore deleted pgs on startup (#10617, Sage Weil)
* osd: PG::actingset should be used when checking the number of acting OSDs for... (#11454, Guang Yang)
* osd: PGLog.h: 279: FAILED assert(log.log.size() == log_keys_debug.size()) (#10718, Samuel Just)
* build/ops: run RGW as root (#11453, Ken Dreyer)

For the complete changelog, see

  http://docs.ceph.com/docs/master/_downloads/v0.80.10.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.80.10.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
