From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/9] rbd: activate v2 image support
Date: Fri, 07 Sep 2012 16:09:07 -0500
Message-ID: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61919 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab2IGVJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:09:11 -0400
Received: by ieje11 with SMTP id e11so35853iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:09:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is the eight and final series of patches, this one finally
populating the code that implements support for rbd version 2
images in the Linux kernel rbd client.

All of the previous patches laid the ground work to make these
last steps pretty straightforward.  The first patch lays out
a mechanism where a request to map an rbd image results in a
"probe" operation to determine whether the named image exists
as either version 1 or version 2 format.  Once its existence
(and version) is determined, the rest of the setup for the
rbd device structure proceeds using code appropriate for the
image type.

The last patch in this series simply activates support for
version 2 images, by returning a success indication rather
than ENOSUPP from the version 2 probe routine.

The 7 patches bracketed by these two simply populate the code
that fetches information about a version 2 image, including
its snapshot context and the name and other information about
each snapshot.

This series is available as branch "wip-rbd-review-8" on the
ceph-client git repository, and is based on the branch
"wip-rbd-review-7".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-8

					-Alex

[PATCH 1/9]  17d4a86 rbd: lay out header probe infrastructure
[PATCH 2/9]  86dbebe rbd: add code to get the size of a v2 rbd image
[PATCH 3/9]  0e94833 rbd: get the object prefix for a v2 rbd image
[PATCH 4/9]  a0b250d rbd: get image features for a v2 image
[PATCH 5/9]  57b9193 rbd: get the snapshot context for a v2 image
[PATCH 6/9]  bd39e1f rbd: get snapshot name for a v2 image
[PATCH 7/9]  f33e41f rbd: update remaining header fields for v2
[PATCH 8/9]  431a5bd rbd: define rbd_dev_v2_snapc_refresh()
[PATCH 9/9]  c9c6c27 rbd: activate v2 image support
