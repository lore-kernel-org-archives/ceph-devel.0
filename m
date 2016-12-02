From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 02 Dec 2016 03:08:13 -0800
Message-ID: <5841561d320dd_43577b531818a@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:50569 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751731AbcLBLIP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 06:08:15 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id S9v-5rfnRIWog5D88_nxxA
        for <ceph-devel@vger.kernel.org>; Fri, 02 Dec 2016 11:08:13.244 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

22 new defect(s) introduced to ceph found with Coverity Scan.
35 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 22 defect(s)


** CID 1396677:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librados/misc.cc: 96 in LibRadosMiscPool_PoolCreationRace_Test::TestBody()()
/home/brad/working/src/ceph/src/test/librados/misc.cc: 105 in LibRadosMiscPool_PoolCreationRace_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1396677:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librados/misc.cc: 96 in LibRadosMiscPool_PoolCreationRace_Test::TestBody()()
90       ASSERT_EQ(0, rados_conf_parse_env(cluster_b, NULL));
91       ASSERT_EQ(0, rados_conf_set(cluster_b,
92     			      "objecter_debug_inject_relock_delay", "true"));
93       ASSERT_EQ(0, rados_connect(cluster_b));
94     
95       char poolname[80];
>>>     CID 1396677:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
96       snprintf(poolname, sizeof(poolname), "poolrace.%d", rand());
97       rados_pool_create(cluster_a, poolname);
98       rados_ioctx_t a, b;
99       rados_ioctx_create(cluster_a, poolname, &a);
100       int64_t poolid = rados_ioctx_get_id(a);
101     
/home/brad/working/src/ceph/src/test/librados/misc.cc: 105 in LibRadosMiscPool_PoolCreationRace_Test::TestBody()()
99       rados_ioctx_create(cluster_a, poolname, &a);
100       int64_t poolid = rados_ioctx_get_id(a);
101     
102       rados_ioctx_create2(cluster_b, poolid+1, &b);
103     
104       char pool2name[80];
>>>     CID 1396677:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
105       snprintf(pool2name, sizeof(pool2name), "poolrace2.%d", rand());
106       rados_pool_create(cluster_a, pool2name);
107     
108       list<rados_completion_t> cls;
109       while (true) {
110         rados_completion_t c;

** CID 1396678:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal7TagDataEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396678:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal7TagDataEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396678:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396679:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI12cls_rbd_snapE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396679:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI12cls_rbd_snapE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396679:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396680:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI14cls_rbd_parentE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396680:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseI14cls_rbd_parentE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396680:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396681:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN10rbd_replay6action10DependencyEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396681:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN10rbd_replay6action10DependencyEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396681:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396682:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd12watch_notify15ResponseMessageEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396682:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd12watch_notify15ResponseMessageEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396682:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396683:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN10rbd_replay6action11ActionEntryEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396683:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN10rbd_replay6action11ActionEntryEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396683:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396684:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd17mirroring_watcher13NotifyMessageEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396684:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd17mirroring_watcher13NotifyMessageEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396684:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396685:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN3cls3rbd11MirrorImageEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396685:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN3cls3rbd11MirrorImageEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396685:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396686:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal10ClientDataEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396686:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal10ClientDataEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396686:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396687:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN3cls3rbd10MirrorPeerEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396687:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN3cls3rbd10MirrorPeerEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396687:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396688:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal10EventEntryEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396688:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd7journal10EventEntryEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396688:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396689:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd12watch_notify13NotifyMessageEE16select_generatedB5cxx11Ej()


________________________________________________________________________________________________________
*** CID 1396689:  API usage errors  (INVALIDATE_ITERATOR)
/home/brad/working/src/ceph/src/test/encoding/ceph_dencoder.cc: 147 in _ZN12DencoderBaseIN6librbd12watch_notify13NotifyMessageEE16select_generatedB5cxx11Ej()
141         if (i == 0)
142           i = m_list.size();
143         if ((i == 0) || (i > m_list.size()))
144           return "invalid id for generated object";
145         typename list<T*>::iterator p = m_list.begin();
146         for (i--; i > 0 && p != m_list.end(); ++p, --i) ;
>>>     CID 1396689:  API usage errors  (INVALIDATE_ITERATOR)
>>>     Dereferencing iterator "p" though it is already past the end of its container.
147         m_object = *p;
148         return string();
149       }
150     
151       bool is_deterministic() {
152         return !nondeterministic;

** CID 1396690:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1396690:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/crush/CrushWrapper.cc: 1201 in CrushWrapper::encode(ceph::buffer::list &, unsigned long) const()
1195         __u32 yes = crush->rules[i] ? 1:0;
1196         ::encode(yes, bl);
1197         if (!yes)
1198           continue;
1199     
1200         ::encode(crush->rules[i]->len, bl);
>>>     CID 1396690:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type crush_rule_mask of 4 bytes by passing it to a function which accesses it at byte offset 7.
1201         ::encode(crush->rules[i]->mask, bl);
1202         for (unsigned j=0; j<crush->rules[i]->len; j++)
1203           ::encode(crush->rules[i]->steps[j], bl);
1204       }
1205     
1206       // name info

** CID 1396691:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_cr_rados.h: 498 in _ZN20RGWSimpleRadosLockCR17gen_random_cookieB5cxx11EP11CephContext()


________________________________________________________________________________________________________
*** CID 1396691:  Memory - illegal accesses  (STRING_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_cr_rados.h: 498 in _ZN20RGWSimpleRadosLockCR17gen_random_cookieB5cxx11EP11CephContext()
492       int request_complete();
493     
494       static std::string gen_random_cookie(CephContext* cct) {
495     #define COOKIE_LEN 16
496         char buf[COOKIE_LEN + 1];
497         gen_rand_alphanumeric(cct, buf, sizeof(buf) - 1);
>>>     CID 1396691:  Memory - illegal accesses  (STRING_NULL)
>>>     Passing unterminated string "buf" to "basic_string", which expects a null-terminated string. [Note: The source code implementation of the function has been overridden by a builtin model.]
498         return buf;
499       }
500     };
501     
502     class RGWSimpleRadosUnlockCR : public RGWSimpleCoroutine {
503       RGWAsyncRadosProcessor *async_rados;

** CID 1396692:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()


________________________________________________________________________________________________________
*** CID 1396692:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396692:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396692:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396692:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396692:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396692:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1396693:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()


________________________________________________________________________________________________________
*** CID 1396693:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396693:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1396694:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()


________________________________________________________________________________________________________
*** CID 1396694:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396694:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1396695:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()


________________________________________________________________________________________________________
*** CID 1396695:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/unit.cc: 36 in main()
30     
31     /*
32      * You only need to include this file if you are testing Ceph internal code. If
33      * you are testing library code, the library init() interfaces will handle
34      * initialization for you.
35      */
>>>     CID 1396695:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
36     int main(int argc, char **argv) {
37       std::vector<const char*> args(argv, argv + argc);
38       env_to_vec(args);
39       auto cct = global_init(NULL, args,
40     			 CEPH_ENTITY_TYPE_CLIENT,
41     			 CODE_ENVIRONMENT_UTILITY, 0);

** CID 1396696:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/main.cc: 38 in main()


________________________________________________________________________________________________________
*** CID 1396696:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/libcephfs/main.cc: 38 in main()
32     out:
33       ceph_shutdown(admin);
34       return r;
35     }
36     
37     
>>>     CID 1396696:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
38     int main(int argc, char **argv)
39     {
40       int r = update_root_mode();
41       if (r < 0)
42         exit(1);
43     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E6gieVoPvzNTvjh-2FkR30jCCDmK2fypQAwErAoYacO-2FBVD6rT5XMXrGEb0rfpo4nd6WHJxjU82JTIwEJ-2FEjmgu8NmgBf-2Brcd7CiuW6mRjlPrO0p75JTlyD7MFHl-2BxJcfF-2BeK1wwqowjdsA7sHqA5TZifylnc9I-2FgY-2FMsAVr1-2FrlkmuK1CAMP83dKTD42Z5ovDI-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E6gieVoPvzNTvjh-2FkR30jCCDmK2fypQAwErAoYacO-2FBXNRpQMNprAz14DgxpnUyCl6-2BsH-2BrDlAN2HzaPAWcD8eE1hO8cLFWsRCEhaKIZTy1s8KmFRfBvnxQ4Kkd-2FMXcfZo207l9JNnBgSYDCaO5EgCmelaIzLpPm94JS7mm-2FSnOTBqXmMqsAYasLdYEHHGsVI-3D

