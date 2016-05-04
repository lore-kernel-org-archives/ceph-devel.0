From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Perhaps a missing dependancy in the makefiles
Date: Wed, 4 May 2016 18:27:54 +0200
Message-ID: <add58916-4482-936f-53f7-a79573fc9925@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:51650 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbcEDQk0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 May 2016 12:40:26 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id B0D9D153431
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2016 18:40:22 +0200 (CEST)
Received: from [192.168.101.107] (unknown [176.74.240.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 5706F153402
	for <ceph-devel@vger.kernel.org>; Wed,  4 May 2016 18:27:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Everytime I run a parallel make on the full tree I get the following
complaint:
In file included from db/builder.cc:16:
In file included from ./db/compaction_iterator.h:14:
In file included from ./db/compaction.h:13:
./util/mutable_cf_options.h:28:21: error: no member named
'soft_pending_compaction_bytes_limit' in
      'rocksdb::Options'; did you mean
'hard_pending_compaction_bytes_limit'?
            options.soft_pending_compaction_bytes_limit),
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    hard_pending_compaction_bytes_limit

Then I just run along with a single threaded make, and everything
completes just fine.

So that is probably a missing dependency for either db/builder.cc, or
./util/mutable_cf_options.h.

Suggestions on how to fix this?

Thanx,
--WjW

