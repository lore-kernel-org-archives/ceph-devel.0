From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 10 May 2017 22:32:57 -0700
Message-ID: <5913f78922521_7e5772f3305176f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:64413 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754670AbdEKFc6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 May 2017 01:32:58 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0002p1sjc2.sendgrid.net (SG) with ESMTP id tPJNz_5QSLSue9PNdTmahg
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 05:32:57.180 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

5 new defect(s) introduced to ceph found with Coverity Scan.
6 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 5 of 5 defect(s)


** CID 1406085:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 537 in KernelDevice::_sync_write(unsigned long, ceph::buffer::list &, bool)()


________________________________________________________________________________________________________
*** CID 1406085:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/os/bluestore/KernelDevice.cc: 537 in KernelDevice::_sync_write(unsigned long, ceph::buffer::list &, bool)()
531     int KernelDevice::_sync_write(uint64_t off, bufferlist &bl, bool buffered)
532     {
533       uint64_t len = bl.length();
534       dout(5) << __func__ << " 0x" << std::hex << off << "~" << len
535     	  << std::dec << " buffered" << dendl;
536       if (cct->_conf->bdev_inject_crash &&
>>>     CID 1406085:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
537           rand() % cct->_conf->bdev_inject_crash == 0) {
538         derr << __func__ << " bdev_inject_crash: dropping io 0x" << std::hex
539     	 << off << "~" << len << std::dec << dendl;
540         ++injecting_crash;
541         return 0;
542       }

** CID 1406086:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_admin.cc: 1636 in commit_period(RGWRealm &, RGWPeriod &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool)()


________________________________________________________________________________________________________
*** CID 1406086:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_admin.cc: 1636 in commit_period(RGWRealm &, RGWPeriod &, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool)()
1630       if (remote.empty() && url.empty()) {
1631         // use the new master zone's connection
1632         remote = master_zone;
1633         cout << "Sending period to new master zone " << remote << std::endl;
1634       }
1635       boost::optional<RGWRESTConn> conn;
>>>     CID 1406086:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "remote_conn" = "NULL".
1636       RGWRESTConn *remote_conn = nullptr;
1637       if (!remote.empty()) {
1638         conn = get_remote_conn(store, period.get_map(), remote);
1639         if (!conn) {
1640           cerr << "failed to find a zone or zonegroup for remote "
1641               << remote << std::endl;

** CID 1406087:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/mgr/PyState.cc: 121 in ceph_send_command(_object *, _object *)()
/home/brad/working/src/ceph/src/mgr/PyState.cc: 147 in ceph_send_command(_object *, _object *)()
/home/brad/working/src/ceph/src/mgr/PyState.cc: 150 in ceph_send_command(_object *, _object *)()


________________________________________________________________________________________________________
*** CID 1406087:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/mgr/PyState.cc: 121 in ceph_send_command(_object *, _object *)()
115             c);
116       } else if (std::string(type) == "osd") {
117         std::string err;
118         uint64_t osd_id = strict_strtoll(name, 10, &err);
119         if (!err.empty()) {
120           // TODO: raise exception
>>>     CID 1406087:    (RESOURCE_LEAK)
>>>     Variable "c" going out of scope leaks the storage it points to.
121           return nullptr;
122         }
123     
124         ceph_tid_t tid;
125         global_handle->get_objecter().osd_command(
126             osd_id,
/home/brad/working/src/ceph/src/mgr/PyState.cc: 147 in ceph_send_command(_object *, _object *)()
141         if (r != 0) {
142           // TODO: raise exception
143           return nullptr;
144         }
145       } else if (std::string(type) == "pg") {
146         // TODO: expose objecter::pg_command
>>>     CID 1406087:    (RESOURCE_LEAK)
>>>     Variable "c" going out of scope leaks the storage it points to.
147         return nullptr;
148       } else {
149         // TODO: raise exception
150         return nullptr;
151       }
152     
/home/brad/working/src/ceph/src/mgr/PyState.cc: 150 in ceph_send_command(_object *, _object *)()
144         }
145       } else if (std::string(type) == "pg") {
146         // TODO: expose objecter::pg_command
147         return nullptr;
148       } else {
149         // TODO: raise exception
>>>     CID 1406087:    (RESOURCE_LEAK)
>>>     Variable "c" going out of scope leaks the storage it points to.
150         return nullptr;
151       }
152     
153       Py_RETURN_NONE;
154     }
155     

** CID 1406088:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/Client.cc: 296 in Client::Client(Messenger *, MonClient *, Objecter *)()


________________________________________________________________________________________________________
*** CID 1406088:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/Client.cc: 296 in Client::Client(Messenger *, MonClient *, Objecter *)()
290     				  cct->_conf->client_oc_max_dirty,
291     				  cct->_conf->client_oc_target_dirty,
292     				  cct->_conf->client_oc_max_dirty_age,
293     				  true));
294       objecter_finisher.start();
295       filer.reset(new Filer(objecter, &objecter_finisher));
>>>     CID 1406088:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "root_ancestor" is not initialized in this constructor nor in any functions that it calls.
296     }
297     
298     
299     Client::~Client()
300     {
301       assert(!client_lock.is_locked());

** CID 1406089:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/rgw/rgw_rest.cc: 1494 in RGWPostObj_ObjStore::read_form_part_header(RGWPostObj_ObjStore::post_form_part *, bool &)()


________________________________________________________________________________________________________
*** CID 1406089:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/rgw/rgw_rest.cc: 1494 in RGWPostObj_ObjStore::read_form_part_header(RGWPostObj_ObjStore::post_form_part *, bool &)()
1488         }
1489     
1490         if (reached_boundary) {
1491           break;
1492         }
1493     
>>>     CID 1406089:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "this->read_line(bl, chunk_size, reached_boundary, done)" to "r" here, but that stored value is overwritten before it can be used.
1494         r = read_line(bl, chunk_size, reached_boundary, done);
1495       }
1496     
1497       return 0;
1498     }
1499     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F2RvkAmtikdYQoty-2BlUwj049nP5-2Bx-2FPo9oNlfzcrZ9jg-2BmvxaLAZy4DFZXP6QTTxRBR-2FJ5gDWUQOmJpa98OpEpRuc5HquLf5nUK5ZlLdNVO-2BnxgGQtWvQpDho2Po0pxoxuhMMWlBgqKFHvAxbgaw9M9f-2F8F-2FnGWnk8-2BmJOQFg9mgka9pqMTiO0DErWixvx9ac-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8F2RvkAmtikdYQoty-2BlUwj049nP5-2Bx-2FPo9oNlfzcrZ9jl7VjSBFayVvHhteZ9EMKxW4rPKRVcy15-2BmGnesem4dU-2BZCGrqQ7LQbRjzHVrjbBiGGyA30LjAfLBU2VZGRiiTgLlZAeZuaoyZLAju2k4umr4KoYl6X480m6HPPAz9Tr1npDkN5UOL-2Bk6o6iEnsEXt4-3D

