From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 23 Mar 2017 00:58:38 -0700
Message-ID: <58d3802e30b93_215e12f7320702c8@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:43369 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751346AbdCWH6k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Mar 2017 03:58:40 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1las1.sendgrid.net (SG) with ESMTP id q20Srhn9TQab1TrqrlQreg
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 07:58:38.521 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

18 new defect(s) introduced to ceph found with Coverity Scan.
10 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 18 of 18 defect(s)


** CID 1401434:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 905 in librbd::clone(librados::IoCtx &, const char *, const char *, librados::IoCtx &, const char *, unsigned long, int *, unsigned long, int)()


________________________________________________________________________________________________________
*** CID 1401434:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/internal.cc: 905 in librbd::clone(librados::IoCtx &, const char *, const char *, librados::IoCtx &, const char *, unsigned long, int *, unsigned long, int)()
899         opts.set(RBD_IMAGE_OPTION_FEATURES, features);
900         opts.set(RBD_IMAGE_OPTION_ORDER, order);
901         opts.set(RBD_IMAGE_OPTION_STRIPE_UNIT, stripe_unit);
902         opts.set(RBD_IMAGE_OPTION_STRIPE_COUNT, stripe_count);
903     
904         int r = clone(p_ioctx, p_name, p_snap_name, c_ioctx, c_name, opts);
>>>     CID 1401434:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 20 out of 25 times).
905         opts.get(RBD_IMAGE_OPTION_ORDER, &order);
906         *c_order = order;
907         return r;
908       }
909     
910       int clone(IoCtx& p_ioctx, const char *p_name, const char *p_snap_name,

** CID 1401436:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 156 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 157 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()


________________________________________________________________________________________________________
*** CID 1401436:    (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 156 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
150         m_features = util::get_rbd_default_features(m_cct);
151         m_negotiate_features = true;
152       }
153     
154       uint64_t features_clear = 0;
155       uint64_t features_set = 0;
>>>     CID 1401436:    (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 20 out of 25 times).
156       image_options.get(RBD_IMAGE_OPTION_FEATURES_CLEAR, &features_clear);
157       image_options.get(RBD_IMAGE_OPTION_FEATURES_SET, &features_set);
158     
159       uint64_t features_conflict = features_clear & features_set;
160       features_clear &= ~features_conflict;
161       features_set &= ~features_conflict;
/home/brad/working/src/ceph/src/librbd/image/CreateRequest.cc: 157 in librbd::image::CreateRequest<librbd::ImageCtx>::CreateRequest(librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, const librbd::ImageOptions &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool, ContextWQ *, Context *)()
151         m_negotiate_features = true;
152       }
153     
154       uint64_t features_clear = 0;
155       uint64_t features_set = 0;
156       image_options.get(RBD_IMAGE_OPTION_FEATURES_CLEAR, &features_clear);
>>>     CID 1401436:    (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 20 out of 25 times).
157       image_options.get(RBD_IMAGE_OPTION_FEATURES_SET, &features_set);
158     
159       uint64_t features_conflict = features_clear & features_set;
160       features_clear &= ~features_conflict;
161       features_set &= ~features_conflict;
162       m_features |= features_set;

** CID 1403241:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 412 in librbd::image::CloneRequest<librbd::ImageCtx>::get_mirror_mode()()


________________________________________________________________________________________________________
*** CID 1403241:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 412 in librbd::image::CloneRequest<librbd::ImageCtx>::get_mirror_mode()()
406       cls_client::mirror_mode_get_start(&op);
407     
408       using klass = CloneRequest<I>;
409       librados::AioCompletion *comp =
410         create_rados_callback<klass, &klass::handle_get_mirror_mode>(this);
411       m_out_bl.clear();
>>>     CID 1403241:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "aio_operate" without checking return value (as is done elsewhere 56 out of 68 times).
412       m_imctx->md_ctx.aio_operate(RBD_MIRRORING,
413     			      comp, &op, &m_out_bl);
414       comp->release();
415     }
416     
417     template <typename I>

** CID 1403242:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 343 in librbd::image::CloneRequest<librbd::ImageCtx>::send_metadata_list()()


________________________________________________________________________________________________________
*** CID 1403242:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 343 in librbd::image::CloneRequest<librbd::ImageCtx>::send_metadata_list()()
337       cls_client::metadata_list_start(&op, "", 0);
338     
339       using klass = CloneRequest<I>;
340       librados::AioCompletion *comp =
341         create_rados_callback<klass, &klass::handle_metadata_list>(this);
342       m_out_bl.clear();
>>>     CID 1403242:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "aio_operate" without checking return value (as is done elsewhere 56 out of 68 times).
343       m_p_imctx->md_ctx.aio_operate(m_p_imctx->header_oid,
344     				comp, &op, &m_out_bl);
345       comp->release();
346     }
347     
348     template <typename I>

** CID 1403243:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 66 in librbd::image::CloneRequest<librbd::ImageCtx>::validate_options()()


________________________________________________________________________________________________________
*** CID 1403243:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 66 in librbd::image::CloneRequest<librbd::ImageCtx>::validate_options()()
60     
61     template <typename I>
62     void CloneRequest<I>::validate_options() {
63       ldout(m_cct, 20) << this << " " << __func__ << dendl;
64     
65       uint64_t format = 0;
>>>     CID 1403243:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get" without checking return value (as is done elsewhere 20 out of 25 times).
66       m_opts.get(RBD_IMAGE_OPTION_FORMAT, &format);
67       if (format < 2) {
68         lderr(m_cct) << "format 2 or later required for clone" << dendl;
69         return complete(-EINVAL);
70       }
71     

** CID 1403244:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/osd/PGLog.cc: 141 in PGLog::proc_replica_log(pg_info_t &, const pg_log_t &, pg_missing_set<(bool)0> &, pg_shard_t) const()


________________________________________________________________________________________________________
*** CID 1403244:  Incorrect expression  (COPY_PASTE_ERROR)
/home/brad/working/src/ceph/src/osd/PGLog.cc: 141 in PGLog::proc_replica_log(pg_info_t &, const pg_log_t &, pg_missing_set<(bool)0> &, pg_shard_t) const()
135       pg_missing_t& omissing,
136       pg_shard_t from) const
137     {
138       dout(10) << "proc_replica_log for osd." << from << ": "
139     	   << oinfo << " " << olog << " " << omissing << dendl;
140     
>>>     CID 1403244:  Incorrect expression  (COPY_PASTE_ERROR)
>>>     "head" in "olog.head" looks like a copy-paste error.
141       if (olog.head < log.tail) {
142         dout(10) << __func__ << ": osd." << from << " does not overlap, not looking "
143     	     << "for divergent objects" << dendl;
144         return;
145       }
146       if (olog.head == log.head) {

** CID 1403245:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI32bluestore_deferred_transaction_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1403245:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI32bluestore_deferred_transaction_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1403245:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1403246:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23bluestore_deferred_op_tE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1403246:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI23bluestore_deferred_op_tE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1403246:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() override {
152         return !nondeterministic;

** CID 1403247:  Concurrent data access violations  (MISSING_LOCK)
/usr/include/c++/6.2.1/bits/std_mutex.h: 340 in std::unique_lock<std::recursive_mutex>::release()()


________________________________________________________________________________________________________
*** CID 1403247:  Concurrent data access violations  (MISSING_LOCK)
/usr/include/c++/6.2.1/bits/std_mutex.h: 340 in std::unique_lock<std::recursive_mutex>::release()()
334     
335           mutex_type*
336           release() noexcept
337           {
338     	mutex_type* __ret = _M_device;
339     	_M_device = 0;
>>>     CID 1403247:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->_M_owns" without holding lock "std::unique_lock<std::recursive_mutex>._M_device". Elsewhere, "_ZSt11unique_lockISt15recursive_mutexE._M_owns" is accessed with "std::unique_lock<std::recursive_mutex>._M_device" held 2 out of 3 times (2 of these accesses strongly imply that it is necessary).
340     	_M_owns = false;
341     	return __ret;
342           }
343     
344           bool
345           owns_lock() const noexcept

** CID 1403248:  Program hangs  (SLEEP)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 208 in KernelDevice::flush()()


________________________________________________________________________________________________________
*** CID 1403248:  Program hangs  (SLEEP)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 208 in KernelDevice::flush()()
202       dout(10) << __func__ << " start" << dendl;
203       if (cct->_conf->bdev_inject_crash) {
204         ++injecting_crash;
205         // sleep for a moment to give other threads a chance to submit or
206         // wait on io that races with a flush.
207         derr << __func__ << " injecting crash. first we sleep..." << dendl;
>>>     CID 1403248:  Program hangs  (SLEEP)
>>>     Call to "sleep" might sleep while holding lock "this->flush_mutex".
208         sleep(cct->_conf->bdev_inject_crash_flush_delay);
209         derr << __func__ << " and now we die" << dendl;
210         cct->_log->flush();
211         _exit(1);
212       }
213       utime_t start = ceph_clock_now();

** CID 1403249:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 324 in librbd::image::CloneRequest<librbd::ImageCtx>::handle_refresh(int)()


________________________________________________________________________________________________________
*** CID 1403249:  Uninitialized variables  (UNINIT)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 324 in librbd::image::CloneRequest<librbd::ImageCtx>::handle_refresh(int)()
318       if (r == 0) {
319         m_p_imctx->snap_lock.get_read();
320         r = m_p_imctx->is_snap_protected(m_p_imctx->snap_id, &snap_protected);
321         m_p_imctx->snap_lock.put_read();
322       }
323     
>>>     CID 1403249:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "snap_protected".
324       if (r < 0 || !snap_protected) {
325         m_r_saved = -EINVAL;
326         return send_close();
327       }
328     
329       send_metadata_list();

** CID 1403250:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 48 in KernelDevice::KernelDevice(CephContext *, void (*)(void *, void *), void *)()


________________________________________________________________________________________________________
*** CID 1403250:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 48 in KernelDevice::KernelDevice(CephContext *, void (*)(void *, void *), void *)()
42         aio_callback(cb),
43         aio_callback_priv(cbpriv),
44         aio_stop(false),
45         aio_thread(this),
46         injecting_crash(0)
47     {
>>>     CID 1403250:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "io_since_flush._M_base" is not initialized in this constructor nor in any functions that it calls.
48     }
49     
50     int KernelDevice::_lock()
51     {
52       struct flock l;
53       memset(&l, 0, sizeof(l));

** CID 1403251:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotUnprotectRequest.cc: 159 in librbd::operation::SnapshotUnprotectRequest<librbd::MockImageCtx>::SnapshotUnprotectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotUnprotectRequest.cc: 159 in librbd::operation::SnapshotUnprotectRequest<librbd::ImageCtx>::SnapshotUnprotectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1403251:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotUnprotectRequest.cc: 159 in librbd::operation::SnapshotUnprotectRequest<librbd::MockImageCtx>::SnapshotUnprotectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
153     SnapshotUnprotectRequest<I>::SnapshotUnprotectRequest(I &image_ctx,
154                                                           Context *on_finish,
155                                                           const cls::rbd::SnapshotNamespace &snap_namespace,
156     						      const std::string &snap_name)
157       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
158         m_snap_name(snap_name), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1403251:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
159     }
160     
161     template <typename I>
162     void SnapshotUnprotectRequest<I>::send_op() {
163       send_unprotect_snap_start();
164     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotUnprotectRequest.cc: 159 in librbd::operation::SnapshotUnprotectRequest<librbd::ImageCtx>::SnapshotUnprotectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
153     SnapshotUnprotectRequest<I>::SnapshotUnprotectRequest(I &image_ctx,
154                                                           Context *on_finish,
155                                                           const cls::rbd::SnapshotNamespace &snap_namespace,
156     						      const std::string &snap_name)
157       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
158         m_snap_name(snap_name), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1403251:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
159     }
160     
161     template <typename I>
162     void SnapshotUnprotectRequest<I>::send_op() {
163       send_unprotect_snap_start();
164     }

** CID 1403252:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::MockImageCtx>::SnapshotRemoveRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::ImageCtx>::SnapshotRemoveRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()


________________________________________________________________________________________________________
*** CID 1403252:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::MockImageCtx>::SnapshotRemoveRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
50     						Context *on_finish,
51     						const cls::rbd::SnapshotNamespace &snap_namespace,
52     						const std::string &snap_name,
53     						uint64_t snap_id)
54       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
55         m_snap_name(snap_name), m_snap_id(snap_id) {
>>>     CID 1403252:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
56     }
57     
58     template <typename I>
59     void SnapshotRemoveRequest<I>::send_op() {
60       send_remove_object_map();
61     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotRemoveRequest.cc: 56 in librbd::operation::SnapshotRemoveRequest<librbd::ImageCtx>::SnapshotRemoveRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long)()
50     						Context *on_finish,
51     						const cls::rbd::SnapshotNamespace &snap_namespace,
52     						const std::string &snap_name,
53     						uint64_t snap_id)
54       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace),
55         m_snap_name(snap_name), m_snap_id(snap_id) {
>>>     CID 1403252:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
56     }
57     
58     template <typename I>
59     void SnapshotRemoveRequest<I>::send_op() {
60       send_remove_object_map();
61     }

** CID 1403253:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::MockImageCtx>::SnapshotProtectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::ImageCtx>::SnapshotProtectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1403253:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::MockImageCtx>::SnapshotProtectRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
31     template <typename I>
32     SnapshotProtectRequest<I>::SnapshotProtectRequest(I &image_ctx,
33                                                       Context *on_finish,
34     						  const cls::rbd::SnapshotNamespace &snap_namespace,
35     						  const std::string &snap_name)
36       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace), m_snap_name(snap_name) {
>>>     CID 1403253:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
37     }
38     
39     template <typename I>
40     void SnapshotProtectRequest<I>::send_op() {
41       send_protect_snap();
42     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotProtectRequest.cc: 37 in librbd::operation::SnapshotProtectRequest<librbd::ImageCtx>::SnapshotProtectRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
31     template <typename I>
32     SnapshotProtectRequest<I>::SnapshotProtectRequest(I &image_ctx,
33                                                       Context *on_finish,
34     						  const cls::rbd::SnapshotNamespace &snap_namespace,
35     						  const std::string &snap_name)
36       : Request<I>(image_ctx, on_finish), m_snap_namespace(snap_namespace), m_snap_name(snap_name) {
>>>     CID 1403253:    (UNINIT_CTOR)
>>>     Non-static class member "m_state" is not initialized in this constructor nor in any functions that it calls.
37     }
38     
39     template <typename I>
40     void SnapshotProtectRequest<I>::send_op() {
41       send_protect_snap();
42     }

** CID 1403254:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::MockImageCtx>::SnapshotCreateRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::ImageCtx>::SnapshotCreateRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()


________________________________________________________________________________________________________
*** CID 1403254:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::MockImageCtx>::SnapshotCreateRequest(librbd::MockImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
29                                                     const std::string &snap_name,
30                                                     uint64_t journal_op_tid,
31                                                     bool skip_object_map)
32       : Request<I>(image_ctx, on_finish, journal_op_tid),
33         m_snap_namespace(snap_namespace), m_snap_name(snap_name),
34         m_skip_object_map(skip_object_map), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1403254:    (UNINIT_CTOR)
>>>     Non-static class member "m_size" is not initialized in this constructor nor in any functions that it calls.
35     }
36     
37     template <typename I>
38     void SnapshotCreateRequest<I>::send_op() {
39       send_suspend_requests();
40     }
/home/brad/working/src/ceph/src/librbd/operation/SnapshotCreateRequest.cc: 35 in librbd::operation::SnapshotCreateRequest<librbd::ImageCtx>::SnapshotCreateRequest(librbd::ImageCtx &, Context *, const boost::variant<cls::rbd::UserSnapshotNamespace, cls::rbd::GroupSnapshotNamespace, cls::rbd::UnknownSnapshotNamespace> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned long, bool)()
29                                                     const std::string &snap_name,
30                                                     uint64_t journal_op_tid,
31                                                     bool skip_object_map)
32       : Request<I>(image_ctx, on_finish, journal_op_tid),
33         m_snap_namespace(snap_namespace), m_snap_name(snap_name),
34         m_skip_object_map(skip_object_map), m_ret_val(0), m_snap_id(CEPH_NOSNAP) {
>>>     CID 1403254:    (UNINIT_CTOR)
>>>     Non-static class member "m_size" is not initialized in this constructor nor in any functions that it calls.
35     }
36     
37     template <typename I>
38     void SnapshotCreateRequest<I>::send_op() {
39       send_suspend_requests();
40     }

** CID 1403255:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 303 in rbd::mirror::ImageReplayer<librbd::ImageCtx>::ImageReplayer(rbd::mirror::Threads<librbd::ImageCtx> *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::ImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 303 in rbd::mirror::ImageReplayer<librbd::<unnamed>::MockTestImageCtx>::ImageReplayer(rbd::mirror::Threads<librbd::ImageCtx> *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::<unnamed>::MockTestImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1403255:    (UNINIT_CTOR)
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 303 in rbd::mirror::ImageReplayer<librbd::ImageCtx>::ImageReplayer(rbd::mirror::Threads<librbd::ImageCtx> *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::ImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
297       }
298     
299       m_name = pool_name + "/" + m_global_image_id;
300       dout(20) << "registered asok hook: " << m_name << dendl;
301       m_asok_hook = new ImageReplayerAdminSocketHook<I>(g_ceph_context, m_name,
302                                                         this);
>>>     CID 1403255:    (UNINIT_CTOR)
>>>     Non-static class member "m_do_resync" is not initialized in this constructor nor in any functions that it calls.
303     }
304     
305     template <typename I>
306     ImageReplayer<I>::~ImageReplayer()
307     {
308       assert(m_event_preprocessor == nullptr);
/home/brad/working/src/ceph/src/tools/rbd_mirror/ImageReplayer.cc: 303 in rbd::mirror::ImageReplayer<librbd::<unnamed>::MockTestImageCtx>::ImageReplayer(rbd::mirror::Threads<librbd::ImageCtx> *, std::shared_ptr<rbd::mirror::ImageDeleter>, std::shared_ptr<rbd::mirror::ImageSyncThrottler<librbd::<unnamed>::MockTestImageCtx>>, std::shared_ptr<librados::Rados>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, long, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
297       }
298     
299       m_name = pool_name + "/" + m_global_image_id;
300       dout(20) << "registered asok hook: " << m_name << dendl;
301       m_asok_hook = new ImageReplayerAdminSocketHook<I>(g_ceph_context, m_name,
302                                                         this);
>>>     CID 1403255:    (UNINIT_CTOR)
>>>     Non-static class member "m_do_resync" is not initialized in this constructor nor in any functions that it calls.
303     }
304     
305     template <typename I>
306     ImageReplayer<I>::~ImageReplayer()
307     {
308       assert(m_event_preprocessor == nullptr);

** CID 1403256:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 52 in librbd::image::CloneRequest<librbd::ImageCtx>::CloneRequest(librbd::ImageCtx *, librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librbd::ImageOptions, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ContextWQ *, Context *)()


________________________________________________________________________________________________________
*** CID 1403256:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/librbd/image/CloneRequest.cc: 52 in librbd::image::CloneRequest<librbd::ImageCtx>::CloneRequest(librbd::ImageCtx *, librados::IoCtx &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librbd::ImageOptions, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ContextWQ *, Context *)()
46         m_opts.set(RBD_IMAGE_OPTION_FORMAT, static_cast<uint64_t>(2));
47       }
48     
49       ldout(m_cct, 20) << "clone " << &m_p_imctx->md_ctx << " name " << m_p_imctx->name
50     		 << " snap " << m_p_imctx->snap_name << " to child " << &m_ioctx
51     		 << " name " << m_name << " opts = " << &m_opts << dendl;
>>>     CID 1403256:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_force_non_primary" is not initialized in this constructor nor in any functions that it calls.
52       return;
53     }
54     
55     template <typename I>
56     void CloneRequest<I>::send() {
57       ldout(m_cct, 20) << this << " " << __func__ << dendl;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GuxiXIDzB9wYnV1qJnKgnNTWe101tX7f4On-2BUcpPsgauX-2F1QxOBhz7Hs95AjKEPItoBZVOVmwIUKkQ0mU7dlm58Ya6jXjshb3ngf1-2FgNDGxpB67C9ncFTBcmxWEEo6Mwf5czP4d91NEl80NmFJZMjjAW66G9KQcpg7WO2RNcs9yOia8Y0Hf98e4-2BstHZebfCc-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GuxiXIDzB9wYnV1qJnKgnNTWe101tX7f4On-2BUcpPsgagAsjKHMT62nib0JrWIE2LyWZWd02f3PvUIU0NglY8yMRTMPSE6KqdX84lxdsqCjP9QuH3wYPr4dERg5cc0j7QdiWcy8tNtxmeWyoZG3Tn-2Bj-2BQOEWNX8Y5E37mm1D5pZcTVlzu4FCV00-2FmBf0Ot9mzY-3D

