From: Sage Weil <sage@newdream.net>
Subject: Re: mem leaks in Bluestore?
Date: Mon, 27 Jun 2016 14:18:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606271416510.2844@piezo.us.to>
References: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53524 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbcF0OSL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 10:18:11 -0400
In-Reply-To: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 27 Jun 2016, Igor Fedotov wrote:
> Hi All,
> 
> let me share some observations I collected while running ceph_test_objectstore
> against the bluestore.
> 
> Initially I started this investigations due to a failure in
> SyntheticMatrixCompressionAlgorithm test case. The issue appeared while
> running the the whole test suite and had a pretty odd symptom: failed test
> case was run with settings that aren't provided for it: compression = none,
> compression algorithm = snappy. No attempts to run for zlib despite the fact
> zlib is the first in the list. When running single test case everything is OK.
> Additional investigations led me to the fact that RAM at my VM decreases
> almost to zero while running the test suite and that probably prevents from
> setting desired config params. Hence I proceeded with mem leak investigation.
> 
> Since Synthetic test cases are pretty complex I switched to less complex one -
> Many4KWriteNoCSumTest. As it performs writes only against the single object
> this eliminates other ops, compression, csum, multiple object handlings etc
> from under the suspicion.
> Currently I can see ~6Gb mem consumption when doing ~3000 random writes (up to
> 4K) over 4M object. Counting Bluestore's Buffer, Blob and Onode objects shows
> that they aren't grow unexpectedly over the time for the test case.
> Then I changed the test case to perform fixed length(64K) writes - mem
> consumption for 3000 writes reduced to 500M but I can see that Buffer count is
> permanently growing - one buffer per single write. Thus original issue is
> rather specific for small writes. But probably there is another issue with
> buffer cache for big ones.
> That's all what I have so far.
> 
> Any comments/ideas are appreciated.

valgrind --tool=massif bin/ceph_test_objectstore --gtest_filter=*Many4K*/2

should generate a heap profile (massif.* iirc?) that you can look at with 
ms_print.

sage
