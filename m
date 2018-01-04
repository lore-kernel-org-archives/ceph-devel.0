From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 04 Jan 2018 03:32:38 +0000 (UTC)
Message-ID: <5a4da055e59c7_1d6c973330566f0@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:17090 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751798AbeADDcj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jan 2018 22:32:39 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0022p1las1.sendgrid.net (SG) with ESMTP id tnP6YZaXQv2yIVauiQS58Q
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 03:32:38.148 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.
6 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1427159:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/include/scope_guard.h: 34 in scope_guard<ceph::DNSResolver::resolve_ip_addr(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, entity_addr_t *)::[lambda() (instance 1)]>::~scope_guard()()


________________________________________________________________________________________________________
*** CID 1427159:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/include/scope_guard.h: 34 in scope_guard<ceph::DNSResolver::resolve_ip_addr(CephContext *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, entity_addr_t *)::[lambda() (instance 1)]>::~scope_guard()()
28       scope_guard & operator=(const scope_guard &) = delete;
29       scope_guard & operator=(scope_guard &&) = default;
30       scope_guard(const F& f) : f(f) {}
31       scope_guard(F &&f) : f(std::move(f)) {}
32       template<typename... Args>
33       scope_guard(ceph::in_place_t, Args&& ...args) : f(std::forward<Args>(args)...) {}
>>>     CID 1427159:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     An exception of type "_ZN5boost16exception_detail10clone_implINS0_19error_info_injectorINSt8ios_base7failureB5cxx11EEEEE" is thrown but the throw list "throw()" doesn't allow it to be thrown. This will cause a call to unexpected() which usually calls terminate().
34       ~scope_guard() {
35         std::move(f)(); // Support at-most-once functions
36       }
37     };
38     
39     template <typename F>

** CID 1427160:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_cache.h: 160 in ObjectCache::ObjectCache()()


________________________________________________________________________________________________________
*** CID 1427160:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_cache.h: 160 in ObjectCache::ObjectCache()()
154     		 std::deque<string>::iterator& lru_iter);
155       void remove_lru(string& name, std::deque<string>::iterator& lru_iter);
156       void invalidate_lru(ObjectCacheEntry& entry);
157     
158       void do_invalidate_all();
159     public:
>>>     CID 1427160:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "expiry.__r" is not initialized in this constructor nor in any functions that it calls.
160       ObjectCache() : lru_size(0), lru_counter(0), lru_window(0), lock("ObjectCache"), cct(NULL), enabled(false) { }
161       int get(std::string& name, ObjectCacheInfo& bl, uint32_t mask, rgw_cache_entry_info *cache_info);
162       void put(std::string& name, ObjectCacheInfo& bl, rgw_cache_entry_info *cache_info);
163       void remove(std::string& name);
164       void set_ctx(CephContext *_cct) {
165         cct = _cct;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GeY66q3Z-2BiIfD-2FWF-2B1y4fthe2aV5C5glhCTArXxMAf4Yx53JgeiJO-2FnVss9zfoZ-2BIQ7dB9PSt-2BmwWtXS2Ih-2BgFocKqcKMWIT5CiTIsr6eYmz47feaFMS8SlJcHvHdgYSpqHvXdFnWtlcAZsHx7GuEwS5tAnMYMir4ko3VJgN5Zfxh8pbygH3KsgfxpmemwxlU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8GeY66q3Z-2BiIfD-2FWF-2B1y4fthe2aV5C5glhCTArXxMAf4TOy6PDjWkrr6uxqj7nh7NWntyEvTs5ozVAjOyJp1cMBsHFm8zb-2BrkBtTgdyI1-2Br14TxtepwH0-2BUS53f1jEHMzCsGtYVRH2TyO6aZ1GDB-2BWs-2F6eDL64i0Wpg-2FvILa5PPq4ynlilnhHcRdK3mTSrWKCU-3D

