From: Florian Haas <florian@hastexo.com>
Subject: Writes to mounted Ceph FS fail silently if client has no write
 capability on data pool
Date: Thu, 5 Jul 2012 19:40:08 +0200
Message-ID: <CAPUexz-2R40ZRyEhQeEuq29fzgENDkHk=O+xXF=7jiG7ZP0Xuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60416 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab2GERkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 13:40:09 -0400
Received: by qadb17 with SMTP id b17so4031263qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 10:40:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

please enlighten me if I'm misinterpreting something, but I think the
Ceph FS layer could handle the following situation better.

How to reproduce (this is on a 3.2.0 kernel):

1. Create a client, mine is named "test", with the following capabilities:

client.test
	key: <key>
	caps: [mds] allow
	caps: [mon] allow r
	caps: [osd] allow rw pool=testpool

Note the client only has access to a single pool, "testpool".

2. Export the client's secret and mount a Ceph FS.

mount -t ceph -o name=test,secretfile=/etc/ceph/test.secret
daisy,eric,frank:/ /mnt

This succeeds, despite us not even having read access to the "data" pool.

3. Write something to a file.

root@alice:/mnt# echo "hello world" > hello.txt
root@alice:/mnt# cat hello.txt

This too succeeds.

4. Sync and clear caches.

root@alice:/mnt# sync
root@alice:/mnt# echo 3 > /proc/sys/vm/drop_caches

5. Check file size and contents.

root@alice:/mnt# ls -la
total 5
drwxr-xr-x  1 root root    0 Jul  5 17:15 .
drwxr-xr-x 21 root root 4096 Jun 11 09:03 ..
-rw-r--r--  1 root root   12 Jul  5 17:15 hello.txt
root@alice:/mnt# cat hello.txt
root@alice:/mnt#

Note the reported file size in unchanged, but the file is empty.

Checking the "data" pool with client.admin credentials obviously shows
that that pool is empty, so objects are never written. Interestingly,
"cephfs hello.txt show_location" does list an object_name, identifying
an object which doesn't exist.

Is there any way to make the client fail with -EIO, -EPERM,
-EOPNOTSUPP or whatever else is appropriate, rather than pretending to
write when it can't?

Also, going down the rabbit hole, how would this behavior change if I
used cephfs to set the default layout on some directory to use a
different pool?

All thoughts appreciated.

Cheers,
Florian
