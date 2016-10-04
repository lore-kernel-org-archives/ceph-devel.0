From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore compression error
Date: Tue, 4 Oct 2016 19:12:14 +0300
Message-ID: <0bb76c3e-7327-ecce-fbee-a26e46c4f6ec@mirantis.com>
References: <alpine.DEB.2.11.1610041543570.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35257 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbcJDQMS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 12:12:18 -0400
Received: by mail-yw0-f178.google.com with SMTP id t193so55745057ywc.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Oct 2016 09:12:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610041543570.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Almost...

In fact I saw this once and a couple more times it was statfs mismatch 
error on umount/fsck.

Igor

On 04.10.2016 18:45, Sage Weil wrote:
> Hi Igor,
>
> Is this the failure you mentioned in standup?  I just saw it twice:
>
> 2016-10-03 18:35:46.868886 7f7d63fef700  1 ZlibCompressor: Decompression error: decompress return -3
> 2016-10-03 18:35:46.868894 7f7d63fef700 -1 bluestore(bluestore.test_temp_dir) _decompress decompression failed with exit code -1
> 2016-10-03 18:35:46.870087 7f7d63fef700 -1 /home/sage/src/ceph4/src/os/bluestore/BlueStore.cc: In function 'virtual int BlueStore::read(ObjectStore::CollectionHandle&, const ghobject_t&, uint64_t, size_t, ceph::bufferlist&, uint32_t, bool)' thread 7f7d63fef700 time 2016-10-03 18:35:46.868905
> /home/sage/src/ceph4/src/os/bluestore/BlueStore.cc: 4645: FAILED assert(allow_eio || r != -5)
>
> from test ObjectStore/StoreTest.SyntheticMatrixCsumVsCompression/2
>
> sage

