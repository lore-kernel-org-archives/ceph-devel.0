From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: About deleting container/bucket from radosgw
Date: Sat, 14 Jul 2012 21:45:53 +0800
Message-ID: <CAKG+gh-25-9PgjPBpXx4PoGSinjudVtk8xXit-LBuqXDhPyUvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46432 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab2GNNpz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 09:45:55 -0400
Received: by eaak11 with SMTP id k11so1304036eaa.19
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jul 2012 06:45:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone,

I try to use radosgw to supply s3/swift storage,

everything is fine, but I found that something strange

after deleting a container/bucket from radosgw,

the following are commands I ran:

1. check the pool empty or not
$ rados --pool=.rgw ls | grep -v "^\." ; echo ============; rados
--pool=.rgw.buckets ls
============

2. create a container "buck1"
$ swift -A http://volume/auth -U account -K key post buck1

3. show created objs in ceph
$ rados --pool=.rgw ls | grep -v "^\." ; echo ============; rados
--pool=.rgw.buckets ls
9352.10
buck1
============
.dir.9352.10

4. delete "buck1"
swift -A http://volume/auth -U account -K key delete buck1

5. show objs in ceph
$ rados --pool=.rgw ls | grep -v "^\." ; echo ============; rados
--pool=.rgw.buckets ls
9352.10

Then, the object '9352.10' seems like be leaved in pool forever ?
I have tried create & delete bucket by s3lib, too,
and the result is the same.

However, the function works fine,
I just want to know is this a normal case?

Thanks.

--
Chuanyu Tsai
