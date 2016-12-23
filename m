From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 23 Dec 2016 01:16:59 -0800
Message-ID: <585ceb8b7224b_6d63de3334795d5@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv1e.shared.sendgrid.net ([167.89.100.174]:42567 "EHLO
        o2.lv1e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750781AbcLWJWl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 04:22:41 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id vZTmnI3OSGSWtJ5F6ECQ8Q
        for <ceph-devel@vger.kernel.org>; Fri, 23 Dec 2016 09:16:59.523 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

8 new defect(s) introduced to ceph found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 8 of 8 defect(s)


** CID 1397726:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/test/objectstore/BitAllocator_test.cc: 323 in BitAllocator_test_zone_alloc_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1397726:  Integer handling issues  (BAD_SHIFT)
/home/brad/working/src/ceph/src/test/objectstore/BitAllocator_test.cc: 323 in BitAllocator_test_zone_alloc_Test::TestBody()()
317       {
318         int64_t blk_size = 1;
319         AllocExtentVector extents = AllocExtentVector
320           (zone->size() / 2, AllocExtent(-1, -1));
321     
322         for (int i = 1; i <= total_blocks - BmapEntry::size(); i = i << 1) {
>>>     CID 1397726:  Integer handling issues  (BAD_SHIFT)
>>>     In expression "1 << j", left shifting by more than 31 bits has undefined behavior.  The shift amount, "j", is as much as 64.
323           for (int64_t j = 0; j <= BmapEntry::size(); j = 1 << j) {
324             ExtentList *block_list = new ExtentList(&extents, blk_size);
325             zone = new BitMapZone(total_blocks, 0);
326             lock = zone->lock_excl_try();
327             bmap_test_assert(lock);
328     

** CID 1397727:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 163 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()


________________________________________________________________________________________________________
*** CID 1397727:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 163 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()
157       if (skew)
158         skew = alloc_unit - skew;
159       *offset = p.get_start() + skew;
160       *length = MIN(MAX(alloc_unit, want_size), p.get_len() - skew);
161       if (g_conf->bluestore_debug_small_allocations) {
162         uint64_t max =
>>>     CID 1397727:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
163           alloc_unit * (rand() % g_conf->bluestore_debug_small_allocations);
164         if (max && *length > max) {
165           dout(10) << __func__ << " shortening allocation of 0x" << std::hex
166     	       << *length << " -> 0x"
167     	       << max << " due to debug_small_allocations" << std::dec << dendl;
168           *length = max;

** CID 1397728:    (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 156 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 156 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()


________________________________________________________________________________________________________
*** CID 1397728:    (DIVIDE_BY_ZERO)
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 156 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()
150         }
151       }
152     
153       return -ENOSPC;
154     
155      found:
>>>     CID 1397728:    (DIVIDE_BY_ZERO)
>>>     In expression "p.get_start() % alloc_unit", modulo by expression "alloc_unit" which may be zero has undefined behavior.
156       uint64_t skew = p.get_start() % alloc_unit;
157       if (skew)
158         skew = alloc_unit - skew;
159       *offset = p.get_start() + skew;
160       *length = MIN(MAX(alloc_unit, want_size), p.get_len() - skew);
161       if (g_conf->bluestore_debug_small_allocations) {
/home/brad/working/src/ceph/src/os/bluestore/StupidAllocator.cc: 156 in StupidAllocator::allocate_int(unsigned long, unsigned long, long, unsigned long *, unsigned int *)()
150         }
151       }
152     
153       return -ENOSPC;
154     
155      found:
>>>     CID 1397728:    (DIVIDE_BY_ZERO)
>>>     In expression "p.get_start() % alloc_unit", modulo by expression "alloc_unit" which may be zero has undefined behavior.
156       uint64_t skew = p.get_start() % alloc_unit;
157       if (skew)
158         skew = alloc_unit - skew;
159       *offset = p.get_start() + skew;
160       *length = MIN(MAX(alloc_unit, want_size), p.get_len() - skew);
161       if (g_conf->bluestore_debug_small_allocations) {

** CID 1397729:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_rest_s3.cc: 3653 in RGW_Auth_S3::authorize_v4(RGWRados *, req_state *, bool)()


________________________________________________________________________________________________________
*** CID 1397729:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_rest_s3.cc: 3653 in RGW_Auth_S3::authorize_v4(RGWRados *, req_state *, bool)()
3647         const char *d = s->info.env->get("HTTP_X_AMZ_DATE");
3648         struct tm t;
3649         if (!parse_iso8601(d, &t, NULL, false)) {
3650           dout(10) << "error reading date via http_x_amz_date" << dendl;
3651           return -EACCES;
3652         }
>>>     CID 1397729:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "d" to "operator =", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
3653         s->aws4_auth->date = d;
3654       }
3655     
3656       /* AKIAIVKTAZLOCF43WNQD/AAAAMMDD/region/host/aws4_request */
3657       dout(10) << "v4 credential format = " << s->aws4_auth->credential << dendl;
3658     

** CID 1397730:  Program hangs  (ORDER_REVERSAL)


________________________________________________________________________________________________________
*** CID 1397730:  Program hangs  (ORDER_REVERSAL)
/home/brad/working/src/ceph/src/common/ceph_context.h: 134 in CephContext::lookup_or_create_singleton_object<<unnamed>::MempoolObs>(T1 *&, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &)()
128     		  bufferlist *out);
129     
130       template<typename T>
131       void lookup_or_create_singleton_object(T*& p, const std::string &name) {
132         ceph_spin_lock(&_associated_objs_lock);
133         if (!_associated_objs.count(name)) {
>>>     CID 1397730:  Program hangs  (ORDER_REVERSAL)
>>>     Calling "MempoolObs" acquires lock "Mutex._m" while holding lock "ceph_spinlock_t.lock" (count: 1 / 20).
134           p = new T(this);
135           _associated_objs[name] = new TypedSingletonWrapper<T>(p);
136         } else {
137           TypedSingletonWrapper<T> *wrapper =
138             dynamic_cast<TypedSingletonWrapper<T> *>(_associated_objs[name]);
139           assert(wrapper != NULL);

** CID 1397731:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/objectstore/BitAllocator_test.cc: 323 in BitAllocator_test_zone_alloc_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1397731:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/objectstore/BitAllocator_test.cc: 323 in BitAllocator_test_zone_alloc_Test::TestBody()()
317       {
318         int64_t blk_size = 1;
319         AllocExtentVector extents = AllocExtentVector
320           (zone->size() / 2, AllocExtent(-1, -1));
321     
322         for (int i = 1; i <= total_blocks - BmapEntry::size(); i = i << 1) {
>>>     CID 1397731:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << j" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "int64_t" (64 bits, signed).
323           for (int64_t j = 0; j <= BmapEntry::size(); j = 1 << j) {
324             ExtentList *block_list = new ExtentList(&extents, blk_size);
325             zone = new BitMapZone(total_blocks, 0);
326             lock = zone->lock_excl_try();
327             bmap_test_assert(lock);
328     

** CID 1397732:    (PARSE_ERROR)
/home/brad/working/src/ceph/src/common/config_opts.h: 195 in ()
/home/brad/working/src/ceph/src/common/config_opts.h: 196 in ()
/home/brad/working/src/ceph/src/common/config_opts.h: 197 in ()
/home/brad/working/src/ceph/src/common/config_opts.h: 198 in ()
/home/brad/working/src/ceph/src/common/config_opts.h: 199 in ()


________________________________________________________________________________________________________
*** CID 1397732:    (PARSE_ERROR)
/home/brad/working/src/ceph/src/common/config_opts.h: 195 in ()
189     OPTION(ms_die_on_skipped_message, OPT_BOOL, false)  // assert if we skip a seq (kernel client does this intentionally)
190     OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)
191     OPTION(ms_bind_ipv6, OPT_BOOL, false)
192     OPTION(ms_bind_port_min, OPT_INT, 6800)
193     OPTION(ms_bind_port_max, OPT_INT, 7300)
194     OPTION(ms_bind_retry_count, OPT_INT, 3) // If binding fails, how many times do we retry to bind
>>>     CID 1397732:    (PARSE_ERROR)
>>>     detected during instantiation of "std::enable_if<std::is_destructible<T>::value, md_config_t::validator_t>::type <unnamed>::create_validator<T>() [with T=md_config_t::option_ms_bind_retry_delay_t]" at line 195 of "/home/brad/working/src/ceph/src/common/config_opts.h"
195     OPTION(ms_bind_retry_delay, OPT_INT, 5) // Delay between attemps to bind
196     OPTION(ms_rwthread_stack_bytes, OPT_U64, 1024 << 10)
197     OPTION(ms_tcp_read_timeout, OPT_U64, 900)
198     OPTION(ms_pq_max_tokens_per_priority, OPT_U64, 16777216)
199     OPTION(ms_pq_min_cost, OPT_U64, 65536)
200     OPTION(ms_inject_socket_failures, OPT_U64, 0)
/home/brad/working/src/ceph/src/common/config_opts.h: 196 in ()
190     OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)
191     OPTION(ms_bind_ipv6, OPT_BOOL, false)
192     OPTION(ms_bind_port_min, OPT_INT, 6800)
193     OPTION(ms_bind_port_max, OPT_INT, 7300)
194     OPTION(ms_bind_retry_count, OPT_INT, 3) // If binding fails, how many times do we retry to bind
195     OPTION(ms_bind_retry_delay, OPT_INT, 5) // Delay between attemps to bind
>>>     CID 1397732:    (PARSE_ERROR)
>>>     detected during instantiation of "std::enable_if<std::is_destructible<T>::value, md_config_t::validator_t>::type <unnamed>::create_validator<T>() [with T=md_config_t::option_ms_rwthread_stack_bytes_t]" at line 196 of "/home/brad/working/src/ceph/src/common/config_opts.h"
196     OPTION(ms_rwthread_stack_bytes, OPT_U64, 1024 << 10)
197     OPTION(ms_tcp_read_timeout, OPT_U64, 900)
198     OPTION(ms_pq_max_tokens_per_priority, OPT_U64, 16777216)
199     OPTION(ms_pq_min_cost, OPT_U64, 65536)
200     OPTION(ms_inject_socket_failures, OPT_U64, 0)
201     OPTION(ms_inject_delay_type, OPT_STR, "")          // "osd mds mon client" allowed
/home/brad/working/src/ceph/src/common/config_opts.h: 197 in ()
191     OPTION(ms_bind_ipv6, OPT_BOOL, false)
192     OPTION(ms_bind_port_min, OPT_INT, 6800)
193     OPTION(ms_bind_port_max, OPT_INT, 7300)
194     OPTION(ms_bind_retry_count, OPT_INT, 3) // If binding fails, how many times do we retry to bind
195     OPTION(ms_bind_retry_delay, OPT_INT, 5) // Delay between attemps to bind
196     OPTION(ms_rwthread_stack_bytes, OPT_U64, 1024 << 10)
>>>     CID 1397732:    (PARSE_ERROR)
>>>     detected during instantiation of "std::enable_if<std::is_destructible<T>::value, md_config_t::validator_t>::type <unnamed>::create_validator<T>() [with T=md_config_t::option_ms_tcp_read_timeout_t]" at line 197 of "/home/brad/working/src/ceph/src/common/config_opts.h"
197     OPTION(ms_tcp_read_timeout, OPT_U64, 900)
198     OPTION(ms_pq_max_tokens_per_priority, OPT_U64, 16777216)
199     OPTION(ms_pq_min_cost, OPT_U64, 65536)
200     OPTION(ms_inject_socket_failures, OPT_U64, 0)
201     OPTION(ms_inject_delay_type, OPT_STR, "")          // "osd mds mon client" allowed
202     OPTION(ms_inject_delay_msg_type, OPT_STR, "")      // the type of message to delay, as returned by Message::get_type_name(). This is an additional restriction on the general type filter ms_inject_delay_type.
/home/brad/working/src/ceph/src/common/config_opts.h: 198 in ()
192     OPTION(ms_bind_port_min, OPT_INT, 6800)
193     OPTION(ms_bind_port_max, OPT_INT, 7300)
194     OPTION(ms_bind_retry_count, OPT_INT, 3) // If binding fails, how many times do we retry to bind
195     OPTION(ms_bind_retry_delay, OPT_INT, 5) // Delay between attemps to bind
196     OPTION(ms_rwthread_stack_bytes, OPT_U64, 1024 << 10)
197     OPTION(ms_tcp_read_timeout, OPT_U64, 900)
>>>     CID 1397732:    (PARSE_ERROR)
>>>     detected during instantiation of "std::enable_if<std::is_destructible<T>::value, md_config_t::validator_t>::type <unnamed>::create_validator<T>() [with T=md_config_t::option_ms_pq_max_tokens_per_priority_t]" at line 198 of "/home/brad/working/src/ceph/src/common/config_opts.h"
198     OPTION(ms_pq_max_tokens_per_priority, OPT_U64, 16777216)
199     OPTION(ms_pq_min_cost, OPT_U64, 65536)
200     OPTION(ms_inject_socket_failures, OPT_U64, 0)
201     OPTION(ms_inject_delay_type, OPT_STR, "")          // "osd mds mon client" allowed
202     OPTION(ms_inject_delay_msg_type, OPT_STR, "")      // the type of message to delay, as returned by Message::get_type_name(). This is an additional restriction on the general type filter ms_inject_delay_type.
203     OPTION(ms_inject_delay_max, OPT_DOUBLE, 1)         // seconds
/home/brad/working/src/ceph/src/common/config_opts.h: 199 in ()
193     OPTION(ms_bind_port_max, OPT_INT, 7300)
194     OPTION(ms_bind_retry_count, OPT_INT, 3) // If binding fails, how many times do we retry to bind
195     OPTION(ms_bind_retry_delay, OPT_INT, 5) // Delay between attemps to bind
196     OPTION(ms_rwthread_stack_bytes, OPT_U64, 1024 << 10)
197     OPTION(ms_tcp_read_timeout, OPT_U64, 900)
198     OPTION(ms_pq_max_tokens_per_priority, OPT_U64, 16777216)
>>>     CID 1397732:    (PARSE_ERROR)
>>>     detected during instantiation of "std::enable_if<std::is_destructible<T>::value, md_config_t::validator_t>::type <unnamed>::create_validator<T>() [with T=md_config_t::option_ms_pq_min_cost_t]" at line 199 of "/home/brad/working/src/ceph/src/common/config_opts.h"
199     OPTION(ms_pq_min_cost, OPT_U64, 65536)
200     OPTION(ms_inject_socket_failures, OPT_U64, 0)
201     OPTION(ms_inject_delay_type, OPT_STR, "")          // "osd mds mon client" allowed
202     OPTION(ms_inject_delay_msg_type, OPT_STR, "")      // the type of message to delay, as returned by Message::get_type_name(). This is an additional restriction on the general type filter ms_inject_delay_type.
203     OPTION(ms_inject_delay_max, OPT_DOUBLE, 1)         // seconds
204     OPTION(ms_inject_delay_probability, OPT_DOUBLE, 0) // range [0, 1]

** CID 1397733:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/TracepointProvider.cc: 43 in TracepointProvider::verify_config(const md_config_t *)()


________________________________________________________________________________________________________
*** CID 1397733:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/common/TracepointProvider.cc: 43 in TracepointProvider::verify_config(const md_config_t *)()
37       }
38     
39       void *handle = dlopen(m_library.c_str(), RTLD_NOW);
40       if (handle != NULL) {
41         m_enabled = true;
42       }
>>>     CID 1397733:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "handle" going out of scope leaks the storage it points to.


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HpCKeLP9IQPF5VGstDbQFyNFVW-2FjZ9agwE3-2B7uh79rStpGx854Z3iAf7QRK5e-2FocrxwNdXtnUWRkYJNg8OImTtizI2M3y6VZUHc6GnLOpBiQf1LS2fea-2BgHRrMhamqn2eXfC2GGxLY0ZWRR9su4GhfjiCnYNE8YUO3UrIwihUIcMxmN7sI22YVzg-2FevKXhbcU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HpCKeLP9IQPF5VGstDbQFyNFVW-2FjZ9agwE3-2B7uh79rStChJCKES3IofNj8jInXP3Zelvy-2F1Eh72Yfb4C3TPn0SIzaI8C4-2Bw4oNBXW4HNsuOOkrS0oVnKHwdDmiD5iBn4YEYWvWbuSFx4XzsAhAB1p-2BEIF8Dk1MBrFCnpbcVlX9EjRN6ydpQrPxkCxYX-2BSYId0-3D

