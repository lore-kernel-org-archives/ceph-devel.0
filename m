From: Sage Weil <sweil@redhat.com>
Subject: replace fiemap with seek_data/seek_hole?
Date: Tue, 6 Jan 2015 08:44:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501060837090.8073@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbbAFQoy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Jan 2015 11:44:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomaiwang@gmail.com, jianpeng.ma@intel.com
Cc: ceph-devel@vger.kernel.org

Hey,

In an exchange on linux-fsdevel yesterday it became clear that even when 
FIEMAP isn't buggy it's not a good interface to build a map of sparse 
files.  For example, XFS defrag or other future fs features may muck with 
fiemap results.  One wouldn't expect those things to change whether a file 
extent is allocated or not allocated, but given what we've seen so far I 
wouldn't bet on it.

Instead, we should use lseek SEEK_DATA/SEEK_HOLE, which is a more natural 
interface for what we need.  This should simply be a matter of replacing 
the fiemap() method implementation in FileStore.cc, I think.

See this thread:

	http://marc.info/?l=linux-fsdevel&m=142050204317588&w=2

The other half of this is we should confirm that xfstests.git has good 
SEEK_HOLE/SEEK_DATA stress tests (that verify correct results on both 
recently written, recently synced, and uncached files).

sage
