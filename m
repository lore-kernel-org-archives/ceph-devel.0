From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: version 2 parent probing
Date: Tue, 30 Oct 2012 20:41:24 -0500
Message-ID: <509081C4.3050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41850 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2JaBl2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 21:41:28 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so673332iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 18:41:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This series puts in place a few remaining pieces before finally
implementing the call to rbd_dev_probe() for the parent of a
layered rbd image if present.

					-Alex

[PATCH 1/6] rbd: skip getting image id if known
[PATCH 2/6] rbd: allow null image name
    These two take care of two issues that will arise once
    we have activated probing parents.
[PATCH 3/6] rbd: get parent spec for version 2 images
    This fetches the identities for a parent image.
[PATCH 4/6] libceph: define ceph_pg_pool_name_by_id()
[PATCH 5/6] rbd: get additional info in parent spec
    This populates the parent spec with the names of the
    ids for a parent image.
[PATCH 6/6] rbd: probe the parent of an image if present
    This finally adds a call to the probe routine, and
    handles teardown of layered images as well.
