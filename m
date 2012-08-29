From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Wed, 29 Aug 2012 13:47:46 +0000 (UTC)
Message-ID: <loom.20120829T153702-223@post.gmane.org>
References: <loom.20120826T033818-148@post.gmane.org> <503A2142.2000505@inktank.com> <loom.20120827T063044-980@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60881 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab2H2NsG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 09:48:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6icl-0003ko-AN
	for ceph-devel@vger.kernel.org; Wed, 29 Aug 2012 15:48:03 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 15:48:03 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 15:48:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

  After zfs installed and two osd's are mounted to zfs file system then started 
ceph.After creating image through qemu-rbd the osd's are going down.
The error log's are,
ceph-osd.1.log is,

2012-08-29 10:55:07.218136 7f6e98598780  1 journal _open 
/data/osd.1/osd.1.journal fd 10: 1048576000 bytes, block size 131072 bytes, 
directio = 0, aio = 0
2012-08-29 10:55:07.221183 7f6e98598780  0 filestore(/data/osd.1) mkjournal 
created journal on /data/osd.1/osd.1.journal
2012-08-29 10:55:07.221312 7f6e98598780  1 filestore(/data/osd.1) mkfs done in 
/data/osd.1
2012-08-29 10:55:07.384739 7f6e98598780 -1 filestore(/data/osd.1) _detect_fs 
unable to create /data/osd.1/xattr_test: (28) No space left on device
2012-08-29 10:55:07.385077 7f6e98598780 -1 OSD::mkfs: couldn't mount FileStore: 
error -28
2012-08-29 10:55:07.385252 7f6e98598780 -1 ^[[0;31m ** ERROR: error creating 
empty object store in /data/osd.1: (28) No space left on device^[[0m



and ceph-osd.2.log is,




 0> 2012-08-29 10:07:19.786818 7fb5da7f4700 -1 *** Caught signal (Aborted) **
 in thread 7fb5da7f4700

 ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
 1: /usr/local/bin/ceph-osd() [0x6ea78a]
 2: (()+0xfcb0) [0x7fb5f86bfcb0]
 3: (gsignal()+0x35) [0x7fb5f6e1d445]
 4: (abort()+0x17b) [0x7fb5f6e20bab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fb5f776b69d]
 6: (()+0xb5846) [0x7fb5f7769846]
 7: (()+0xb5873) [0x7fb5f7769873]
 8: (()+0xb596e) [0x7fb5f776996e]
 9: (object_info_t::decode(ceph::buffer::list::iterator&)+0x544) [0x7fc064]
 10: (object_info_t::object_info_t(ceph::buffer::list&)+0x16e) [0x57b27e]
 11: (ReplicatedPG::get_object_context(hobject_t const&, object_locator_t 
const&, bool)+0xdd) [0x54652d]
 12: (ReplicatedPG::find_object_context(hobject_t const&, object_locator_t 
const&, ReplicatedPG::ObjectContext**, bool, snapid_t*)+0x517) [0x547de7]
 13: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x753) [0x56b4c3]
 14: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199) [0x6051c9]
 15: (OSD::dequeue_op(PG*)+0x238) [0x5c73a8]
 16: (ThreadPool::worker()+0x605) [0x794e35]
 17: (ThreadPool::WorkThread::entry()+0xd) [0x5dd8ad]
 18: (()+0x7e9a) [0x7fb5f86b7e9a]
 19: (clone()+0x6d) [0x7fb5f6ed94bd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to 
interpret this.

Thanks,
Ramu.

