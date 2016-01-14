From: Dan Mick <dmick@redhat.com>
Subject: osd logging
Date: Wed, 13 Jan 2016 18:54:27 -0800
Message-ID: <56970DE3.3070904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbcANCy1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 21:54:27 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C17CE7AEBD
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 02:54:27 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0E2sRXP004218
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 21:54:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Watching osd logs, diagnosing a problem, I note a lot of level-5
messages of the form

tick

and

tick_without_osd_lock

Anyone else think those ought to be a higher debug level?  They're
awfully noisy for debug set to 5.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
