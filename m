From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 13 Feb 2016 09:47:53 -0800
Message-ID: <56bf6c49d63b0_6a49f2d320925c9@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37572 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbcBMRrj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Feb 2016 12:47:39 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 632ED10C0647
	for <ceph-devel@vger.kernel.org>; Sat, 13 Feb 2016 09:47:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

17 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 17 of 17 defect(s)


** CID 1352185:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_file.cc: 419 in rgw::RGWFileHandle::write(unsigned long, unsigned long, unsigned long *, void *)()


________________________________________________________________________________________________________
*** CID 1352185:  Code maintainability issues  (UNUSED_VALUE)
/rgw/rgw_file.cc: 419 in rgw::RGWFileHandle::write(unsigned long, unsigned long, unsigned long *, void *)()
413         if (! f->write_req) {
414           /* start */
415           std::string object_name = relative_object_name();
416           f->write_req =
417     	new RGWWriteRequest(fs->get_context(), fs->get_user(), this,
418     			    bucket_name(), object_name);
>>>     CID 1352185:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "rgw::rgwlib.get_fe()->start_req(f->write_req)" to "rc" here, but that stored value is overwritten before it can be used.
419           rc = rgwlib.get_fe()->start_req(f->write_req);
420         }
421     
422         buffer::list bl;
423         /* XXXX */
424     #if 0

** CID 1352184:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_lib.h: 33 in rgw::RGWLib::RGWLib()()


________________________________________________________________________________________________________
*** CID 1352184:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_lib.h: 33 in rgw::RGWLib::RGWLib()()
27         RGWREST rest; // XXX needed for RGWProcessEnv
28         RGWProcessEnv env;
29         RGWRados* store;
30     
31       public:
32         RGWLib() : fec(nullptr), fe(nullptr), olog(nullptr), store(nullptr)
>>>     CID 1352184:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "env.port" is not initialized in this constructor nor in any functions that it calls.
33           {}
34         ~RGWLib() {}
35     
36         RGWRados* get_store() { return store; }
37     
38         RGWLibFrontend* get_fe() { return fe; }

** CID 1352183:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_common.cc: 178 in req_state::req_state(CephContext *, RGWEnv *, RGWUserInfo *)()


________________________________________________________________________________________________________
*** CID 1352183:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_common.cc: 178 in req_state::req_state(CephContext *, RGWEnv *, RGWUserInfo *)()
172       has_bad_meta = false;
173       length = NULL;
174       http_auth = NULL;
175       local_source = false;
176     
177       obj_ctx = NULL;
>>>     CID 1352183:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "req" is not initialized in this constructor nor in any functions that it calls.
178     }
179     
180     req_state::~req_state() {
181       delete formatter;
182       delete bucket_acl;
183       delete object_acl;

** CID 1352182:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 226 in rgw::RGWFileHandle::RGWFileHandle(rgw::RGWLibFS *, unsigned int)()


________________________________________________________________________________________________________
*** CID 1352182:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 226 in rgw::RGWFileHandle::RGWFileHandle(rgw::RGWLibFS *, unsigned int)()
220     	fh.fh_type = RGW_FS_TYPE_DIRECTORY;
221     	variant_type = directory();
222     	/* stat */
223     	state.dev = fs_inst;
224     	/* pointer to self */
225     	fh.fh_private = this;
>>>     CID 1352182:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "fh.fh_hk" is not initialized in this constructor nor in any functions that it calls.
226           }
227         
228         void init_rootfs(std::string& fsid, const std::string& object_name) {
229           /* fh_key */
230           fh.fh_hk.bucket = XXH64(fsid.c_str(), fsid.length(), fh_key::seed);
231           fh.fh_hk.object = XXH64(object_name.c_str(), object_name.length(),

** CID 1352181:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 79 in rgw::fh_key::fh_key()()


________________________________________________________________________________________________________
*** CID 1352181:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 79 in rgw::fh_key::fh_key()()
73       struct fh_key
74       {
75         rgw_fh_hk fh_hk;
76     
77         static constexpr uint64_t seed = 8675309;
78     
>>>     CID 1352181:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "fh_hk.object" is not initialized in this constructor nor in any functions that it calls.
79         fh_key() {}
80     
81         fh_key(const rgw_fh_hk& _hk)
82           : fh_hk(_hk) {
83           // nothing
84         }

** CID 1352180:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 641 in rgw::RGWLibFS::RGWLibFS(CephContext *, const char *, const char *, const char *)()


________________________________________________________________________________________________________
*** CID 1352180:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_file.h: 641 in rgw::RGWLibFS::RGWLibFS(CephContext *, const char *, const char *, const char *)()
635     
636           /* pointer to self */
637           fs.fs_private = this;
638     
639           /* expose public root fh */
640           fs.root_fh = root_fh.get_fh();
>>>     CID 1352180:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "fs.rgw" is not initialized in this constructor nor in any functions that it calls.
641         }
642     
643         friend void intrusive_ptr_add_ref(const RGWLibFS* fs) {
644           fs->refcnt.fetch_add(1, std::memory_order_relaxed);
645         }
646     

** CID 1352177:  Incorrect expression  (SIZEOF_MISMATCH)
/test/librgw_file_gp.cc: 311 in LibRGW_WRITEV_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352177:  Incorrect expression  (SIZEOF_MISMATCH)
/test/librgw_file_gp.cc: 311 in LibRGW_WRITEV_Test::TestBody()()
305     
306     TEST(LibRGW, WRITEV)
307     {
308       if (do_writev) {
309         rgw_uio* uio;
310         struct iovec *iovs = zp_set1.get_iovs();
>>>     CID 1352177:  Incorrect expression  (SIZEOF_MISMATCH)
>>>     Adding "56UL /* sizeof (rgw_uio) */" to pointer "uio" of type "rgw_uio *" is suspicious because adding an integral value to this pointer automatically scales that value by the size, 56 bytes, of the pointed-to type, "rgw_uio".  Most likely, "sizeof (rgw_uio)" is extraneous and should be replaced with 1.
311         alloca_uio();
312         ASSERT_NE(uio, nullptr);
313     
314         for (int ix = 0; ix < iovcnt; ++ix) {
315           struct iovec *iov = &iovs[ix];
316           rgw_vio *vio = &(uio->uio_vio[ix]);

** CID 1352176:    (RESOURCE_LEAK)
/test/librgw_file_nfsns.cc: 652 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 655 in LibRGW_WRITEF_DIRS1_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352176:    (RESOURCE_LEAK)
/test/librgw_file_nfsns.cc: 652 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
646     		    << std::endl;
647     	}
648     	char* leakbuf = (char*) malloc(bufsz);
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
>>>     CID 1352176:    (RESOURCE_LEAK)
>>>     Variable "leakbuf" going out of scope leaks the storage it points to.
652     	ASSERT_EQ(rc, 0);
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
647     	}
648     	char* leakbuf = (char*) malloc(bufsz);
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
652     	ASSERT_EQ(rc, 0);
>>>     CID 1352176:    (RESOURCE_LEAK)
>>>     Variable "leakbuf" going out of scope leaks the storage it points to.
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
658           rc = rgw_close(fs, fobj.fh, RGW_CLOSE_FLAG_NONE);
/test/librgw_file_nfsns.cc: 655 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
652     	ASSERT_EQ(rc, 0);
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
>>>     CID 1352176:    (RESOURCE_LEAK)
>>>     Variable "leakbuf" going out of scope leaks the storage it points to.
655           }
656     
657           /* commit write transaction */
658           rc = rgw_close(fs, fobj.fh, RGW_CLOSE_FLAG_NONE);
659           ASSERT_EQ(rc, 0);
660     

** CID 1352175:    (RESOURCE_LEAK)
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 659 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 652 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
/test/librgw_file_nfsns.cc: 636 in LibRGW_WRITEF_DIRS1_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352175:    (RESOURCE_LEAK)
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
647     	}
648     	char* leakbuf = (char*) malloc(bufsz);
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
652     	ASSERT_EQ(rc, 0);
>>>     CID 1352175:    (RESOURCE_LEAK)
>>>     Variable "buffer" going out of scope leaks the storage it points to.
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
658           rc = rgw_close(fs, fobj.fh, RGW_CLOSE_FLAG_NONE);
/test/librgw_file_nfsns.cc: 659 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
658           rc = rgw_close(fs, fobj.fh, RGW_CLOSE_FLAG_NONE);
>>>     CID 1352175:    (RESOURCE_LEAK)
>>>     Variable "buffer" going out of scope leaks the storage it points to.
659           ASSERT_EQ(rc, 0);
660     
661           ifs.close();
662           free(buffer);
663           rgw_fh_rele(fs, fobj.fh, 0 /* flags */);
664         }
/test/librgw_file_nfsns.cc: 652 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
646     		    << std::endl;
647     	}
648     	char* leakbuf = (char*) malloc(bufsz);
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
>>>     CID 1352175:    (RESOURCE_LEAK)
>>>     Variable "buffer" going out of scope leaks the storage it points to.
652     	ASSERT_EQ(rc, 0);
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
/test/librgw_file_nfsns.cc: 653 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
647     	}
648     	char* leakbuf = (char*) malloc(bufsz);
649     	memcpy(leakbuf, buffer, length);
650     	rc = rgw_write(fs, fobj.fh, offset, length, &nwritten, leakbuf,
651     		      RGW_WRITE_FLAG_NONE);
652     	ASSERT_EQ(rc, 0);
>>>     CID 1352175:    (RESOURCE_LEAK)
>>>     Variable "buffer" going out of scope leaks the storage it points to.
653     	ASSERT_EQ(nwritten, length);
654     	offset += length;
655           }
656     
657           /* commit write transaction */
658           rc = rgw_close(fs, fobj.fh, RGW_CLOSE_FLAG_NONE);
/test/librgw_file_nfsns.cc: 636 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
630           int bufsz = 1024 * 1024 * sizeof(char);
631           char *buffer = (char*) malloc(bufsz);
632     
633           uint64_t offset = 0;
634           uint64_t length = bufsz;
635           for (int ix = 0; ix < 6; ++ix) {
>>>     CID 1352175:    (RESOURCE_LEAK)
>>>     Variable "buffer" going out of scope leaks the storage it points to.
636     	ASSERT_TRUE(ifs.good());
637     	ifs.read(buffer, bufsz);
638     	uint64_t nwritten = 0;
639     	string str;
640     	str.assign(buffer, 4);
641     	if (verbose) {

** CID 1352174:    (RESOURCE_LEAK)
/test/librados/tier.cc: 3818 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3816 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3831 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3827 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3852 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3846 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3875 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3871 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3886 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
/test/librados/tier.cc: 3883 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352174:    (RESOURCE_LEAK)
/test/librados/tier.cc: 3818 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3812         std::map<std::string, bufferlist> omap;
3813         omap["somekey"] = bufferlist();
3814         op.omap_set(omap);
3815         librados::AioCompletion *completion = cluster.aio_create_completion();
3816         ASSERT_EQ(0, cache_ioctx.aio_operate("foo", completion, &op));
3817         completion->wait_for_safe();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3818         ASSERT_EQ(0, completion->get_return_value());
3819         completion->release();
3820       }
3821     
3822       // flush
3823       {
/test/librados/tier.cc: 3816 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3810       {
3811         ObjectWriteOperation op;
3812         std::map<std::string, bufferlist> omap;
3813         omap["somekey"] = bufferlist();
3814         op.omap_set(omap);
3815         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3816         ASSERT_EQ(0, cache_ioctx.aio_operate("foo", completion, &op));
3817         completion->wait_for_safe();
3818         ASSERT_EQ(0, completion->get_return_value());
3819         completion->release();
3820       }
3821     
/test/librados/tier.cc: 3831 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3825         op.cache_flush();
3826         librados::AioCompletion *completion = cluster.aio_create_completion();
3827         ASSERT_EQ(0, cache_ioctx.aio_operate(
3828           "foo", completion, &op,
3829           librados::OPERATION_IGNORE_OVERLAY, NULL));
3830         completion->wait_for_safe();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3831         ASSERT_NE(0, completion->get_return_value());
3832         completion->release();
3833       }
3834     
3835       // get omap
3836       {
/test/librados/tier.cc: 3827 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3821     
3822       // flush
3823       {
3824         ObjectReadOperation op;
3825         op.cache_flush();
3826         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3827         ASSERT_EQ(0, cache_ioctx.aio_operate(
3828           "foo", completion, &op,
3829           librados::OPERATION_IGNORE_OVERLAY, NULL));
3830         completion->wait_for_safe();
3831         ASSERT_NE(0, completion->get_return_value());
3832         completion->release();
/test/librados/tier.cc: 3852 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3846         ASSERT_EQ(0, cache_ioctx.aio_operate("foo", completion, &op, &bl));
3847         sleep(5);
3848         bool completed = completion->is_complete();
3849         if( !completed ) {
3850           cache_ioctx.aio_cancel(completion); 
3851           std::cerr << "Most probably test case will hang here, please reset manually" << std::endl;
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3852           ASSERT_TRUE(completed); //in fact we are locked forever at test case shutdown unless fix for http://tracker.ceph.com/issues/14511 is applied. Seems there is no workaround for that
3853         }
3854         completion->release();
3855       }
3856       // verify still not in base tier
3857       {
/test/librados/tier.cc: 3846 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3840         std::set<std::string> keys;
3841         keys.insert("somekey");
3842         std::map<std::string, bufferlist> map;
3843     
3844         op.omap_get_vals_by_keys(keys, &map, &prval);
3845         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3846         ASSERT_EQ(0, cache_ioctx.aio_operate("foo", completion, &op, &bl));
3847         sleep(5);
3848         bool completed = completion->is_complete();
3849         if( !completed ) {
3850           cache_ioctx.aio_cancel(completion); 
3851           std::cerr << "Most probably test case will hang here, please reset manually" << std::endl;
/test/librados/tier.cc: 3875 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3869         op.cache_flush();
3870         librados::AioCompletion *completion = cluster.aio_create_completion();
3871         ASSERT_EQ(0, cache_ioctx.aio_operate(
3872           "foo", completion, &op,
3873           librados::OPERATION_IGNORE_OVERLAY, NULL));
3874         completion->wait_for_safe();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3875         ASSERT_EQ(0, completion->get_return_value());
3876         completion->release();
3877       }
3878       // evict
3879       {
3880         ObjectReadOperation op;
/test/librados/tier.cc: 3871 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3865       }
3866       // flush whiteout
3867       {
3868         ObjectReadOperation op;
3869         op.cache_flush();
3870         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3871         ASSERT_EQ(0, cache_ioctx.aio_operate(
3872           "foo", completion, &op,
3873           librados::OPERATION_IGNORE_OVERLAY, NULL));
3874         completion->wait_for_safe();
3875         ASSERT_EQ(0, completion->get_return_value());
3876         completion->release();
/test/librados/tier.cc: 3886 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3880         ObjectReadOperation op;
3881         op.cache_evict();
3882         librados::AioCompletion *completion = cluster.aio_create_completion();
3883         ASSERT_EQ(0, cache_ioctx.aio_operate(
3884           "foo", completion, &op, librados::OPERATION_IGNORE_CACHE, NULL));
3885         completion->wait_for_safe();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3886         ASSERT_EQ(0, completion->get_return_value());
3887         completion->release();
3888       }
3889     
3890       // verify no longer in cache tier
3891       {
/test/librados/tier.cc: 3883 in LibRadosTwoPoolsECPP_FailedFlush_Test::TestBody()()
3877       }
3878       // evict
3879       {
3880         ObjectReadOperation op;
3881         op.cache_evict();
3882         librados::AioCompletion *completion = cluster.aio_create_completion();
>>>     CID 1352174:    (RESOURCE_LEAK)
>>>     Variable "completion" going out of scope leaks the storage it points to.
3883         ASSERT_EQ(0, cache_ioctx.aio_operate(
3884           "foo", completion, &op, librados::OPERATION_IGNORE_CACHE, NULL));
3885         completion->wait_for_safe();
3886         ASSERT_EQ(0, completion->get_return_value());
3887         completion->release();
3888       }

** CID 1352173:  Null pointer dereferences  (FORWARD_NULL)
/rgw/librgw.cc: 580 in librgw_create()


________________________________________________________________________________________________________
*** CID 1352173:  Null pointer dereferences  (FORWARD_NULL)
/rgw/librgw.cc: 580 in librgw_create()
574       using namespace rgw;
575     
576       int rc = -EINVAL;
577     
578       if (! g_ceph_context) {
579         std::lock_guard<std::mutex> lg(librgw_mtx);
>>>     CID 1352173:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "g_ceph_context" to null implies that "g_ceph_context" might be null.
580         if (! g_ceph_context) {
581           vector<const char*> args;
582           argv_to_vec(argc, const_cast<const char**>(argv), args);
583           rc = rgwlib.init(args);
584         }
585       }

** CID 1352172:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 614 in LibRGW_WRITEF_DIRS1_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352172:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 614 in LibRGW_WRITEF_DIRS1_Test::TestBody()()
608           ASSERT_TRUE(ifs.is_open());
609     
610           obj_rec fobj{writef_name, nullptr, dirs1_b.fh, nullptr};
611     
612           (void) rgw_lookup(fs, fobj.parent_fh, fobj.name.c_str(), &fobj.fh,
613     			RGW_LOOKUP_FLAG_NONE);
>>>     CID 1352172:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "fobj.fh" to null implies that "fobj.fh" might be null.
614           if (! fobj.fh) {
615     	if (do_create) {
616     	  /* make a new file object (the hard way) */
617     	  rc = rgw_lookup(fs, fobj.parent_fh, fobj.name.c_str(), &fobj.fh,
618     			  RGW_LOOKUP_FLAG_CREATE);
619     	  ASSERT_EQ(rc, 0);

** CID 1352171:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 285 in LibRGW_SETUP_DIRS1_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352171:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 285 in LibRGW_SETUP_DIRS1_Test::TestBody()()
279     
280           int f_ix;
281           for (f_ix = 0; f_ix < n_dirs1_objs; ++f_ix) {
282     	/* child dir */
283     	std::string sdname{"sdir_"};
284     	sdname += to_string(f_ix);
>>>     CID 1352171:  Null pointer dereferences  (FORWARD_NULL)
>>>     Although "obj_rec" does overwrite "sdir.parent_fh" on some paths, it also contains at least one feasible path which does not overwrite it.
285     	obj_rec sdir{sdname, nullptr, dir.fh, nullptr};
286     
287     	(void) rgw_lookup(fs, sdir.parent_fh, sdir.name.c_str(), &sdir.fh,
288     			  RGW_LOOKUP_FLAG_NONE);
289     
290     	if (! sdir.fh) {

** CID 1352170:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 262 in LibRGW_SETUP_DIRS1_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1352170:  Null pointer dereferences  (FORWARD_NULL)
/test/librgw_file_nfsns.cc: 262 in LibRGW_SETUP_DIRS1_Test::TestBody()()
256         /* make top-level dirs */
257         int d_ix;
258         obj_vec ovec;
259         for (d_ix = 0; d_ix < n_dirs1_dirs; ++d_ix) {
260           std::string dname{"dir_"};
261           dname += to_string(d_ix);
>>>     CID 1352170:  Null pointer dereferences  (FORWARD_NULL)
>>>     Although "obj_rec" does overwrite "dir.parent_fh" on some paths, it also contains at least one feasible path which does not overwrite it.
262           obj_rec dir{dname, nullptr, dirs1_b.fh, nullptr};
263           ovec.clear();
264     
265           (void) rgw_lookup(fs, dir.parent_fh, dir.name.c_str(), &dir.fh,
266     			RGW_LOOKUP_FLAG_NONE);
267           if (! dir.fh) {

** CID 1352169:  Control flow issues  (DEADCODE)
/rgw/librgw.cc: 280 in rgw::RGWLibProcess::process_request(rgw::RGWLibRequest *, rgw::RGWLibIO *)()


________________________________________________________________________________________________________
*** CID 1352169:  Control flow issues  (DEADCODE)
/rgw/librgw.cc: 280 in rgw::RGWLibProcess::process_request(rgw::RGWLibRequest *, rgw::RGWLibIO *)()
274       done:
275         int r = io->complete_request();
276         if (r < 0) {
277           dout(0) << "ERROR: io->complete_request() returned " << r << dendl;
278         }
279         if (should_log) {
>>>     CID 1352169:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "<temporary>.basic_string("u...".
280           rgw_log_op(store, s, (op ? op->name() : "unknown"), olog);
281         }
282     
283         int http_ret = s->err.http_ret;
284     
285         req->log_format(s, "http status=%d", http_ret);

** CID 1313420:    (UNCAUGHT_EXCEPT)
/test/librbd/fsx.cc: 2441 in main()
/test/librbd/fsx.cc: 2441 in main()
/test/librbd/fsx.cc: 2441 in main()
/test/librbd/fsx.cc: 2441 in main()
/test/librbd/fsx.cc: 2441 in main()


________________________________________________________________________________________________________
*** CID 1313420:    (UNCAUGHT_EXCEPT)
/test/librbd/fsx.cc: 2441 in main()
2435     		prterrcode(errmsg, ret);
2436     		report_failure(106);
2437     	}
2438     }
2439     
2440     int
>>>     CID 1313420:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2441     main(int argc, char **argv)
2442     {
2443     	int	i, style, ch, ret;
2444     	char	*endp;
2445     	char goodfile[1024];
2446     	char logfile[1024];
/test/librbd/fsx.cc: 2441 in main()
2435     		prterrcode(errmsg, ret);
2436     		report_failure(106);
2437     	}
2438     }
2439     
2440     int
>>>     CID 1313420:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2441     main(int argc, char **argv)
2442     {
2443     	int	i, style, ch, ret;
2444     	char	*endp;
2445     	char goodfile[1024];
2446     	char logfile[1024];
/test/librbd/fsx.cc: 2441 in main()
2435     		prterrcode(errmsg, ret);
2436     		report_failure(106);
2437     	}
2438     }
2439     
2440     int
>>>     CID 1313420:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2441     main(int argc, char **argv)
2442     {
2443     	int	i, style, ch, ret;
2444     	char	*endp;
2445     	char goodfile[1024];
2446     	char logfile[1024];
/test/librbd/fsx.cc: 2441 in main()
2435     		prterrcode(errmsg, ret);
2436     		report_failure(106);
2437     	}
2438     }
2439     
2440     int
>>>     CID 1313420:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2441     main(int argc, char **argv)
2442     {
2443     	int	i, style, ch, ret;
2444     	char	*endp;
2445     	char goodfile[1024];
2446     	char logfile[1024];
/test/librbd/fsx.cc: 2441 in main()
2435     		prterrcode(errmsg, ret);
2436     		report_failure(106);
2437     	}
2438     }
2439     
2440     int
>>>     CID 1313420:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2441     main(int argc, char **argv)
2442     {
2443     	int	i, style, ch, ret;
2444     	char	*endp;
2445     	char goodfile[1024];
2446     	char logfile[1024];

** CID 717368:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_op.h: 330 in RGWListBuckets::RGWListBuckets()()


________________________________________________________________________________________________________
*** CID 717368:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_op.h: 330 in RGWListBuckets::RGWListBuckets()()
324       RGWListBuckets() : sent_data(false) {
325         limit = limit_max = RGW_LIST_BUCKETS_LIMIT_MAX;
326         buckets_count = 0;
327         buckets_objcount = 0;
328         buckets_size = 0;
329         buckets_size_rounded = 0;
>>>     CID 717368:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "is_truncated" is not initialized in this constructor nor in any functions that it calls.
330       }
331     
332       int verify_permission();
333       void execute();
334     
335       virtual int get_params() = 0;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

