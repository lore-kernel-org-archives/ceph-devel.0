From: Sam Lang <sam.lang@inktank.com>
Subject: objectcacher lru eviction causes assert
Date: Mon, 19 Nov 2012 17:22:53 -0600
Message-ID: <50AABF4D.8050109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57836 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2KSXWz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:22:55 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3798699iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:22:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi All,

We've been fixing a number of objectcacher bugs to handle races between 
slow osd commit replies and various other operations like truncate.  I 
ran into another problem earlier today with a race between an object 
getting evicted from the lru cache (via readx -> trim) and the osd 
commit reply.  The assertion trace is below.

We've avoided keeping a reference to the object during the commit, but 
that means that the object isn't pinned in the lru, and so can come up 
for eviction.  When it gets evicted, we close the object and hit the 
assertion, which we can't do - because we need the object to finish the 
commit.

I've pushed a change that needs review in the wip-3431 branch.  It 
allows the the object to be evicted from the lru cache, but checks that 
it can be closed (as we do elsewhere) - and if not, lets the commit 
handle the close (via flush...release).

The assertion we hit is:

2012-11-19 09:06:35.187910 7ff143e2f780 1 osdc/ObjectCacher.cc: In 
function 'void ObjectCacher::close_object(ObjectCacher::Object*)' thread 
7ff143e2f780 time 2012-11-19 09:06:35.186379
osdc/ObjectCacher.cc: 577: FAILED assert(ob>can_close())
ceph version 0.54-641-g4c69f86 (4c69f865ca79328c62635ae32c91bd32b3985613)
  1: (ObjectCacher::close_object(ObjectCacher::Object*)+0x135) [0x5c78d5]
  2: (ObjectCacher::trim(long, long)+0x820) [0x5c94d0]
  3: (ObjectCacher::_readx(ObjectCacher::OSDRead*, 
ObjectCacher::ObjectSet*, Context*, bool)+0x21ad) [0x5d92dd]
  4: (Client::_read_async(Fh*, unsigned long, unsigned long, 
ceph::buffer::list*)+0x3e9) [0x486c09]
  5: (Client::_read(Fh*, long, unsigned long, 
ceph::buffer::list*)+0x265) [0x49bd65]
  6: (Client::ll_read(Fh*, long, long, ceph::buffer::list*)+0x97) [0x49be87]
  7: /tmp/cephtest/binary/usr/local/bin/ceph-fuse() [0x4733cf]
  8: (()+0x12d5e) [0x7ff1439fdd5e]
  9: (fuse_session_loop()+0x75) [0x7ff1439fbd65]
  10: (ceph_fuse_ll_main(Client*, int, char const**, int)+0x225) [0x474245]
  11: (main()+0x42f) [0x4716ef]
  12: (__libc_start_main()+0xed) [0x7ff141ebd76d]
  13: /tmp/cephtest/binary/usr/local/bin/ceph-fuse() [0x472e95]
