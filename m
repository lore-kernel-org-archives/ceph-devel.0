From: Alex Elder <elder@inktank.com>
Subject: Another pile of patches
Date: Fri, 26 Oct 2012 17:42:43 -0500
Message-ID: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63334 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab2JZWmq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:42:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4469278iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:42:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm about to send out several series of patches.  They are in
order--each series based on the previous, so I'm summarizing
them here.

					-Alex

[PATCH, resend] rbd: simplify rbd_rq_fn()
   Resending this one

[PATCH] rbd: remove snapshots on error in rbd_add()
    Bug

[PATCH] rbd: make pool_id a 64 bit value
    Prepares for upcoming changes

[PATCH 1/2] rbd: move snap info out of rbd_mapping struct
[PATCH 2/2] rbd: rename snap_exists field
    A few changes related to mapping structure (which I'm going
    to be removing entirely soon)

[PATCH 1/2] rbd: move ceph_parse_options() call up
[PATCH 2/2] rbd: do all argument parsing in one place
    Consolidate argument parsing

[PATCH 1/8] rbd: get rid of snap_name_len
[PATCH 2/8] rbd: remove options args from rbd_add_parse_args()
[PATCH 3/8] rbd: remove snap_name arg from rbd_add_parse_args()
[PATCH 4/8] rbd: pass and populate rbd_options structure
[PATCH 5/8] rbd: have rbd_add_parse_args() return error
[PATCH 6/8] rbd: define image specification structure
[PATCH 7/8] rbd: add reference counting to rbd_spec
[PATCH 8/8] rbd: fill rbd_spec in rbd_add_parse_args()
    This a series that arranges for the argument parsing routine
    for rbd_add() to do nothing more than parse arguments.  Right
    now it's a mix of parsing and initialization, and this lays
    some solid ground work for a cleaner implementation of the
    upcoming layering features.
