From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: four minor changes
Date: Mon, 22 Oct 2012 11:49:32 -0500
Message-ID: <5085791C.9010205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36187 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab2JVQti (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:49:38 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3907306iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:49:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This adds a few minor changes to rbd.  The first tightens up
the validity checks for an rbd image.  The second loosens a
restriction on the length of user-provided snapshot name (but
adds early check to see if it's exceeded).  The third refactors
and comments a function, and the last gets rid of a structure
that we don't need to carry around after initialization.

					-Alex

[PATCH 1/4] rbd: verify rbd image order value
[PATCH 2/4] rbd: increase maximum snapshot name length
[PATCH 3/4] rbd: simplify rbd_merge_bvec()
[PATCH 4/4] rbd: kill rbd_device->rbd_opts

