From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/12] rbd: new request tracking code
Date: Tue, 22 Jan 2013 16:25:46 -0600
Message-ID: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:48450 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab3AVWZt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:25:49 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so3602509iak.10
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:25:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series of patches reimplements the way rbd requests are
managed.

The motivation for doing this is that the existing code assumes
in places that every I/O request was associated with a Linux
request initiated from the block layer.  In order to support
layered rbd images, we need to initiate rbd image requests
within rbd.  In addition, the size of an rbd object in a parent
image could be smaller than the object size in the child.  That
means satisfying a request to a single object in the child image
may require issuing requests to multiple objects in the parent.
This too was not easily supported by the existing code.

In this new code, we distinguish between an "image request"
and an "object request."  An image request is an I/O
operation defined in terms of an entire rbd image--its offset
and length are relative to the image as a whole.  An object
request is a request targeted at a single rbd object.  An
image request is implemented using one or more object requests,
but individual object requests can also be used for doing
things like reading or operating on the rbd image header
object.

The new code also more clearly separates itself from the
osd client, especially with respect to request completion.
Each object request supplies a common callback function with
its osd client request.  This callback handles certain
rbd-specific tasks, like zero-filling portions of a read
buffer that were not supplied by the.  A simple wait routine
is now supplied to allow synchronous completion of an object
request.

This set of changes is available in the ceph-client git
repository branch "wip-rbd-review".  That branch also
begins with three unrelated commits (which I recently posted
for review) and ends with two others (which are temporary
and there only to test with version 2 image support
enabled).

					-Alex

[PATCH 01/12] rbd: new request tracking code
[PATCH 02/12] rbd: kill rbd_rq_fn() and all other related code
[PATCH 03/12] rbd: kill rbd_req_coll and rbd_request
[PATCH 04/12] rbd: implement sync object read with new code
[PATCH 05/12] rbd: get rid of rbd_req_sync_read()
[PATCH 06/12] rbd: implement watch/unwatch with new code
[PATCH 07/12] rbd: get rid of rbd_req_sync_watch()
[PATCH 08/12] rbd: use new code for notify ack
[PATCH 09/12] rbd: get rid of rbd_req_sync_notify_ack()
[PATCH 10/12] rbd: send notify ack asynchronously
[PATCH 11/12] rbd: implement sync method with new code
[PATCH 12/12] rbd: get rid of rbd_req_sync_exec()
