From: David Zafman <dzafman@redhat.com>
Subject: Tracker 12577 repair won't fix replica with bad digest
Date: Mon, 3 Aug 2015 17:31:45 -0700
Message-ID: <55C007F1.3000201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbbHDAbq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Aug 2015 20:31:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>


Sage,

I restored the branch wip-digest-repair which merged post-hammer in pull 
request #4365.  Do you think that 4365 fixes the reported bug #12577?

I cherry-picked the 9 commits off of hammer-backports-next as pull 
request #5458 and assigned to Loic.

David


