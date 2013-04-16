From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7] rbd: existence check or layered writes
Date: Mon, 15 Apr 2013 22:35:00 -0500
Message-ID: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40809 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDfD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:35:03 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so56726iea.24
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:35:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've broken these patches into three groups.

The first two are sort of cleanup from prior patches.

The next one adds support for simple ops that contain
a single data item, which I've termed "raw data."

The next two are some more refinements but they
were done intentionally to prepare for the last
one.

The sixth puts in place flags on object requests
that allow the last patch to determine whether it
needs to issue a STAT call for a target object
before doing a layered write request.

The layered write request ends up being fairly
simple.  Existence flags are recorded for the
target of object requests.  If it is unknown
whether the object exists, a new standalone
object request is created to do a STAT on the
object.  The result (success or ENOENT) is
recorded in a flag in the original request,
at which point the original request is
re-submitted.

This is the first step in doing layered writes.

					-Alex

[PATCH 1/7] libceph: kill off osd data write_request parameters
[PATCH 2/7] libceph: clean up osd data field access functions

[PATCH 3/7] libceph: support raw data requests

[PATCH 4/7] rbd: adjust image object request ref counting
[PATCH 5/7] rbd: always check IMG_DATA flag

[PATCH 6/7] rbd: add target object existence flags
[PATCH 7/7] rbd: issue stat request before layered write
