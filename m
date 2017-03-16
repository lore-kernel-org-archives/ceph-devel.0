From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 16 Mar 2017 00:37:15 -0700
Message-ID: <58ca40ab4f062_29df12f732070285@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.24nn.shared.sendgrid.net ([167.89.100.237]:6317 "EHLO
        o1.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbdCPHhR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Mar 2017 03:37:17 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0001p1sjc2.sendgrid.net (SG) with ESMTP id szBv7wjeRXS9vhKmQZbWkg
        for <ceph-devel@vger.kernel.org>; Thu, 16 Mar 2017 07:37:15.411 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

38 new defect(s) introduced to ceph found with Coverity Scan.
9 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 38 defect(s)


** CID 1351753:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 1238 in RGWGetObj::handle_slo_manifest(ceph::buffer::list &)()


________________________________________________________________________________________________________
*** CID 1351753:  Memory - illegal accesses  (WRAPPER_ESCAPE)
/home/brad/working/src/ceph/src/rgw/rgw_op.cc: 1238 in RGWGetObj::handle_slo_manifest(ceph::buffer::list &)()
1232             if (r < 0) {
1233               ldout(s->cct, 0) << "failed to read bucket policy for bucket "
1234                                << bucket << dendl;
1235               return r;
1236             }
1237             buckets[bucket_name] = bucket;
>>>     CID 1351753:  Memory - illegal accesses  (WRAPPER_ESCAPE)
>>>     "bucket_policy" escapes into "policies[bucket_name]", but is a copy of an internal representation that is destroyed when it exits scope.
1238             policies[bucket_name] = bucket_policy;
1239           }
1240         } else {
1241           bucket = s->bucket;
1242           bucket_policy = s->bucket_acl;
1243         }

** CID 1402598:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 1584 in fix_zone_pool_dup(std::set<rgw_pool, std::less<rgw_pool>, std::allocator<rgw_pool>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const rgw_pool &)()


________________________________________________________________________________________________________
*** CID 1402598:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 1584 in fix_zone_pool_dup(std::set<rgw_pool, std::less<rgw_pool>, std::allocator<rgw_pool>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const rgw_pool &)()
1578       rgw_pool pool(prefix + suffix);
1579       
1580       if (pools.find(pool) == pools.end()) {
1581         return pool;
1582       } else {
1583         while(true) {
>>>     CID 1402598:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1584           pool =  prefix + "_" + std::to_string(std::rand()) + suffix;
1585           if (pools.find(pool) == pools.end()) {
1586     	return pool;
1587           }
1588         }
1589       }  

** CID 1402599:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/librbd/api/Group.cc: 39 in librbd::api::Group<librbd::ImageCtx>::create(librados::IoCtx &, const char *)()


________________________________________________________________________________________________________
*** CID 1402599:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/librbd/api/Group.cc: 39 in librbd::api::Group<librbd::ImageCtx>::create(librados::IoCtx &, const char *)()
33     {
34       CephContext *cct = (CephContext *)io_ctx.cct();
35     
36       Rados rados(io_ctx);
37       uint64_t bid = rados.get_instance_id();
38     
>>>     CID 1402599:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
39       uint32_t extra = rand() % 0xFFFFFFFF;
40       ostringstream bid_ss;
41       bid_ss << std::hex << bid << std::hex << extra;
42       string id = bid_ss.str();
43     
44       ldout(cct, 2) << "adding consistency group to directory..." << dendl;

** CID 1402600:  Incorrect expression  (IDENTICAL_BRANCHES)
/home/brad/working/src/ceph/src/librbd/Journal.cc: 471 in librbd::Journal<librbd::ImageCtx>::is_tag_owner(librados::IoCtx &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool *, ContextWQ *)()


________________________________________________________________________________________________________
*** CID 1402600:  Incorrect expression  (IDENTICAL_BRANCHES)
/home/brad/working/src/ceph/src/librbd/Journal.cc: 471 in librbd::Journal<librbd::ImageCtx>::is_tag_owner(librados::IoCtx &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool *, ContextWQ *)()
465     int Journal<I>::is_tag_owner(librados::IoCtx& io_ctx, std::string& image_id,
466                                  bool *is_tag_owner, ContextWQ *op_work_queue) {
467       C_SaferCond ctx;
468       Journal<I>::is_tag_owner(io_ctx, image_id, is_tag_owner, op_work_queue, &ctx);
469     
470       int r = ctx.wait();
>>>     CID 1402600:  Incorrect expression  (IDENTICAL_BRANCHES)
>>>     The same code is executed when the condition "r < 0" is true or false, because the code in the if-then branch and after the if statement is identical. Should the if statement be removed?
471       if (r < 0) {
472         return r;
473       }
474       return r;
475     }
476     

** CID 1402601:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402601:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/rgw/test_rgw_common.h: 50 in old_rgw_bucket::encode(ceph::buffer::list &) const()
44         marker = "";
45       }
46       old_rgw_bucket(const char *t, const char *n, const char *dp, const char *ip, const char *m, const char *id, const char *h) :
47         tenant(t), name(n), data_pool(dp), index_pool(ip), marker(m), bucket_id(id) {}
48     
49       void encode(bufferlist& bl) const {
>>>     CID 1402601:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
50          ENCODE_START(8, 3, bl);
51         ::encode(name, bl);
52         ::encode(data_pool, bl);
53         ::encode(marker, bl);
54         ::encode(bucket_id, bl);
55         ::encode(index_pool, bl);

** CID 1402602:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402602:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/rgw/test_rgw_common.h: 382 in old_rgw_obj::encode(ceph::buffer::list &) const()
376     
377       bool is_in_extra_data() const {
378         return in_extra_data;
379       }
380     
381       void encode(bufferlist& bl) const {
>>>     CID 1402602:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
382         ENCODE_START(5, 3, bl);
383         ::encode(bucket.name, bl);
384         ::encode(loc, bl);
385         ::encode(ns, bl);
386         ::encode(object, bl);
387         ::encode(bucket, bl);

** CID 1402603:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402603:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/rgw/test_rgw_manifest.cc: 42 in OldObjManifestPart::encode(ceph::buffer::list &) const()
36       uint64_t loc_ofs;  /* the offset at that object where the data is located */
37       uint64_t size;     /* the part size */
38     
39       OldObjManifestPart() : loc_ofs(0), size(0) {}
40     
41       void encode(bufferlist& bl) const {
>>>     CID 1402603:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
42         ENCODE_START(2, 2, bl);
43         ::encode(loc, bl);
44         ::encode(loc_ofs, bl);
45         ::encode(size, bl);
46         ENCODE_FINISH(bl);
47       }

** CID 1402604:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402604:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/test/rgw/test_rgw_manifest.cc: 89 in OldObjManifest::encode(ceph::buffer::list &) const()
83       void append(uint64_t ofs, const OldObjManifestPart& part) {
84         objs[ofs] = part;
85         obj_size = max(obj_size, ofs + part.size);
86       }
87     
88       void encode(bufferlist& bl) const {
>>>     CID 1402604:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
89         ENCODE_START(2, 2, bl);
90         ::encode(obj_size, bl);
91         ::encode(objs, bl);
92         ENCODE_FINISH(bl);
93       }
94     

** CID 1402605:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402605:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/rgw/rgw_common.h: 768 in rgw_pool::encode(ceph::buffer::list &) const()
762           return r;
763         }
764         return ns.compare(p.ns);
765       }
766     
767       void encode(bufferlist& bl) const {
>>>     CID 1402605:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
768          ENCODE_START(10, 10, bl);
769         ::encode(name, bl);
770         ::encode(ns, bl);
771         ENCODE_FINISH(bl);
772       }
773     

** CID 1402606:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1402606:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/rgw/rgw_common.h: 875 in rgw_raw_obj::encode(ceph::buffer::list &) const()
869     
870       bool empty() const {
871         return oid.empty();
872       }
873     
874       void encode(bufferlist& bl) const {
>>>     CID 1402606:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
875          ENCODE_START(6, 6, bl);
876         ::encode(pool, bl);
877         ::encode(oid, bl);
878         ::encode(loc, bl);
879         ENCODE_FINISH(bl);
880       }

** CID 1402607:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 605 in boost::detail::function::basic_vtable1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, boost::detail::function::function_obj_tag) const()


________________________________________________________________________________________________________
*** CID 1402607:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 605 in boost::detail::function::basic_vtable1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, boost::detail::function::function_obj_tag) const()
599               functor_wrapper_type* new_f = static_cast<functor_wrapper_type*>(copy);
600               functor.members.obj_ptr = new_f;
601             }
602     
603             template<typename FunctionObj>
604             bool
>>>     CID 1402607:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
605             assign_to(FunctionObj f, function_buffer& functor, function_obj_tag) const
606             {
607               if (!boost::detail::function::has_empty_target(boost::addressof(f))) {
608                 assign_functor(f, functor,
609                                mpl::bool_<(function_allows_small_object_optimization<FunctionObj>::value)>());
610                 return true;

** CID 1402608:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 584 in boost::detail::function::basic_vtable1<void, int>::assign_functor<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, mpl_::bool_<(bool)0>) const()


________________________________________________________________________________________________________
*** CID 1402608:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 584 in boost::detail::function::basic_vtable1<void, int>::assign_functor<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &, mpl_::bool_<(bool)0>) const()
578               assign_functor(f,functor,mpl::true_());
579             }
580     
581             // Assign to a function object allocated on the heap.
582             template<typename FunctionObj>
583             void
>>>     CID 1402608:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
584             assign_functor(FunctionObj f, function_buffer& functor, mpl::false_) const
585             {
586               functor.members.obj_ptr = new FunctionObj(f);
587             }
588             template<typename FunctionObj,typename Allocator>
589             void

** CID 1402609:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 1402609:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
712     
713         BOOST_FUNCTION_FUNCTION() : function_base() { }
714     
715         // MSVC chokes if the following two constructors are collapsed into
716         // one with a default parameter.
717         template<typename Functor>
>>>     CID 1402609:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
718         BOOST_FUNCTION_FUNCTION(Functor BOOST_FUNCTION_TARGET_FIX(const &) f
719     #ifndef BOOST_NO_SFINAE
720                                 ,typename boost::enable_if_c<
721                                  !(is_integral<Functor>::value),
722                                             int>::type = 0
723     #endif // BOOST_NO_SFINAE

** CID 1402610:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 495 in boost::detail::function::basic_vtable1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &) const()


________________________________________________________________________________________________________
*** CID 1402610:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 495 in boost::detail::function::basic_vtable1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::detail::function::function_buffer &) const()
489     
490             typedef result_type (*invoker_type)(function_buffer&
491                                                 BOOST_FUNCTION_COMMA
492                                                 BOOST_FUNCTION_TEMPLATE_ARGS);
493     
494             template<typename F>
>>>     CID 1402610:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
495             bool assign_to(F f, function_buffer& functor) const
496             {
497               typedef typename get_function_tag<F>::type tag;
498               return assign_to(f, functor, tag());
499             }
500             template<typename F,typename Allocator>

** CID 1402611:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 1402611:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
1059     
1060     public:
1061     
1062       function() : base_type() {}
1063     
1064       template<typename Functor>
>>>     CID 1402611:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
1065       function(Functor f
1066     #ifndef BOOST_NO_SFINAE
1067                ,typename boost::enable_if_c<
1068                               !(is_integral<Functor>::value),
1069                            int>::type = 0
1070     #endif

** CID 1402612:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1)()


________________________________________________________________________________________________________
*** CID 1402612:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]>(T1)()
911               get_vtable()->base.manager(f.functor, this->functor,
912                                          boost::detail::function::clone_functor_tag);
913           }
914         }
915     
916         template<typename Functor>
>>>     CID 1402612:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "librados::TestWatchNotify::execute_notify(librados::TestRadosClient *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long)::[lambda(int) (instance 1)]" (size 224 bytes) by value.
917         void assign_to(Functor f)
918         {
919           using boost::detail::function::vtable_base;
920     
921           typedef typename boost::detail::function::get_function_tag<Functor>::type tag;
922           typedef boost::detail::function::BOOST_FUNCTION_GET_INVOKER<tag> get_invoker;

** CID 1402613:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 2624 in RGWPutObjProcessor_Atomic::complete_writing_data()()


________________________________________________________________________________________________________
*** CID 1402613:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 2624 in RGWPutObjProcessor_Atomic::complete_writing_data()()
2618         bufferlist bl;
2619         pending_data_bl.splice(0, max_write_size, &bl);
2620         uint64_t write_len = bl.length();
2621         int r = write_data(bl, data_ofs, &handle, &obj, false);
2622         if (r < 0) {
2623           ldout(store->ctx(), 0) << "ERROR: write_data() returned " << r << dendl;
>>>     CID 1402613:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "handle" going out of scope leaks the storage it points to.
2624           return r;
2625         }
2626         data_ofs += write_len;
2627         r = throttle_data(handle, obj, write_len, false);
2628         if (r < 0) {
2629           ldout(store->ctx(), 0) << "ERROR: throttle_data() returned " << r << dendl;

** CID 1402614:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 12966 in RGWRados::delete_raw_obj_aio(const rgw_raw_obj &, std::__cxx11::list<librados::AioCompletion *, std::allocator<librados::AioCompletion *>> &)()


________________________________________________________________________________________________________
*** CID 1402614:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 12966 in RGWRados::delete_raw_obj_aio(const rgw_raw_obj &, std::__cxx11::list<librados::AioCompletion *, std::allocator<librados::AioCompletion *>> &)()
12960       cls_rgw_remove_obj(op, prefixes);
12961     
12962       AioCompletion *c = librados::Rados::aio_create_completion(NULL, NULL, NULL);
12963       ret = ref.ioctx.aio_operate(ref.oid, c, &op);
12964       if (ret < 0) {
12965         lderr(cct) << "ERROR: AioOperate failed with ret=" << ret << dendl;
>>>     CID 1402614:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "c" going out of scope leaks the storage it points to.
12966         return ret;
12967       }
12968     
12969       handles.push_back(c);
12970     
12971       return 0;

** CID 1402615:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 7692 in RGWRados::copy_obj_data(RGWObjectCtx &, RGWBucketInfo &, RGWRados::Object::Read &, long, rgw_obj &, rgw_obj &, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &, RGWObjCatego
 ry, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::__cxx11::basic_string<char, std::
 char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, ceph::buffer::list *, rgw_err *)()


________________________________________________________________________________________________________
*** CID 1402615:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 7692 in RGWRados::copy_obj_data(RGWObjectCtx &, RGWBucketInfo &, RGWRados::Object::Read &, long, rgw_obj &, rgw_obj &, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>> *, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &, RGWObjCatego
 ry, unsigned long, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<(long)1, (long)1000000000>>>, std::__cxx11::basic_string<char, std::
 char_traits<char>, std::allocator<char>> *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *, ceph::buffer::list *, rgw_err *)()
7686         do {
7687           void *handle;
7688           rgw_raw_obj obj;
7689     
7690           ret = processor.handle_data(bl, ofs, &handle, &obj, &again);
7691           if (ret < 0) {
>>>     CID 1402615:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "handle" going out of scope leaks the storage it points to.
7692             return ret;
7693           }
7694           ret = processor.throttle_data(handle, obj, end - ofs + 1, false);
7695           if (ret < 0)
7696             return ret;
7697         } while (again);

** CID 1402616:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 13004 in RGWRados::delete_obj_aio(const rgw_obj &, RGWBucketInfo &, RGWObjState *, std::__cxx11::list<librados::AioCompletion *, std::allocator<librados::AioCompletion *>> &, bool)()


________________________________________________________________________________________________________
*** CID 1402616:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/rgw/rgw_rados.cc: 13004 in RGWRados::delete_obj_aio(const rgw_obj &, RGWBucketInfo &, RGWObjState *, std::__cxx11::list<librados::AioCompletion *, std::allocator<librados::AioCompletion *>> &, bool)()
12998       cls_rgw_remove_obj(op, prefixes);
12999     
13000       AioCompletion *c = librados::Rados::aio_create_completion(NULL, NULL, NULL);
13001       ret = ref.ioctx.aio_operate(ref.oid, c, &op);
13002       if (ret < 0) {
13003         lderr(cct) << "ERROR: AioOperate failed with ret=" << ret << dendl;
>>>     CID 1402616:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "c" going out of scope leaks the storage it points to.
13004         return ret;
13005       }
13006     
13007       handles.push_back(c);
13008     
13009       if (keep_index_consistent) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GfQlGh3X238-2BpQ7Ww0V7r0k3azlSCcsuKGojMCI31G8L62To8QI4ZEYPuaVuurk-2BnlICVsFSEe-2FDPfVY9jmI7AVwwvEu-2FB9pCXjaiVO3f0WfETQoLXrVRnYfpahZzj7vcmq64aAay-2FXEgvfoNRRr9BzZfRomJASScXmEtmfEgCXIULyHyjqbtLVIcKs3-2Bnss0-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GfQlGh3X238-2BpQ7Ww0V7r0k3azlSCcsuKGojMCI31G8CYbu057LMT92ZgDgOU5mtjJHv9AeJSUAQyUZid6i-2BsaKYvrSBiX-2FE7RS8IDMyyppvIAJsJDDJQP7DHzWeC2-2FbQfK-2FtFadDWvdO2kyVeSjL4HLci8BJACNDzL3nMDvwyswitemCTAUaKf3IGblDOpn8-3D

