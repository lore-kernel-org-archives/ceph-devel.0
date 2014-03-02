From: Noah Watkins <noah.watkins@inktank.com>
Subject: librados::ObjectIterator segfault
Date: Sun, 2 Mar 2014 10:38:25 -0800
Message-ID: <CA+Hcz58=sbXMpKAGZGvkmZXGFBFbP1FyST2UJ4RM9yex1bM-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:65097 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaCBSi0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Mar 2014 13:38:26 -0500
Received: by mail-qc0-f181.google.com with SMTP id c9so2929838qcz.12
        for <ceph-devel@vger.kernel.org>; Sun, 02 Mar 2014 10:38:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a segfault occuring in the latest master listing objects with
`rados -p data ls`

Full trace: http://pastebin.com/3JG9cX0Z

nwatkins@kyoto:~/ceph2/src$ CEPH_CONF=ceph.conf ./rados lspools
data
metadata
rbd
nwatkins@kyoto:~/ceph2/src$ CEPH_CONF=ceph.conf ./rados -p data ls
*** Caught signal (Segmentation fault) **
 in thread 7f84f02ce7c0
 ceph version 0.77-620-gf3976c1 (f3976c16531096b9979842fc4445d40d6e889932)
 1: /home/nwatkins/ceph2/src/.libs/lt-rados() [0x43e2df]
 2: (()+0xfbb0) [0x7f84eef6bbb0]
 3: (librados::ObjectIterator::operator=(librados::ObjectIterator
const&)+0x27) [0x7f84ef31f807]
 4: (librados::ObjectIterator::ObjectIterator(librados::ObjectIterator
const&)+0x30) [0x7f84ef31fb10]
 5: (main()+0x1bff) [0x41274f]
 6: (__libc_start_main()+0xf5) [0x7f84ee193de5]
 7: /home/nwatkins/ceph2/src/.libs/lt-rados() [0x41b967]
2014-03-02 10:35:57.471206 7f84f02ce7c0 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f84f02ce7c0
