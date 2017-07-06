From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 06 Jul 2017 05:03:22 +0000 (UTC)
Message-ID: <595dc49a1128d_285d971314984@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:49820 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751059AbdGFFDX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 01:03:23 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id XBvTupQyQNGU2MAyBhebDw
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 05:03:22.108 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

27 new defect(s) introduced to ceph found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 27 defect(s)


** CID 1395636:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 821 in get_attrs(ObjectStore *, coll_t, ghobject_t, ObjectStore::Transaction *, ceph::buffer::list &, OSDriver &, SnapMapper &)()


________________________________________________________________________________________________________
*** CID 1395636:  Performance inefficiencies  (PASS_BY_VALUE)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 821 in get_attrs(ObjectStore *, coll_t, ghobject_t, ObjectStore::Transaction *, ceph::buffer::list &, OSDriver &, SnapMapper &)()
815         cerr << "\tdata: offset " << ds.offset << " len " << ds.len << std::endl;
816       t->write(coll, hoid, ds.offset, ds.len,  ds.databl);
817       return 0;
818     }
819     
820     int get_attrs(
>>>     CID 1395636:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter hoid of type "ghobject_t" (size 144 bytes) by value.
821       ObjectStore *store, coll_t coll, ghobject_t hoid,
822       ObjectStore::Transaction *t, bufferlist &bl,
823       OSDriver &driver, SnapMapper &snap_mapper)
824     {
825       bufferlist::iterator ebliter = bl.begin();
826       attr_section as;

** CID 1414508:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: 606 in ()


________________________________________________________________________________________________________
*** CID 1414508:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: 606 in ()
600     void RDMAConnectedSocketImpl::notify()
601     {
602       uint64_t i = 1;
603       int ret;
604     
605       ret = write(notify_fd, &i, sizeof(i));
>>>     CID 1414508:  Incorrect expression  (PW.ASSIGN_WHERE_COMPARE_MEANT)
>>>     use of "=" where "==" may have been intended
606       assert(ret = sizeof(i));
607     }
608     
609     void RDMAConnectedSocketImpl::shutdown()
610     {
611       if (!error)

** CID 1414509:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 190 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()


________________________________________________________________________________________________________
*** CID 1414509:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/msg/async/net_handler.cc: 190 in ceph::NetHandler::generic_connect(const entity_addr_t &, const entity_addr_t &, bool)()
184         if (ret < 0) {
185           close(s);
186           return ret;
187         }
188       }
189     
>>>     CID 1414509:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "set_socket_options" without checking return value (as is done elsewhere 5 out of 6 times).
190       set_socket_options(s, cct->_conf->ms_tcp_nodelay, cct->_conf->ms_tcp_rcvbuf);
191     
192       {
193         entity_addr_t addr = bind_addr;
194         if (cct->_conf->ms_bind_before_connect && (!addr.is_blank_ip())) {
195           addr.set_port(0);

** CID 1414510:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/libradosstriper/RadosStriperImpl.cc: 378 in <unnamed>::BasicStatCompletionData::BasicStatCompletionData(libradosstriper::RadosStriperImpl *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librados::AioCompletionImpl *, libradosstriper::MultiAioCompletionImpl *, unsigned long *, int)()


________________________________________________________________________________________________________
*** CID 1414510:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/libradosstriper/RadosStriperImpl.cc: 378 in <unnamed>::BasicStatCompletionData::BasicStatCompletionData(libradosstriper::RadosStriperImpl *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librados::AioCompletionImpl *, libradosstriper::MultiAioCompletionImpl *, unsigned long *, int)()
372     			  librados::AioCompletionImpl *userCompletion,
373     			  libradosstriper::MultiAioCompletionImpl *multiCompletion,
374     			  uint64_t *psize,
375     			  int n = 1) :
376         CompletionData(striper, soid, "", userCompletion, n),
377         m_multiCompletion(multiCompletion), m_psize(psize),
>>>     CID 1414510:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_objectSize" is not initialized in this constructor nor in any functions that it calls.
378         m_statRC(0), m_getxattrRC(0) {};
379       // MultiAioCompletionImpl used to handle the double aysnc
380       // call in the back (stat + getxattr)
381       libradosstriper::MultiAioCompletionImpl *m_multiCompletion;
382       // where to store the size of first objct
383       // this will be ignored but we need a place to store it when

** CID 1414511:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 554 in RDMAStack::RDMAStack(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1414511:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 554 in RDMAStack::RDMAStack(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
548       ldout(cct, 20) << __func__ << " constructing RDMAStack..." << dendl;
549       dispatcher = new RDMADispatcher(cct, this);
550       global_infiniband->set_dispatcher(dispatcher);
551     
552       unsigned num = get_num_worker();
553       for (unsigned i = 0; i < num; ++i) {
>>>     CID 1414511:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "w" = "dynamic_cast <RDMAWorker *>(this->get_worker(i))".
554         RDMAWorker* w = dynamic_cast<RDMAWorker*>(get_worker(i));
555         w->set_stack(this);
556       }
557     
558       ldout(cct, 20) << " creating RDMAStack:" << this << " with dispatcher:" << dispatcher << dendl;
559     }

** CID 1414512:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 480 in Infiniband::MemoryManager::Chunk::Chunk(ibv_mr *, unsigned int, char *)()


________________________________________________________________________________________________________
*** CID 1414512:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 480 in Infiniband::MemoryManager::Chunk::Chunk(ibv_mr *, unsigned int, char *)()
474     }
475     
476     
477     Infiniband::MemoryManager::Chunk::Chunk(ibv_mr* m, uint32_t len, char* b)
478       : mr(m), bytes(len), offset(0), buffer(b)
479     {
>>>     CID 1414512:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "bound" is not initialized in this constructor nor in any functions that it calls.
480     }
481     
482     Infiniband::MemoryManager::Chunk::~Chunk()
483     {
484     }
485     

** CID 1414513:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/mon/LogMonitor.cc: 433 in LogMonitor::preprocess_command(boost::intrusive_ptr<MonOpRequest>)()


________________________________________________________________________________________________________
*** CID 1414513:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/mon/LogMonitor.cc: 433 in LogMonitor::preprocess_command(boost::intrusive_ptr<MonOpRequest>)()
427         auto match = [level, channel](const LogEntry &entry) {
428           return entry.prio >= level && (entry.channel == channel || channel == "*");
429         };
430     
431         auto p = summary.tail.end();
432         while (num > 0 && p != summary.tail.begin()) {
>>>     CID 1414513:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
433           if (match(*p)) {
434             num--;
435           }
436           --p;
437         }
438         ostringstream ss;

** CID 1414514:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/filestore/FileStore.cc: 3255 in FileStore::read(const coll_t &, const ghobject_t &, unsigned long, unsigned long, ceph::buffer::list &, unsigned int)()


________________________________________________________________________________________________________
*** CID 1414514:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/filestore/FileStore.cc: 3255 in FileStore::read(const coll_t &, const ghobject_t &, unsigned long, unsigned long, ceph::buffer::list &, unsigned int)()
3249       dout(10) << __FUNC__ << ": " << cid << "/" << oid << " " << offset << "~"
3250     	   << got << "/" << len << dendl;
3251       if (cct->_conf->filestore_debug_inject_read_err &&
3252           debug_data_eio(oid)) {
3253         return -EIO;
3254       } else if (cct->_conf->filestore_debug_random_read_err &&
>>>     CID 1414514:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3255         (rand() % (int)(cct->_conf->filestore_debug_random_read_err * 100.0)) == 0) {
3256         dout(0) << __func__ << ": inject random EIO" << dendl;
3257         return -EIO;
3258       } else {
3259         tracepoint(objectstore, read_exit, got);
3260         return got;

** CID 1414515:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 559 in RDMAStack::RDMAStack(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()


________________________________________________________________________________________________________
*** CID 1414515:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAStack.cc: 559 in RDMAStack::RDMAStack(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
553       for (unsigned i = 0; i < num; ++i) {
554         RDMAWorker* w = dynamic_cast<RDMAWorker*>(get_worker(i));
555         w->set_stack(this);
556       }
557     
558       ldout(cct, 20) << " creating RDMAStack:" << this << " with dispatcher:" << dispatcher << dendl;
>>>     CID 1414515:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "perf_counter" is not initialized in this constructor nor in any functions that it calls.
559     }
560     
561     RDMAStack::~RDMAStack()
562     {
563       if (cct->_conf->ms_async_rdma_enable_hugepage) {
564         unsetenv("RDMAV_HUGEPAGES_SAFE");	//remove env variable on destruction

** CID 1414516:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 715 in Infiniband::Infiniband(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned char)()


________________________________________________________________________________________________________
*** CID 1414516:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 715 in Infiniband::Infiniband(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, unsigned char)()
709     }
710     
711     
712     Infiniband::Infiniband(CephContext *cct, const std::string &device_name, uint8_t port_num)
713       : cct(cct), lock("IB lock"), device_name(device_name), port_num(port_num)
714     {
>>>     CID 1414516:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "pd" is not initialized in this constructor nor in any functions that it calls.
715     }
716     
717     void Infiniband::init()
718     {
719       Mutex::Locker l(lock);
720     

** CID 1414517:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/io/test_mock_ImageRequestWQ.cc: 50 in librbd::io::ImageRequest<librbd::<unnamed>::MockTestImageCtx>::ImageRequest()()


________________________________________________________________________________________________________
*** CID 1414517:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/test/librbd/io/test_mock_ImageRequestWQ.cc: 50 in librbd::io::ImageRequest<librbd::<unnamed>::MockTestImageCtx>::ImageRequest()()
44       MOCK_CONST_METHOD0(start_op, void());
45       MOCK_CONST_METHOD0(send, void());
46       MOCK_CONST_METHOD1(fail, void(int));
47     
48       ImageRequest() {
49         s_instance = this;
>>>     CID 1414517:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "aio_comp" is not initialized in this constructor nor in any functions that it calls.
50       }
51     };
52     
53     } // namespace io
54     
55     namespace util {

** CID 1414518:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/ReplicatedBackend.cc: 2037 in ReplicatedBackend::build_push_op(const ObjectRecoveryInfo &, const ObjectRecoveryProgress &, ObjectRecoveryProgress *, PushOp *, object_stat_sum_t *, bool)()


________________________________________________________________________________________________________
*** CID 1414518:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/ReplicatedBackend.cc: 2037 in ReplicatedBackend::build_push_op(const ObjectRecoveryInfo &, const ObjectRecoveryProgress &, ObjectRecoveryProgress *, PushOp *, object_stat_sum_t *, bool)()
2031            ++p) {
2032         bufferlist bit;
2033         int r = store->read(ch, ghobject_t(recovery_info.soid),
2034     		p.get_start(), p.get_len(), bit,
2035                     cache_dont_need ? CEPH_OSD_OP_FLAG_FADVISE_DONTNEED: 0);
2036         if (cct->_conf->osd_debug_random_push_read_error &&
>>>     CID 1414518:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2037             (rand() % (int)(cct->_conf->osd_debug_random_push_read_error * 100.0)) == 0) {
2038           dout(0) << __func__ << ": inject EIO " << recovery_info.soid << dendl;
2039           r = -EIO;
2040         }
2041         if (r < 0) {
2042           return r;

** CID 1414519:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: 392 in RDMAConnectedSocketImpl::zero_copy_read(ceph::buffer::ptr &)()


________________________________________________________________________________________________________
*** CID 1414519:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/msg/async/rdma/RDMAConnectedSocketImpl.cc: 392 in RDMAConnectedSocketImpl::zero_copy_read(ceph::buffer::ptr &)()
386           // FIXME need to handle release
387           // auto del = std::bind(&Chunk::post_srq, std::move(chunk), infiniband);
388           size = chunk->bound;
389           continue;
390         }
391         buffers.push_back(chunk);
>>>     CID 1414519:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Incrementing iterator "iter" though it is already past the end of its container.
392         iter++;
393       }
394     
395       if (size == 0)
396         return -EAGAIN;
397       return size;

** CID 1414520:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 931 in Infiniband::send_msg(CephContext *, int, IBSYNMsg &)()


________________________________________________________________________________________________________
*** CID 1414520:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 931 in Infiniband::send_msg(CephContext *, int, IBSYNMsg &)()
925       sprintf(msg, "%04x:%08x:%08x:%08x:%s", im.lid, im.qpn, im.psn, im.peer_qpn, gid);
926       ldout(cct, 10) << __func__ << " sending: " << im.lid << ", " << im.qpn << ", " << im.psn
927                      << ", " << im.peer_qpn << ", "  << gid  << dendl;
928       r = ::write(sd, msg, sizeof(msg));
929       // Drop incoming qpt
930       if (cct->_conf->ms_inject_socket_failures && sd >= 0) {
>>>     CID 1414520:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
931         if (rand() % cct->_conf->ms_inject_socket_failures == 0) {
932           ldout(cct, 0) << __func__ << " injecting socket failure" << dendl;
933           return -EINVAL;
934         }
935       }
936     

** CID 1414521:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/libradosstriper/RadosStriperImpl.cc: 279 in <unnamed>::WriteCompletionData::WriteCompletionData(libradosstriper::RadosStriperImpl *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librados::AioCompletionImpl *, int)()


________________________________________________________________________________________________________
*** CID 1414521:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/libradosstriper/RadosStriperImpl.cc: 279 in <unnamed>::WriteCompletionData::WriteCompletionData(libradosstriper::RadosStriperImpl *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, librados::AioCompletionImpl *, int)()
273      int n) :
274       CompletionData(striper, soid, lockCookie, userCompletion, n), m_safe(0),
275       m_unlockCompletion(0) {
276       if (userCompletion) {
277         m_safe = new librados::IoCtxImpl::C_aio_Complete(userCompletion);
278       }
>>>     CID 1414521:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_writeRc" is not initialized in this constructor nor in any functions that it calls.
279     }
280     
281     WriteCompletionData::~WriteCompletionData() {
282       m_unlockCompletion->release();
283       if (m_safe) delete m_safe;
284     }

** CID 1414522:  Memory - corruptions  (REVERSE_NEGATIVE)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 930 in Infiniband::send_msg(CephContext *, int, IBSYNMsg &)()


________________________________________________________________________________________________________
*** CID 1414522:  Memory - corruptions  (REVERSE_NEGATIVE)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 930 in Infiniband::send_msg(CephContext *, int, IBSYNMsg &)()
924       gid_to_wire_gid(&(im.gid), gid);
925       sprintf(msg, "%04x:%08x:%08x:%08x:%s", im.lid, im.qpn, im.psn, im.peer_qpn, gid);
926       ldout(cct, 10) << __func__ << " sending: " << im.lid << ", " << im.qpn << ", " << im.psn
927                      << ", " << im.peer_qpn << ", "  << gid  << dendl;
928       r = ::write(sd, msg, sizeof(msg));
929       // Drop incoming qpt
>>>     CID 1414522:  Memory - corruptions  (REVERSE_NEGATIVE)
>>>     You might be using variable "sd" before verifying that it is >= 0.
930       if (cct->_conf->ms_inject_socket_failures && sd >= 0) {
931         if (rand() % cct->_conf->ms_inject_socket_failures == 0) {
932           ldout(cct, 0) << __func__ << " injecting socket failure" << dendl;
933           return -EINVAL;
934         }
935       }

** CID 1414523:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 127 in Device::Device(CephContext *, ibv_device *)()


________________________________________________________________________________________________________
*** CID 1414523:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 127 in Device::Device(CephContext *, ibv_device *)()
121       }
122       int r = ibv_query_device(ctxt, device_attr);
123       if (r == -1) {
124         lderr(cct) << __func__ << " failed to query rdma device. " << cpp_strerror(errno) << dendl;
125         ceph_abort();
126       }
>>>     CID 1414523:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "port_cnt" is not initialized in this constructor nor in any functions that it calls.
127     }
128     
129     void Device::binding_port(CephContext *cct, int port_num) {
130       port_cnt = device_attr->phys_port_cnt;
131       for (uint8_t i = 0; i < port_cnt; ++i) {
132         Port *port = new Port(cct, ctxt, i+1);

** CID 1414524:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 565 in Infiniband::MemoryManager::Cluster::Cluster(Infiniband::MemoryManager&, unsigned int)()


________________________________________________________________________________________________________
*** CID 1414524:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 565 in Infiniband::MemoryManager::Cluster::Cluster(Infiniband::MemoryManager&, unsigned int)()
559       ib->post_chunk(this);
560     }
561     
562     Infiniband::MemoryManager::Cluster::Cluster(MemoryManager& m, uint32_t s)
563       : manager(m), buffer_size(s), lock("cluster_lock")
564     {
>>>     CID 1414524:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "num_chunk" is not initialized in this constructor nor in any functions that it calls.
565     }
566     
567     Infiniband::MemoryManager::Cluster::~Cluster()
568     {
569       int r = ibv_dereg_mr(chunk_base->mr);
570       assert(r == 0);

** CID 1414525:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 107 in Port::Port(CephContext *, ibv_context *, unsigned char)()


________________________________________________________________________________________________________
*** CID 1414525:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 107 in Port::Port(CephContext *, ibv_context *, unsigned char)()
101       r = ibv_query_gid(ctxt, port_num, 0, &gid);
102       if (r) {
103         lderr(cct) << __func__  << " query gid failed  " << cpp_strerror(errno) << dendl;
104         ceph_abort();
105       }
106     #endif
>>>     CID 1414525:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "gid_idx" is not initialized in this constructor nor in any functions that it calls.
107     }
108     
109     
110     Device::Device(CephContext *cct, ibv_device* d): device(d), device_attr(new ibv_device_attr), active_port(nullptr)
111     {
112       if (device == NULL) {

** CID 1414526:  Memory - corruptions  (REVERSE_NEGATIVE)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 893 in Infiniband::recv_msg(CephContext *, int, IBSYNMsg &)()


________________________________________________________________________________________________________
*** CID 1414526:  Memory - corruptions  (REVERSE_NEGATIVE)
/home/brad/working/src/ceph/src/msg/async/rdma/Infiniband.cc: 893 in Infiniband::recv_msg(CephContext *, int, IBSYNMsg &)()
887     int Infiniband::recv_msg(CephContext *cct, int sd, IBSYNMsg& im)
888     {
889       char msg[TCP_MSG_LEN];
890       char gid[33];
891       ssize_t r = ::read(sd, &msg, sizeof(msg));
892       // Drop incoming qpt
>>>     CID 1414526:  Memory - corruptions  (REVERSE_NEGATIVE)
>>>     You might be using variable "sd" before verifying that it is >= 0.
893       if (cct->_conf->ms_inject_socket_failures && sd >= 0) {
894         if (rand() % cct->_conf->ms_inject_socket_failures == 0) {
895           ldout(cct, 0) << __func__ << " injecting socket failure" << dendl;
896           return -EINVAL;
897         }
898       }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FS4QUbvARQoOgvORDHL0r0P39yajanM5mcACKANuEqByf-2BI2jCb572luKStyPuF1x6lzO3p4WEelq6u0X-2BZBf8bI5F5jyfbNcAr5n7c5AJc0ObPcp3lHIHEcFGuCvZgbz9cYAXHqb7BQX7julEM31K4LBsNm1EgO3syRPWK390k5uH8VoPtX4zBx17IupHh8I-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FS4QUbvARQoOgvORDHL0r0P39yajanM5mcACKANuEqBwpVRh-2BRDYYk1QUJuHjs4dvF2GgMhWDO2-2B5LD2hfRUDGMXGsmNFxt6P7u8poP2zMyEKc4BEYelA6D06gIdk9u0EgGdRk-2FrXANh8ydNC-2FTStWPJdeM-2Fg6Thr844gaM4nZD9-2Bb5K4a70iE1ppNWXMXKvw-3D

