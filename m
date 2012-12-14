From: "Jim Schutt" <jaschut@sandia.gov>
Subject: OSDMonitor: don't allow creation of pools with > 65535 pgs
Date: Fri, 14 Dec 2012 08:41:02 -0700
Message-ID: <50CB488E.3090005@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:50281 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab2LNPlU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:41:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>, Greg Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm looking at commit e3ed28eb2 in the next branch,
and I have a question.

Shouldn't the limit be pg_num > 65536, because
PGs are numbered 0 thru pg_num-1?

If not, what am I missing?

FWIW, up through yesterday I've been using the next branch and this:

  ceph osd pool set data pg_num 65536 --allow-experimental-feature
  ceph osd pool set metadata pg_num 65536 --allow-experimental-feature
  ceph osd pool set data pgp_num 65536 --allow-experimental-feature
  ceph osd pool set metadata pgp_num 65536 --allow-experimental-feature

using cephfs clients, and have seen no trouble with
misdirected ops, etc.

-- Jim

