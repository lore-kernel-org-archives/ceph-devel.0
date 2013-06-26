From: Karol Jurak <karol.jurak@gmail.com>
Subject: Modifying RBD image changes it's snapshot
Date: Wed, 26 Jun 2013 14:40:26 +0200
Message-ID: <1805042.yIbHV06QAO@karol-esprimo-p5925>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40342 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab3FZMji (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jun 2013 08:39:38 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so7473783eaj.33
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jun 2013 05:39:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm using ceph 0.56.6 and kernel 3.9.7 and it looks like modifying RBD image 
also changes it's snapshot. I can reproduce this as follows:

# create and map an image
rbd create --size 128 test-1
rbd map test-1

# write some data to the image
dd if=/dev/zero of=/dev/rbd/rbd/test-1 bs=1M count=128

# create and map a snapshot
rbd snap create test-1@snap-1
rbd map test-1@snap-1

# verify that image and snapshot are identical
md5sum /dev/rbd/rbd/test-1 /dev/rbd/rbd/test-1@snap-1 
fde9e0818281836e4fc0edfede2b8762  /dev/rbd/rbd/test-1
fde9e0818281836e4fc0edfede2b8762  /dev/rbd/rbd/test-1@snap-1

# modify the image
dd if=/dev/urandom of=/dev/rbd/rbd/test-1 bs=512 count=1

# compare checksums again
md5sum /dev/rbd/rbd/test-1 /dev/rbd/rbd/test-1@snap-1 
1d942c8a5bc7480cecb945ea0d020eed  /dev/rbd/rbd/test-1
1d942c8a5bc7480cecb945ea0d020eed  /dev/rbd/rbd/test-1@snap-1

Checksums are identical although the snapshot isn't supposed to be modified.

-- 
Karol Jurak
