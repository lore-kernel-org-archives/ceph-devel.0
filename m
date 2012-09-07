From: Alex Elder <elder@inktank.com>
Subject: Patch Bomb(s) for rbd
Date: Fri, 07 Sep 2012 07:39:50 -0500
Message-ID: <5049EB16.30607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63930 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2IGMjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 08:39:53 -0400
Received: by iahk25 with SMTP id k25so3150660iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 05:39:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have a large series of patches I'm about to post for
review.  I'm breaking them up into a set of smaller series
so each of them can be reviewed fairly independently.
Each group of patches will normally have some logical
connection to each other, though that connection might
be somewhat tenuous.  I'm still doing some final review
and preparation of some of them so they won't appear
until a bit later today.

In total these patches implement the version 2 rbd image
format in the rbd kernel client.

					-Alex
