From: John Spray <john.spray@inktank.com>
Subject: Feedback: default FS pools and newfs behavior
Date: Wed, 21 May 2014 16:32:04 +0100
Message-ID: <CAGd4Wr21kmRhJz=uXw4EgLY_UK2NoLMj3e7qKmN3+=ukHa8FdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49380 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbaEUPcF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 11:32:05 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so1508121pab.21
        for <ceph-devel@vger.kernel.org>; Wed, 21 May 2014 08:32:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

In response to #8010[1], I'm looking at making it possible to
explicitly disable CephFS, so that the (often unused) filesystem pools
don't hang around if they're unwanted.

The administrative behavior would change such that:
 * To enable the filesystem it is necessary to create two pools and
use "ceph newfs <metadata> <data>"
 * There's a new "ceph rmfs" command to disable the filesystem and
allow removing its pools
 * Initially, the filesystem is disabled and the 'data' and 'metadata'
pools are not created by default

There's an initial cut of this on a branch:
https://github.com/ceph/ceph/commits/wip-nullfs

Questions:
 * Are there strong opinions about whether the CephFS pools should
exist by default?  I think it makes life simpler if they don't,
avoiding "what the heck is the 'data' pool?" type questions from
newcomers.
 * Is it too unfriendly to require users to explicitly create pools
before running newfs, or do we need to auto-create pools when they run
newfs?  Auto-creating some pools from newfs is a bit awkward
internally because it requires modifying both OSD and MDS maps in one
command.

Cheers,
John

1. http://tracker.ceph.com/issues/8010
