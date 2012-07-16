From: Adrian Fita <adrian.fita@gmail.com>
Subject: obsync crashes when src file is unreadable
Date: Mon, 16 Jul 2012 18:42:04 +0300
Message-ID: <CAAEuNhHfbx=AWe_704w+eqCmWvDNK8EvM0K1WtWN2nT57ShicA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37168 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2GPPm0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 11:42:26 -0400
Received: by lbbgm6 with SMTP id gm6so8848892lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 08:42:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello. I'm trying to synchronize 2 Amazon S3 buckets, but obsync keeps
crashing when it tries to read a certain file. Here is the message
displayed when run with --verbose --more-verbose:

Mon, 16 Jul 2012 15:24:48 GMT
/src-bucket/1356/file
Traceback (most recent call last):
  File "/usr/bin/obsync", line 1165, in <module>
    sobj = src_all_objects.next()
  File "/usr/bin/obsync", line 636, in next
    k = self.bucket.get_key(key.name)
  File "/usr/lib/python2.7/dist-packages/boto/s3/bucket.py", line 195,
in get_key
    response.status, response.reason, '')
S3ResponseError: S3ResponseError: 403 Forbidden

ERROR TYPE: unknown, ORIGIN: source

I checked with other S3 clients the state of the file and indeed, it
can not be read and I can't change its ACLs. From what I gather, this
is one of those very rare cases of unreadable Amazon S3 files due to
the failure of Amazon's underlying storage (I think the file will be
automatically recovered at some point later by S3).

It would be nice if obsync would get over this error, continue with
the other files and just display a warning message that the file
couldn't be read. Is there something I can do right now that can make
obsync continue copying (maybe a quick hack in the code or something)?

This is happening on Ubuntu 12.10 2012-07-05, obsync version 0.47.2-0ubuntu2.

Thanks.
--
Fita Adrian
