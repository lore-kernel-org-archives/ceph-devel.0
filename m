From: David Zafman <david.zafman@inktank.com>
Subject: .gitignore issues
Date: Mon, 11 Feb 2013 18:28:23 -0800
Message-ID: <93F21572-A7E9-45FB-9766-6D663D6C6173@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:33621 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab3BLC20 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 21:28:26 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so7135689oag.9
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 18:28:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


After updating to latest master I have the following files listed by git status:

$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       src/bench_log
#       src/ceph-filestore-dump
#       src/ceph.conf
#       src/dupstore
#       src/keyring
#       src/kvstorebench
#       src/multi_stress_watch
#       src/omapbench
#       src/psim
#       src/radosacl
#       src/scratchtool
#       src/scratchtoolpp
#       src/smalliobench
#       src/smalliobenchdumb
#       src/smalliobenchfs
#       src/smalliobenchrbd
#       src/streamtest
#       src/testcrypto
#       src/testkeys
#       src/testrados
#       src/testrados_delete_pools_parallel
#       src/testrados_list_parallel
#       src/testrados_open_pools_parallel
#       src/testrados_watch_notify
#       src/testsignal_handlers
#       src/testtimers
#       src/tpbench
#       src/xattr_bench
nothing added to commit but untracked files present (use "git add" to track)

David Zafman
Senior Developer
david.zafman@inktank.com



