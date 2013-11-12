From: Haomai Wang <haomaiwang@gmail.com>
Subject: [RBD][OpenStack]The way to solve problem when boot VM and root disk size is specified
Date: Tue, 12 Nov 2013 15:10:48 +0800
Message-ID: <E7DD39A7-418B-4C08-98A2-8CB27AD18711@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57098 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab3KLHLQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 02:11:16 -0500
Received: by mail-pa0-f54.google.com with SMTP id lj1so3127270pab.13
        for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 23:11:15 -0800 (PST)
Received: from [10.96.24.64] ([211.155.113.248])
        by mx.google.com with ESMTPSA id lm2sm41451460pab.2.2013.11.11.23.11.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 23:11:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Now OpenStack Nova master branch still exists a bug when you boot a VM which root disk size is specified. The storage backend of Nova also is rbd. For example, you boot a VM and specify 10G as root disk size. But the image is only 1G. Then VM will be spawned and the root disk size will expands to 10G. The filesystem still is 1G.

Now I have a way to solve it. When we boot a VM and resize root disk size, we use "fuse-rbd" command to resize filesystem.

fuse-rbd -p pool -c /etc/ceph/ceph.conf /tmp-ceph-rbd
cd /tmp-ceph-rbd
resize2fs volume-xxxxxxxxxxx 

It seemed to work but I want to know whether exists problems when many volumes in a pool. I'm not sure that too many volumes cause performance problem.

Best regards,
Wheats



