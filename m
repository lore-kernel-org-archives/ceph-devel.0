From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Assertion error in librados
Date: Tue, 25 Feb 2014 16:49:40 +0200
Message-ID: <20140225144900.GA30739@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:48431 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbaBYOts (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Feb 2014 09:49:48 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

Hello all,

We recently bumped into the following assertion error in librados on our
production service:


common/Mutex.cc: In function 'void Mutex::Lock(bool)' thread 7fa2c2ccf700 time 2014-02-21 07:23:26.340791
common/Mutex.cc: 93: FAILED assert(r == 0)
 ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
 1: (Mutex::Lock(bool)+0x131) [0x7fa2c7707431]
 2: (SimpleMessenger::submit_message(Message*, Connection*, entity_addr_t const&, int, bool)+0x52) [0x7fa2c7863172]
 3: (SimpleMessenger::_send_message(Message*, Connection*, bool)+0x23e) [0x7fa2c7863bfe]
 4: (Objecter::send_op(Objecter::Op*)+0x32c) [0x7fa2c76b317c]
 5: (Objecter::handle_osd_map(MOSDMap*)+0x365) [0x7fa2c76b7805]
 6: (librados::RadosClient::_dispatch(Message*)+0x7c) [0x7fa2c768c70c]
 7: (librados::RadosClient::ms_dispatch(Message*)+0x9b) [0x7fa2c768c82b]
 8: (DispatchQueue::entry()+0x4eb) [0x7fa2c7800d2b]
 9: (DispatchQueue::DispatchThread::entry()+0xd) [0x7fa2c78666ad]
 10: (()+0x6b50) [0x7fa2c7203b50]
 11: (clone()+0x6d) [0x7fa2c6b570ed]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'


From what I can tell, there were some network problems on our RADOS cluster,
after which many of our librados clients failed with the above assertion error.

Do you have any ideas of what might went wrong ?

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
