From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/16] rbd: updates and enhancements
Date: Wed, 11 Jul 2012 08:49:48 -0500
Message-ID: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48480 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478Ab2GKNtv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 09:49:51 -0400
Received: by yenl2 with SMTP id l2so1212076yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 06:49:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The following series of patches constitute a few minor
fixes and cleanups, as well as some new utility routines
in the rbd code.  Some of these comprise a foundation
that's being used to add support for the "new" rbd image
format.

We've agreed to refer to the "old" and "new" formats as
format 1 and 2, respectively.

					-Alex

[PATCH 01/16] libceph: fix off-by-one bug in ceph_encode_filepath()
    This is a minor bug fix.

[PATCH 02/16] rbd: drop a useless local variable
    This is a minor cleanup.

[PATCH 03/16] libceph: define ceph_decode_string()
[PATCH 04/16] libceph: define ceph_extract_encoded_string()
[PATCH 05/16] rbd: define dup_token()
    Each of these defines a new utility routine.  They are
    all going to be used in some upcoming rbd patches, but
    they're ready for review now.

[PATCH 06/16] rbd: rename rbd_dev->block_name
[PATCH 07/16] rbd: dynamically allocate object prefix
    These update the "block_name" field of a rbd_dev structure
    to be named "object_prefix", which is consistent with the
    way the new rbd format describes it.  It also removes the
    unnecessary fixed limit on the length of that string.

[PATCH 08/16] rbd: don't store pool name in struct rbd_dev
    Since a pool name can change, this patch makes sure the
    rbd client code doesn't save a copy of it--relying instead
    on the invariant pool id.  The "pool" entry has been
    replaced by "pool_id" in /sys/bus/rbd/<N>.

[PATCH 09/16] rbd: dynamically allocate image header name
[PATCH 10/16] rbd: dynamically allocate image name
[PATCH 11/16] rbd: dynamically allocate snapshot name
    These three change some more fields for in-core data
    structures so they aren't arbitrarily limited to a fixed
    size.

[PATCH 12/16] rbd: use rbd_dev consistently
    This makes all variables representing a struct rbd_device
    be named "rbd_dev".

[PATCH 13/16] rbd: rename some fields in struct rbd_dev
[PATCH 14/16] rbd: more symbol renames
[PATCH 15/16] rbd: option symbol renames
    These change the names of some fields and symbols so
    they are (hopefully) a bit more descriptive.

[PATCH 16/16] rbd: kill num_reply parameters
    This eliminates an unused parameter that was defined in
    a number of functions.
