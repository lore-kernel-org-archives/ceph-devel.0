From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: kill create_snap sysfs entry
Date: Fri, 07 Sep 2012 13:16:00 -0500
Message-ID: <504A39E0.1040107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35405 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab2IGSQF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:16:05 -0400
Received: by ieje11 with SMTP id e11so5527727iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:16:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The point of this sixth series is as the subject indicates--to
get rid of the /sys/bus/rbd/create_snap entry.  There is no need
to provide this functionality via the kernel client, it is done
quite well using the user space "rbd" command.

Simply removing the functionality would leave rbd_req_sync_exec()
with no other references though, and we'll be making quite a bit
of use of that function in supporting format 2 rbd images.

So this series inserts a patch that adds another function we will
want that will make use of rbd_req_sync_exec(). And that patch
requires the other three as prerequisites as well--supporting
data returned from requests made via rbd_req_sync_exec(), then
using the function to perform new "image_id" retrieval operation
on a special image id file used for version 2 images.

It is available as branch "wip-rbd-review-6" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-5".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-6

					-Alex

[PATCH 1/5]  1ab7ae5 rbd: pass flags to rbd_req_sync_exec()
[PATCH 2/5]  44a187e rbd: support data returned from OSD methods
[PATCH 3/5]  f1e1bff rbd: define some new format constants
[PATCH 4/5]  574d0d3 rbd: define rbd_dev_image_id()
[PATCH 5/5]  48080a0 rbd: kill create_snap sysfs entry
