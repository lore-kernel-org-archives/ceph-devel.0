From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Missing include in src/rocksdb/db/builder.cc
Date: Wed, 16 Mar 2016 12:49:13 +0100
Message-ID: <56E94839.2010900@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:33312 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbcCPLtW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Mar 2016 07:49:22 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 56A951534CB
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 12:49:18 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:1992:3782:ffa4:dc3d] (unknown [IPv6:2001:4cb8:3:1:1992:3782:ffa4:dc3d])
	by smtp.digiware.nl (Postfix) with ESMTP id 042DE153430
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 12:49:17 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


I'm running into:

In file included from db/builder.cc:16:
In file included from ./db/compaction_iterator.h:14:
In file included from ./db/compaction.h:13:
./util/mutable_cf_options.h:28:21: error: no member named 
'soft_pending_compaction_bytes_limit' in 'rocksdb::Options'; did you mean
       'hard_pending_compaction_bytes_limit'?
             options.soft_pending_compaction_bytes_limit),
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     hard_pending_compaction_bytes_limit
/usr/local/include/rocksdb/options.h:517:12: note: 
'hard_pending_compaction_bytes_limit' declared here
   uint64_t hard_pending_compaction_bytes_limit;
            ^
Due to a missing:
	#include "util/options_helper.h"

Does anybody have experience with upstreaming this to Rocksdb for the 
version Ceph is using.
I seem to remember somebody posting about this...

Thanx,
--WjW
