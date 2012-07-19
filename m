From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: use snapc->seq the way server does
Date: Thu, 19 Jul 2012 12:09:57 -0500
Message-ID: <50083F65.5030104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54145 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2GSRJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 13:09:59 -0400
Received: by yenl2 with SMTP id l2so3010889yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 10:09:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series of patches changes the way the snap context "seq" field
is used.  Currently it is used in a way that isn't really useful, and
as such is a bit confusing.  This behavior seems to be a hold over
from a time when there was no snap_id field maintained for an rbd_dev.

Summary:
[PATCH 1/4] rbd: don't use snapc->seq that way
    Removes special handling in __rbd_refresh_header() that ensured
    the seq field was updated to point to the head if it had been
    at the start of the function.
[PATCH 2/4] rbd: preserve snapc->seq in rbd_header_set_snap()
    Changes rbd_header_set_snap() so it doesn't set the seq field
    to the snapshot id (for a snapshot mapping) or the highest
    snapshot id (for the base image).
[PATCH 3/4] rbd: set snapc->seq only when refreshing header
    Assigns snapc->seq whenever an updated rbd image header is
    received rather than when a new snapshot id has been
    assigned.
[PATCH 4/4] rbd: kill rbd_image_header->snap_seq
    Gets rid of the rbd_image_header->snap_seq field, which
    previously kept the same information now maintained in
    the snapc->seq field.

					-Alex
