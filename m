From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Handle unfound objects in v0.39
Date: Tue, 12 Jun 2012 15:14:56 +0800
Message-ID: <CANExM-N5Mg1U4wf6UuBfxsAZSFFt+3JbNe982mPGKn8KW2U=oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37171 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2FLHO5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 03:14:57 -0400
Received: by yhmm54 with SMTP id m54so3180770yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 00:14:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

We have some unfound objects in the cluster of ceph v0.39. While
recent ceph versions provide the command to mark unfound objects lost,
is there any manual procedure to handle unfound objects in v0.39?

Assume I know the pgid and oid of the unfound object. I am wondering
if the following procedure works:

1. Based on the pgid and oid, find out the real path and file name of
the object on the osd.
2. Put a fake 4M object to the path found in step 1.
3. Restart the osds.

If there is no manual procedure to handle unfound objects, is it safe
to upgrade ceph from v0.39 to the latest versions?

Henry
