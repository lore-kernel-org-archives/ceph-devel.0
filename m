From: Sage Weil <sweil@redhat.com>
Subject: bluestore compression error
Date: Tue, 4 Oct 2016 15:45:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610041543570.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbcJDPpM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Oct 2016 11:45:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ifedotov@mirantis.com
Cc: ceph-devel@vger.kernel.org

Hi Igor,

Is this the failure you mentioned in standup?  I just saw it twice:

2016-10-03 18:35:46.868886 7f7d63fef700  1 ZlibCompressor: Decompression error: decompress return -3
2016-10-03 18:35:46.868894 7f7d63fef700 -1 bluestore(bluestore.test_temp_dir) _decompress decompression failed with exit code -1
2016-10-03 18:35:46.870087 7f7d63fef700 -1 /home/sage/src/ceph4/src/os/bluestore/BlueStore.cc: In function 'virtual int BlueStore::read(ObjectStore::CollectionHandle&, const ghobject_t&, uint64_t, size_t, ceph::bufferlist&, uint32_t, bool)' thread 7f7d63fef700 time 2016-10-03 18:35:46.868905
/home/sage/src/ceph4/src/os/bluestore/BlueStore.cc: 4645: FAILED assert(allow_eio || r != -5)

from test ObjectStore/StoreTest.SyntheticMatrixCsumVsCompression/2

sage
