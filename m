From: Willem Jan Withagen <wjw@digiware.nl>
Subject: ceph-disk broken????
Date: Wed, 4 May 2016 22:44:15 +0200
Message-ID: <5e9940d6-d9bb-e9b4-0af8-49e0f0cbb0f5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:39577 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752820AbcEDUos (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 May 2016 16:44:48 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 324DC1534C6
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2016 22:44:37 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:595:cf6a:9232:788a] (unknown [IPv6:2001:4cb8:3:1:595:cf6a:9232:788a])
	by smtp.digiware.nl (Postfix) with ESMTP id AA782153431
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2016 22:44:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

Setup:
   Fresh VM with CentOS7
   standard ceph/ceph clone
   building with run-make-check.sh
      So the dependancies are installed by install-deps.sh

I have several tests that fail with:

  run_osd:  ceph-disk --statedir=testdir/osd-crush 
--sysconfdir=testdir/osd-crush --prepend-to-path= prepare 
testdir/osd-crush/0
Traceback (most recent call last):
   File "/tmp/ceph-disk-virtualenv/bin/ceph-disk", line 5, in <module>
     from pkg_resources import load_entry_point
   File 
"/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.py", 
line 3007, in <module>
     working_set.require(__requires__)
   File 
"/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.py", 
line 728, in require
     needed = self.resolve(parse_requirements(requirements))
   File 
"/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.py", 
line 626, in resolve
     raise DistributionNotFound(req)
pkg_resources.DistributionNotFound: ceph-disk==1.0.0

Looks like ceph-disk is not in the fresh install in tmp...

Ran into this with my development fork, but then also with a regular HEAD
Did I miss something?

--WjW
