From: Sage Weil <sweil@redhat.com>
Subject: bluestore move_ranges
Date: Wed, 2 Nov 2016 15:18:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611021511230.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcKBPSo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Nov 2016 11:18:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ifedotov@mirantis.com, roushan.ali@sandisk.com, ceph-devel@vger.kernel.org

Hey Igor, Roushan,

I fixed the simple review issues, but there remains a problem with the 
blob_depth, and I'm not sure how we should proceed.  The obvious approach 
is to call the same do_write_check_depth that we do in _do_write to get a 
blob depth.  I had a question here, though, because I think this isn't 
actually quite right.  Consider existing blob a and planned write n:

        |     |    |    |    |
  aaaaaaaaaaa
           nnnnnnnnnnnnnn

We'll get blob_depth of 2, but if the min_alloc_size alignment is |, then 
the first bit of nnnn will be one blob (_do_write_small) with the correct 
depth of 2 but the rest will come from _do_write_big and get depth of 2 
when it should have depth of 1.

Even if everything is min_alloc_size aligned, _do_write_big will write 
many smaller blobs depending on compression and max chunk sizes and so on, 
so I'm not sure the gc function can really make an accurate determination 
here.  Am I missing something?

On that note, I think we should make fsck audit the blob_depth.  I'm 
guessing it will complain extensively about the current code.  It might 
be we decide not to make blob_depth perfectly accurate in the end.. in 
which case we can make it a warning and not an error, but either way it 
will be helpful to see.

What do you think?
sage

