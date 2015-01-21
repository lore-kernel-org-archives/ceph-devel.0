From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Rbd: add listwatchers command
Date: Wed, 21 Jan 2015 22:32:53 +0800
Message-ID: <cover.1421849230.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:55441 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbbAUOpU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 09:45:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

Currently, RBD does not provide an easy way to 
consult who opened a specied image, this complicates
the cloud maintenance, sometimes the administrator 
found that a RBD image could not be deleted with 
an error 'image has watchers', but no further 
information available. The RADOS has a command to 
show the watchers of an object, but the commands 
at RADOS level are not supposed to be exposed to a 
cloud administrator, and it is not clear for a 
non-expert administrator to how to associate an 
opened RBD with a corresponding watched object. 
This motivates us to add an RBD command to list the 
information of the clients who opened a RBD image to 
facilitate the cloud maintenance.

The patches are at:
https://github.com/ceph/ceph/pull/3435

Yunchuan Wen (3):
  rbd: add listwatchers command to list the watchers of an image
  test: add rbd listwatchers to src/test/cli/rbd/help.t
  man: add rbd listwatchers to doc/man/8/rbd.rst

 doc/man/8/rbd.rst       |  3 +++
 src/rbd.cc              | 63 +++++++++++++++++++++++++++++++++++++++++++++++--
 src/test/cli/rbd/help.t |  1 +
 3 files changed, 65 insertions(+), 2 deletions(-)

-- 
1.9.1

