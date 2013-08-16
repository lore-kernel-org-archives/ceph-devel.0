From: Milosz Tanski <milosz@adfin.com>
Subject: kclient: Missing directories
Date: Fri, 16 Aug 2013 14:19:22 -0400
Message-ID: <CANP1eJHZE0dFysqTraocaRSF=7-ieBag8hjNVYKTOJ8YqfmPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58442 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab3HPSTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 14:19:24 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so1960970wes.33
        for <ceph-devel@vger.kernel.org>; Fri, 16 Aug 2013 11:19:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

I've been experiencing some weird issues with the kclient that I don't
know how to debug. In some cases the kclient is only seeing part of
the directory tree.

For example earlier today one clients was not seeing a top level
directory (with around 100G of data) that's been created on the ceph
cluster for 2 months now. After I removed another unrelated directory
(also at the top level) in a different node this node started seeing
this.

I don't really know how to debug this issue as it seams intermittent
and comes and goes (as you see). Usually re-mounting helps.

If you have any pointers how to deal / debug with this when file /
directory becomes invisible I would greatly appreciate it.

Thanks,
- Milosz
