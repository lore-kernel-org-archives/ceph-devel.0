From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: RGW Caching and admin ops
Date: Tue, 10 May 2016 14:44:14 +0200
Message-ID: <87a8jyf5gh.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35226 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbcEJMoR (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 10 May 2016 08:44:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Casey Bodley <cbodley@redhat.com>


Running normal rgw admin queries like `user info` or `bucket list` etc.
seemed significantly slower on the primary for a multisite cluster. On
investigating further with Casey yesterday, we found that most of the
time is spent up in setting up watchers and cleaning them up, and this
is because even for rgw admin cli ops, the cache is enabled.

=46or some local runs I saw an operation like:
$ time radosgw-admin user info --uid=3Dtestid > /dev/null
real    1m47.517s
user    0m0.176s
sys     0m0.132s

the same op with --rgw-cache-enabled=3Dfalse completes in about ~0.1-0.=
2s.

Does rgw_cache serve any purpose for rgw admin cli ops?

Cheers
--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
