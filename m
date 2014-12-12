From: Loic Dachary <ldachary@redhat.com>
Subject: Recovery long tail investigation
Date: Fri, 12 Dec 2014 22:45:25 +0100
Message-ID: <548B61F5.3010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbaLLVpa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Dec 2014 16:45:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sheldon Mustard <sheldon.mustard@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sheldon,

In the context of http://tracker.ceph.com/issues/9566 do you remember what the value of max_backfills was ? https://github.com/ceph/ceph/blob/giant/src/common/config_opts.h#L409 It probably makes a difference if it is set to 1 instead of the default.

Cheers

