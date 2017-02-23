From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 23 Feb 2017 01:09:15 -0800
Message-ID: <58aea6bb6703_7a9e12f73207026b@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:53749 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdBWJJ3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Feb 2017 04:09:29 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0008p1las1.sendgrid.net (SG) with ESMTP id io-N8wICQpiLDEnc0IloRQ
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 09:09:15.242 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

18 new defect(s) introduced to ceph found with Coverity Scan.
17 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 18 of 18 defect(s)


** CID 1401431:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Export.cc: 228 in rbd::action::export_full::do_export_diff(librbd::Image &, const char *, const char *, bool, const char *, bool)()


________________________________________________________________________________________________________
*** CID 1401431:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Export.cc: 228 in rbd::action::export_full::do_export_diff(librbd::Image &, const char *, const char *, bool, const char *, bool)()
222     
223       r = do_export_diff_fd(image, fromsnapname, endsnapname, whole_object, fd, no_progress, 1);
224     
225       if (fd != 1)
226         close(fd);
227       if (r < 0 && fd != 1) {
>>>     CID 1401431:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "remove(path)" without checking return value. This library function may fail and return an error code.
228         remove(path);
229       }
230     
231       return r;
232     }
233     

** CID 1401432:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 622 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()


________________________________________________________________________________________________________
*** CID 1401432:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 622 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()
616             goto done;
617           }
618           assert(bdev_size >= 0);
619           size = (uint64_t) bdev_size;
620         }
621     #ifdef HAVE_POSIX_FADVISE
>>>     CID 1401432:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
622         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
623     #endif
624       }
625     
626       r = do_import_header(fd, import_format, size, opts);
627       if (r < 0) {

** CID 1401433:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/test/objectstore/store_test.cc: 5927 in StoreTest_garbageCollection_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1401433:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/test/objectstore/store_test.cc: 5927 in StoreTest_garbageCollection_Test::TestBody()()
5921           ASSERT_EQ(statfs.compressed_allocated, 0x20000);
5922           const PerfCounters* counters = store->get_perf_counters();
5923           ASSERT_EQ(counters->get(l_bluestore_gc_merged), 0x20000u);
5924         }
5925         {
5926           struct store_statfs_t statfs;
>>>     CID 1401433:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "overlap_offset" in "(uint64_t)overlap_offset - 1UL" looks like a copy-paste error.
5927           WRITE_AT(write_offset + 1, overlap_offset-1);
5928           int r = store->statfs(&statfs);
5929           ASSERT_EQ(r, 0);
5930           ASSERT_EQ(statfs.compressed_allocated, 0x20000);
5931           const PerfCounters* counters = store->get_perf_counters();
5932           ASSERT_EQ(counters->get(l_bluestore_gc_merged), 0x20000u);

** CID 1401434:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 1068 in librbd::clone(librados::IoCtx &, const char *, const char *, librados::IoCtx &, const char *, unsigned long, int *, unsigned long, int)()


________________________________________________________________________________________________________
*** CID 1401434:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 1068 in librbd::clone(librados::IoCtx &, const char *, const char *, librados::IoCtx &, const char *, unsigned long, int *, unsigned long, int)()
1062         opts.set(RBD_IMAGE_OPTION_FEATURES, features);
1063         opts.set(RBD_IMAGE_OPTION_ORDER, order);
1064         opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit);
1065         opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count);
1066     
1067         int r = clone(p_ioctx, p_name, p_snap_name, c_ioctx, c_name, opts);
>>>     CID 1401434:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 22 out of 27 times).
1068         opts.get(RBD_IMAGE_OPTION_ORDER, &order);
1069         *c_order = order;
1070         return r;
1071       }
1072     
1073       int clone(IoCtx& p_ioctx, const char *p_name, const char *p_snap_name,

** CID 1401435:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 1127 in librbd::clone(librbd::ImageCtx *, librados::IoCtx &, const char *, librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1401435:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 1127 in librbd::clone(librbd::ImageCtx *, librados::IoCtx &, const char *, librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
1121         c_opts.is_set(RBD_IMAGE_OPTION_FORMAT, &default_format_set);
1122         if (!default_format_set) {
1123           c_opts.set(RBD_IMAGE_OPTION_FORMAT, static_cast<uint64_t>(2));
1124         }
1125     
1126         uint64_t format = 0;
>>>     CID 1401435:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 22 out of 27 times).
1127         c_opts.get(RBD_IMAGE_OPTION_FORMAT, &format);
1128         if (format < 2) {
1129           lderr(cct) << "format 2 or later required for clone" << dendl;
1130           return -EINVAL;
1131         }
1132     

** CID 1401436:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 147 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 148 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()


________________________________________________________________________________________________________
*** CID 1401436:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 147 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
141         m_features = util::get_rbd_default_features(m_cct);
142         m_negotiate_features = true;
143       }
144     
145       uint64_t features_clear = 0;
146       uint64_t features_set = 0;
>>>     CID 1401436:    (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 22 out of 27 times).
147       image_options.get(RBD_IMAGE_OPTION_FEATURES_CLEAR, &features_clear);
148       image_options.get(RBD_IMAGE_OPTION_FEATURES_SET, &features_set);
149     
150       uint64_t features_conflict = features_clear & features_set;
151       features_clear &= ~features_conflict;
152       features_set &= ~features_conflict;
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 148 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
142         m_negotiate_features = true;
143       }
144     
145       uint64_t features_clear = 0;
146       uint64_t features_set = 0;
147       image_options.get(RBD_IMAGE_OPTION_FEATURES_CLEAR, &features_clear);
>>>     CID 1401436:    (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 22 out of 27 times).
148       image_options.get(RBD_IMAGE_OPTION_FEATURES_SET, &features_set);
149     
150       uint64_t features_conflict = features_clear & features_set;
151       features_clear &= ~features_conflict;
152       features_set &= ~features_conflict;
153       m_features |= features_set;

** CID 1401437:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Export.cc: 518 in rbd::action::export_full::do_export(librbd::Image &, const char *, bool, int)()


________________________________________________________________________________________________________
*** CID 1401437:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/tools/rbd/action/Export.cc: 518 in rbd::action::export_full::do_export(librbd::Image &, const char *, bool, int)()
512         max_concurrent_ops = max(g_conf->rbd_concurrent_management_ops, 1);
513         fd = open(path, O_WRONLY | O_CREAT | O_EXCL, 0644);
514         if (fd < 0) {
515           return -errno;
516         }
517     #ifdef HAVE_POSIX_FADVISE
>>>     CID 1401437:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
518         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
519     #endif
520       }
521     
522       utils::ProgressContext pc("Exporting image", no_progress);
523       uint64_t period = image.get_stripe_count() * (1ull << info.order);

** CID 1401438:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/tools/rbd_nbd/rbd-nbd.cc: 641 in do_map(int, const char **)()


________________________________________________________________________________________________________
*** CID 1401438:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/home/brad/working/src/ceph/src/tools/rbd_nbd/rbd-nbd.cc: 641 in do_map(int, const char **)()
635       r = ioctl(nbd, NBD_SET_BLKSIZE, RBD_NBD_BLKSIZE);
636       if (r < 0) {
637         r = -errno;
638         goto close_nbd;
639       }
640     
>>>     CID 1401438:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
>>>     "info.size > 18446744073709551615UL /* 9223372036854775807L * 2UL + 1UL */" is always false regardless of the values of its operands. This occurs as the logical operand of "if".
641       if (info.size > ULONG_MAX) {
642         r = -EFBIG;
643         cerr << "rbd-nbd: image is too large (" << prettybyte_t(info.size)
644              << ", max is " << prettybyte_t(ULONG_MAX) << ")" << std::endl;
645         goto close_nbd;
646       }

** CID 1401439:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 425 in rbd::action::import::do_import_header(int, int, unsigned long &, librbd::ImageOptions &)()


________________________________________________________________________________________________________
*** CID 1401439:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 425 in rbd::action::import::do_import_header(int, int, unsigned long &, librbd::ImageOptions &)()
419     	  opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count);
420     	}
421           } else {
422     	std::cerr << "rbd: invalid tag in image properties zone: " << tag << "Skip it." << std::endl;
423     	if (fd == STDIN_FILENO) {
424     	  // read the appending data out to skip this tag.
>>>     CID 1401439:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "char buf[4096];".
425     	  char buf[4096];
426     	  uint64_t len = min(length, uint64_t(4096));
427     	  while (len > 0) {
428     	    r = safe_read_exact(fd, buf, len);
429     	    if (r < 0)
430     	      return r;

** CID 1401440:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1151 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1401440:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1151 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::vector<int, std::allocator<int>> &, pg_shard_t, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, pg_shard_t *, std::basic_ostream<char, std::char_traits<char>>&)()
1145     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
1146     	auth_log_shard->second.log_tail) {
1147           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
1148           want[i] = acting[i];
1149           ++usable;
1150         } else if (!restrict_to_up_acting) {
>>>     CID 1401440:  Control flow issues  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
1151           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
1152     	   j != all_info_by_shard[shard_id_t(i)].end();
1153     	   ++j) {
1154     	assert(j->shard == i);
1155     	if (!all_info.find(*j)->second.is_incomplete() &&
1156     	    all_info.find(*j)->second.last_update >=

** CID 1401441:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 302 in rbd::mirror::ImageReplayer<librbd::ImageCtx>::ImageReplayer(rbd::mirror::Threads *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::ImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 302 in rbd::mirror::ImageReplayer<librbd::<unnamed>::MockTestImageCtx>::ImageReplayer(rbd::mirror::Threads *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::<unnamed>::MockTestImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1401441:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 302 in rbd::mirror::ImageReplayer<librbd::ImageCtx>::ImageReplayer(rbd::mirror::Threads *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::ImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
296         pool_name = stringify(m_local_pool_id);
297       }
298       m_name = pool_name + "/" + m_global_image_id;
299     
300       m_asok_hook = new ImageReplayerAdminSocketHook<I>(g_ceph_context, m_name,
301                                                         this);
>>>     CID 1401441:    (UNINIT_CTOR)
>>>     Non-static class member "m_do_resync" is not initialized in this constructor nor in any functions that it calls.
302     }
303     
304     template <typename I>
305     ImageReplayer<I>::~ImageReplayer()
306     {
307       assert(m_event_preprocessor == nullptr);
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 302 in rbd::mirror::ImageReplayer<librbd::<unnamed>::MockTestImageCtx>::ImageReplayer(rbd::mirror::Threads *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::<unnamed>::MockTestImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
296         pool_name = stringify(m_local_pool_id);
297       }
298       m_name = pool_name + "/" + m_global_image_id;
299     
300       m_asok_hook = new ImageReplayerAdminSocketHook<I>(g_ceph_context, m_name,
301                                                         this);
>>>     CID 1401441:    (UNINIT_CTOR)
>>>     Non-static class member "m_do_resync" is not initialized in this constructor nor in any functions that it calls.
302     }
303     
304     template <typename I>
305     ImageReplayer<I>::~ImageReplayer()
306     {
307       assert(m_event_preprocessor == nullptr);

** CID 1401442:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ObjectRequest.cc: 350 in librbd::io::AbstractObjectWriteRequest::AbstractObjectWriteRequest(librbd::ImageCtx *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, unsigned long, unsigned long, const SnapContext &, Context *, bool)()


________________________________________________________________________________________________________
*** CID 1401442:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ObjectRequest.cc: 350 in librbd::io::AbstractObjectWriteRequest::AbstractObjectWriteRequest(librbd::ImageCtx *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, unsigned long, unsigned long, const SnapContext &, Context *, bool)()
344                                                            bool hide_enoent)
345       : ObjectRequest(ictx, oid, object_no, object_off, len, CEPH_NOSNAP,
346                       completion, hide_enoent),
347         m_state(LIBRBD_AIO_WRITE_FLAT), m_snap_seq(snapc.seq.val)
348     {
349       m_snaps.insert(m_snaps.end(), snapc.snaps.begin(), snapc.snaps.end());
>>>     CID 1401442:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_object_exist" is not initialized in this constructor nor in any functions that it calls.
350     }
351     
352     void AbstractObjectWriteRequest::guard_write()
353     {
354       if (has_parent()) {
355         m_state = LIBRBD_AIO_WRITE_GUARD;

** CID 1401443:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ImageRequest.cc: 204 in librbd::io::ImageReadRequest<librbd::ImageCtx>::ImageReadRequest(librbd::ImageCtx &, librbd::io::AioCompletion *, std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long>>> &&, librbd::io::ReadResult &&, int)()


________________________________________________________________________________________________________
*** CID 1401443:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ImageRequest.cc: 204 in librbd::io::ImageReadRequest<librbd::ImageCtx>::ImageReadRequest(librbd::ImageCtx &, librbd::io::AioCompletion *, std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long>>> &&, librbd::io::ReadResult &&, int)()
198                                           Extents &&image_extents,
199                                           ReadResult &&read_result,
200                                           int op_flags)
201       : ImageRequest<I>(image_ctx, aio_comp, std::move(image_extents)),
202         m_op_flags(op_flags) {
203       aio_comp->read_result = std::move(read_result);
>>>     CID 1401443:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_pbl" is not initialized in this constructor nor in any functions that it calls.
204     }
205     
206     template <typename I>
207     void ImageReadRequest<I>::send_request() {
208       I &image_ctx = this->m_image_ctx;
209       CephContext *cct = image_ctx.cct;

** CID 1401444:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.h: 867 in BlueStore::GarbageCollector::GarbageCollector(CephContext *)()


________________________________________________________________________________________________________
*** CID 1401444:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/BlueStore.h: 867 in BlueStore::GarbageCollector::GarbageCollector(CephContext *)()
861           uint64_t min_alloc_size);
862     
863         /// return a collection of extents to perform GC on
864         const vector<AllocExtent>& get_extents_to_collect() const {
865           return extents_to_collect;
866         }
>>>     CID 1401444:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "gc_end_offset" is not initialized in this constructor nor in any functions that it calls.
867         GarbageCollector(CephContext* _cct) : cct(_cct) {}
868     
869       private:
870         struct BlobInfo {
871           uint64_t referenced_bytes = 0;    ///< amount of bytes referenced in blob
872           int64_t expected_allocations = 0; ///< new alloc units required 

** CID 1401445:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 645 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()


________________________________________________________________________________________________________
*** CID 1401445:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 645 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()
639       if (r < 0) {
640         std::cerr << "rbd: failed to open image" << std::endl;
641         goto err;
642       }
643     
644       if (import_format == 1) {
>>>     CID 1401445:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "rbd::action::import::do_import_v1(fd, image, size, imgblklen, throttle, pc)" to "r" here, but that stored value is overwritten before it can be used.
645         r = do_import_v1(fd, image, size, imgblklen, throttle, pc);
646       } else {
647         r = do_import_v2(fd, image, size, imgblklen, throttle, pc);
648       }
649     
650       r = image.close();

** CID 1401446:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 647 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()


________________________________________________________________________________________________________
*** CID 1401446:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/tools/rbd/action/Import.cc: 647 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool, int)()
641         goto err;
642       }
643     
644       if (import_format == 1) {
645         r = do_import_v1(fd, image, size, imgblklen, throttle, pc);
646       } else {
>>>     CID 1401446:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "rbd::action::import::do_import_v2(fd, image, size, imgblklen, throttle, pc)" to "r" here, but that stored value is overwritten before it can be used.
647         r = do_import_v2(fd, image, size, imgblklen, throttle, pc);
648       }
649     
650       r = image.close();
651     err:
652       if (r < 0)

** CID 1401447:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/OSDMapMapping.h: 246 in OSDMapMapping::OSDMapMapping()()


________________________________________________________________________________________________________
*** CID 1401447:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/OSDMapMapping.h: 246 in OSDMapMapping::OSDMapMapping()()
240       };
241     
242       mempool::osdmap_mapping::map<int64_t,PoolMapping> pools;
243       mempool::osdmap_mapping::vector<
244         mempool::osdmap_mapping::vector<pg_t>> acting_rmap;  // osd -> pg
245       //unused: mempool::osdmap_mapping::vector<std::vector<pg_t>> up_rmap;  // osd -> pg
>>>     CID 1401447:  Uninitialized members  (UNINIT_CTOR)
>>>     The compiler-generated constructor for this class does not initialize "epoch".
246       epoch_t epoch;
247       uint64_t num_pgs = 0;
248     
249       void _init_mappings(const OSDMap& osdmap);
250       void _update_range(
251         const OSDMap& map,

** CID 1401448:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ReadResult.h: 63 in librbd::io::ReadResult::C_SparseReadRequest<librbd::ImageCtx>::C_SparseReadRequest(librbd::io::AioCompletion *)()


________________________________________________________________________________________________________
*** CID 1401448:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/io/ReadResult.h: 63 in librbd::io::ReadResult::C_SparseReadRequest<librbd::ImageCtx>::C_SparseReadRequest(librbd::io::AioCompletion *)()
57       template <typename ImageCtxT>
58       struct C_SparseReadRequest : public C_SparseReadRequestBase {
59         ObjectReadRequest<ImageCtxT> *request;
60     
61         C_SparseReadRequest(AioCompletion *aio_completion)
62           : C_SparseReadRequestBase(aio_completion) {
>>>     CID 1401448:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "request" is not initialized in this constructor nor in any functions that it calls.
63         }
64     
65         void finish(int r) override {
66           C_SparseReadRequestBase::finish(request->get_extent_map(),
67                                           request->get_buffer_extents(),
68                                           request->get_offset(),


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GIpUz3Dj-2B62dGZZqNgtGNkeDrE1RZk7o2DQTsiOU-2B2EzFc-2Bf-2FmKUs4dfJJcemiVct8rcyNQUFPnFqNI9GPBinKFJKuNoEIILsvcU35xbysUNHmfCPHNNcoeqwknEg6M5mXRUpDGNcvPVEIKXRwpM5SrtezMkD12J1JTW32pVz64fJHdCMqucC4ibgmiig0xmw-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GIpUz3Dj-2B62dGZZqNgtGNkeDrE1RZk7o2DQTsiOU-2B2E3xYA-2FN2skl0lpGO1BRV6vQ0DiG-2F-2Fy4SUMq2EeK9NGa2wiGYmwFl58KU50D4XlP0TapAgp-2Bx3BYpFt4BKObS7uRanpWWWem2I3cAaSnyd00GM9Dx42uh-2FC0OOr2MdhBh0alZ58CbDzj8Zz9UJW4ejYY-3D

