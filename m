From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 09 Nov 2014 06:12:14 -0800
Message-ID: <545f763eb7f1_17e2a9733843489@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:61464 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaKIOMO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Nov 2014 09:12:14 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1251353:  Big parameter passed by value  (PASS_BY_VALUE)
/mds/CInode.cc: 3544 in CInode::validate_disk_state(CInode::validated_data *, std::tr1::shared_ptr<MDRequestImpl> &)::ValidationContinuation::_backtrace(int)()

** CID 1251354:  Structurally dead code  (UNREACHABLE)
/mds/mdstypes.cc: 440 in inode_t::compare(const inode_t&, bool *) const()


________________________________________________________________________________________________________
*** CID 1251353:  Big parameter passed by value  (PASS_BY_VALUE)
/mds/CInode.cc: 3544 in CInode::validate_disk_state(CInode::validated_data *, std::tr1::shared_ptr<MDRequestImpl> &)::ValidationContinuation::_backtrace(int)()
3538           }
3539     
3540           // extract the backtrace, and compare it to a newly-constructed one
3541           try {
3542             bufferlist::iterator p = bl.begin();
3543             ::decode(results->backtrace.ondisk_value, p);
>>>     CID 1251353:  Big parameter passed by value  (PASS_BY_VALUE)
>>>     Catching an exception object of size 264 bytes by value.
3544           } catch (buffer::malformed_input) {
3545             results->backtrace.passed = false;
3546             results->backtrace.error_str << "failed to decode on-disk backtrace!";
3547             return true;
3548           }
3549           int64_t pool;

________________________________________________________________________________________________________
*** CID 1251354:  Structurally dead code  (UNREACHABLE)
/mds/mdstypes.cc: 440 in inode_t::compare(const inode_t&, bool *) const()
434       } else {
435         assert(version < other.version);
436         *divergent = !other.older_is_consistent(*this);
437         return -1;
438       }
439       assert(0 == "can't have reached this point");
>>>     CID 1251354:  Structurally dead code  (UNREACHABLE)
>>>     This code cannot be reached: "*divergent = true;".
440       *divergent = true;
441       return 0;
442     }
443     
444     bool inode_t::older_is_consistent(const inode_t &other) const
445     {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



