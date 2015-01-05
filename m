From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] rbd: merge diff files
Date: Mon,  5 Jan 2015 17:05:56 +0800
Message-ID: <cover.1420444746.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:38036 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbbAEJ1v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 04:27:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, MingXin Liu <mingxinliu@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

RBD supplies the 'export-diff' to 
export a diff file between two clones. 
This is inconvinient for periodical backup, 
since a bunch of diff files wastes the disk
space by keeping multiple copies of the 
data on the same location, and complicates 
and slows down the recovery process. 
In this case, only one diff file is expected. 
This motivates us to develop a 'merge-diff' 
tool. The semantic is straightforward,
it merges two diff files into one single diff 
file. Multiple diff files could be easily 
merged by further using some simple shell 
tricks.

The patches are at:
https://github.com/ceph/ceph/pull/3292

MingXin Liu (6):
  rbd: add an option merge-diff
  rbd: parse merge-diff arguments
  rbd: write a diff description into the merged diff file
  rbd: parse diff file header for diff merging
  rbd: parse diff file body for diff merging
  rbd: test case for rbd merge-diff

Yunchuan Wen (1):
  rbd: merge two diff files into one single file

 qa/workunits/rbd/merge_diff.sh | 475 +++++++++++++++++++++++++++++++++++++++++
 src/rbd.cc                     | 384 ++++++++++++++++++++++++++++++++-
 2 files changed, 855 insertions(+), 4 deletions(-)
 create mode 100755 qa/workunits/rbd/merge_diff.sh

-- 
1.9.1

