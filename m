From: Howard Chu <hyc@symas.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Mon, 2 May 2016 20:00:44 +0100
Message-ID: <5727A3DC.7070102@symas.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zill.ext.symas.net ([69.43.206.106]:34894 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbcEBTSw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2016 15:18:52 -0400
In-Reply-To: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Sage Weil wrote:
> 1) Thoughts on moving to rocksdb in general?

Are you actually prepared to undertake all of the measurement and tuning 
required to make RocksDB actually work well? You're switching from an 
(abandoned/unsupported) engine with only a handful of config parameters to one 
with ~40-50 params, all of which have critical but unpredictable impact on 
resource consumption and performance.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
