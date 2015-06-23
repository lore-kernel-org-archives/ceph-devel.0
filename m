From: "Patelczyk, Maciej" <maciej.patelczyk@intel.com>
Subject: librbd cacher lock protection?
Date: Tue, 23 Jun 2015 15:21:32 +0000
Message-ID: <679865E03F4C71419D9847EA3AACB1632A889519@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38156 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932778AbbFWPVf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 11:21:35 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I'm investigating librbd code related to caching (ObjectCacher).
What I cannot find is the data integrity protection while there is a 'cache miss' (full or partial). It looks like _readx exits with 'defer' and cache_lock is released (and locked again in LibWriteback). The BufferHead's are marked as 'rx' but not protected against write. Writex is not skipping nor checking for any BH. It's just populating data in cache.
That confuses me. So where is the protection? How does the cache integrity protection actually work?

Thanks,
maciej
