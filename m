From: Dan Mick <dmick@redhat.com>
Subject: Docs falling out of sync with code
Date: Wed, 21 Sep 2016 15:03:12 -0700
Message-ID: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbcIUWDN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 18:03:13 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A04A9E62D
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 22:03:13 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8LM3DtU004983
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 18:03:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The upstream docs at http://ceph.com/docs can tend to become out of
date.  We don't have much process to track things that need doc work.

As a start, I propose we add a "docs needed" flag to tracker.ceph.com so
that we can at least search things that add or change features through a
tracker issue, and a "docs needed" label to github, so we can track it
on PRs as well.

Thoughts?  We can make this happen pretty quickly, and of course it's no
perfect lock, but at least it may start contributors and reviewers
thinking about the issue.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
