From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7]  rbd: isolate mapping info, rearrange init
Date: Fri, 07 Sep 2012 08:40:33 -0500
Message-ID: <5049F951.2030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33245 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab2IGNkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:40:35 -0400
Received: by ieje11 with SMTP id e11so5004351iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:40:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This third series begins a little more interesting code
restructuring.  The first five patches make more clear
the distinction in a struct rbd_device between information
about the underlying rbd image and information about the
mapped snapshot represented by the structure.

The last two patches (which might arguably belong in a
later sub-series) move some initialization code out of
one function and into its caller.

It is available as branch "wip-rbd-review-3" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-2".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-3

					-Alex

[PATCH 1/7]  f4069bf rbd: separate mapping info in rbd_dev
    This groups some related fields of an rbd device structure into
    a sub-structure.  The fields pertain to the specific mapping
    an rbd_device represents--as opposed to the base rbd image.
[PATCH 2/7]  bee627f rbd: record mapped size
    This adds the size of the image or snapshot that's mapped to an
    rbd device's mapping information.
[PATCH 3/7]  8b45382 rbd: return snap name from rbd_add_parse_args()
[PATCH 4/7]  cb93cc4 rbd: set mapping name with the rest
    These two patches make the name of the mapped snapshot be set
    along with the other mapping-related fields.
[PATCH 5/7]  8a245ce rbd: simplify snap_by_name() interface
    This does some refactoring enabled by the previous few patches.
[PATCH 6/7]  e4008bd rbd: do some header initialization earlier
    This rearranges where certain initialization is done, beginning
    the process of re-ordering some of these steps in order to allow
    both format 1 and format 2 rbd images to be handled in the same way.
[PATCH 7/7]  275ba12 rbd: simplify rbd_init_disk() a bit
    This does some refactoring enabled by the previous patch.

