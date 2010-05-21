From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: [Bug Report] Running git-clone on ceph get "File exists" errors
Date: Fri, 21 May 2010 16:08:26 +0800
Message-ID: <AANLkTilWmjbZ6OQYbf2L_RvCguqx6EflOMkGtxbrr4RO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f171.google.com ([209.85.221.171]:61263 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab0EUII1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 May 2010 04:08:27 -0400
Received: by qyk1 with SMTP id 1so1072788qyk.5
        for <ceph-devel@vger.kernel.org>; Fri, 21 May 2010 01:08:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I got the following errors when I tried to do "git clone
git://ceph.newdream.net/git/ceph.git" on ceph fs.
=============================================================
[root@henry-dev ceph]# git clone git://ceph.newdream.net/git/ceph.git
Initialized empty Git repository in /mnt/ceph/ceph/.git/
remote: Counting objects: 81057, done.
remote: Compressing objects: 100% (19534/19534), done.
remote: Total 81057 (delta 65953), reused 75288 (delta 60315)
Receiving objects: 100% (81057/81057), 15.37 MiB | 66 KiB/s, done.
Resolving deltas: 100% (65953/65953), done.
error: git checkout-index: unable to create file
src/auth/RotatingKeyRing.cc (File exists)
error: git checkout-index: unable to create file
src/crush.old/test/creeping_failure_variance.cc (File exists)
error: git checkout-index: unable to create file
src/jobs/alcdat/ossh.lib.big (File exists)
error: git checkout-index: unable to create file
src/messages/MMonSubscribe.h (File exists)
error: git checkout-index: unable to create file src/osbdb/OSBDB.cc
(File exists)
Checking out files: 100% (814/814), done.
==============================================================

These errors are similar to the issue mentioned in
http://ceph.newdream.net/git/?p=ceph-client-standalone.git;a=commit;h=f131f56ea2a09edc5de227975ef7b57ba1592880.
But, it does not work for my case.

So, I traced the client and mds logs. It looks like
ceph_mdsc_do_request() does not handle ERESTARTSYS properly.
The logs show that the file creation request had been sent to MDS, and
MDS did complete the request.
However, before the reply has been received, the request on the client
side was aborted due to some interrupt.
VFS got the ERESTARTSYS error and tried to create the file again.
Since MDS has already created the file, "File exists" errors were returned.

Then, I replaced "wait_for_completion_interruptible" with
"wait_for_completion" in ceph_mdsc_do_request().
The above errors were gone, but I don't feel it is a right way to fix
it. Any ideas?

ps. I am using master version of ceph and master-backport of ceph client.

--Henry C Chang
