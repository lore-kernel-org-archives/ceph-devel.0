From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: On tmap, omap, xattr physical layout
Date: Sun, 26 Aug 2012 10:09:10 -0700
Message-ID: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab2HZRJL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 13:09:11 -0400
Received: by ialo24 with SMTP id o24so6614727ial.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 10:09:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Would anyone mind giving a short overview of the difference between
tmap, omap, and xattrs, and the physical layout of these with respect
to the object payload?

Thanks,
Noah
