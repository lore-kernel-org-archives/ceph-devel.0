From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: radosgw-agent testing
Date: Thu, 22 Aug 2013 13:38:12 +0200
Message-ID: <CAA8043hiySh18_LR_v3opM=sMiSikciLr9o3+35M9=xs29t55g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51210 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab3HVLid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 07:38:33 -0400
Received: by mail-ob0-f180.google.com with SMTP id v19so1662827obq.11
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 04:38:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda,

I'm currently trying to test the radosgw-agent which lives in
https://github.com/ceph/radosgw-agent

I modified the vstart.sh script (you can see it here
https://github.com/ceph/ceph/pull/522) to be able to launch multiple
cluster with vstart.sh in different directories.

I created a little script to automate the launch of two clusters and
the setup of region and zone, so that i have a master and a slave
cluster.

With that setup, i encounter two problems:

First when i try to create a bucket after setup is done using s3cmd,
got this error
ERROR: Access to bucket 'TEST' was denied.
in the function open_bucket_pool_ctx, it tries to open the pool
.rgw.buckets.index, but this pool doesn't seems to exist.
Is this behaviour correct? Is it due to my setup? or should this pool
be created?

Second, is that i get a 403 while using the radosgw-agent on the
previous setup, with the test.sh script.
Am i doing something wrong here?

To reproduce the first bug:

- Get the vstart.sh script from https://github.com/ceph/ceph/pull/522
- Get the script to launch cluster and the *.master *.zone files
- Launch the script
- Try to create a bucket with s3cmd

To reproduce the second one :

- Do the same setup as for the first one
- Get the radosgw-agent repo
- Get the test.sh script in this directory
- Launch the test.sh script

You can find below the various files i mentionned earlier

the script for launching clusters
http://pastebin.com/VSJhwRSs

master.region file
http://pastebin.com/pCrRpM3w

master.zone file
http://pastebin.com/gi1DDNvr

slave.region file
http://pastebin.com/idgMDYjj

slave.zone file
http://pastebin.com/m2KRnqdJ

test.sh file
http://pastebin.com/gaitrPqX

Best regards

-- 
Christophe Courtaut
