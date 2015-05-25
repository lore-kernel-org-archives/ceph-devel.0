From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: 'Racing read got wrong version' during proxy write testing
Date: Mon, 25 May 2015 06:26:02 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489E8D8C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4048 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbbEYG0Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 May 2015 02:26:16 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I ran into a problem during the teuthology test of proxy write. It is like this:

- Client sends 3 writes and a read on the same object to base tier
- Set up cache tiering
- Client retries ops and sends the 3 writes and 1 read to the cache tier
- The 3 writes finished on the base tier, say with versions v1, v2 and v3
- Cache tier proxies the 1st write, and start to promote the object for the 2nd write, the 2nd and 3rd writes and the read are blocked
- The proxied 1st write finishes on the base tier with version v4, and returns to cache tier. But somehow the cache tier fails to send the reply due to socket failure injecting
- Client retries the writes and the read again, the writes are identified as dup ops
- The promotion finishes, it copies the pg_log entries from the base tier and put it in the cache tier's pg_log. This includes the 3 writes on the base tier and the proxied write
- The writes dispatches after the promotion, they are identified as completed dup ops. Cache tier replies these write ops with the version from the base tier (v1, v2 and v3)
- In the last, the read dispatches, it reads the version of the proxied write (v4) and replies to client
- Client complains that 'racing read got wrong version'

In a previous discussion of the 'ops not idempotent' problem, we solved it by copying the pg_log entries in the base tier to cache tier during promotion. Seems like there is still a problem with this approach in the above scenario. My first thought is that when proxying the write, the cache tier should use the original reqid from the client. But currently we don't have a way to pass the original reqid from cache to base. Any ideas?
