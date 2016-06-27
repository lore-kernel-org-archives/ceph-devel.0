From: Milosz Tanski <milosz@adfin.com>
Subject: Re: mem leaks in Bluestore?
Date: Mon, 27 Jun 2016 12:49:49 -0400
Message-ID: <CANP1eJF_h9wfgRQxZGZ0Hw25j73aiVd9eDCZA9wygvGATuupOw@mail.gmail.com>
References: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32838 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcF0Qtv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 12:49:51 -0400
Received: by mail-lf0-f44.google.com with SMTP id f6so160017804lfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 09:49:51 -0700 (PDT)
In-Reply-To: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 27, 2016 at 10:11 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>
> Hi All,
>
> let me share some observations I collected while running ceph_test_objectstore against the bluestore.
>
> Initially I started this investigations due to a failure in SyntheticMatrixCompressionAlgorithm test case. The issue appeared while running the the whole test suite and had a pretty odd symptom: failed test case was run with settings that aren't provided for it: compression = none, compression algorithm = snappy. No attempts to run for zlib despite the fact zlib is the first in the list. When running single test case everything is OK.
> Additional investigations led me to the fact that RAM at my VM decreases almost to zero while running the test suite and that probably prevents from setting desired config params. Hence I proceeded with mem leak investigation.
>
> Since Synthetic test cases are pretty complex I switched to less complex one - Many4KWriteNoCSumTest. As it performs writes only against the single object this eliminates other ops, compression, csum, multiple object handlings etc from under the suspicion.
> Currently I can see ~6Gb mem consumption when doing ~3000 random writes (up to 4K) over 4M object. Counting Bluestore's Buffer, Blob and Onode objects shows that they aren't grow unexpectedly over the time for the test case.
> Then I changed the test case to perform fixed length(64K) writes - mem consumption for 3000 writes reduced to 500M but I can see that Buffer count is permanently growing - one buffer per single write. Thus original issue is rather specific for small writes. But probably there is another issue with buffer cache for big ones.
> That's all what I have so far.
>
> Any comments/ideas are appreciated.
>

Igor,

Today both clang and gcc nowadays have a "performant" address
sanitizer that supports leak detection.
https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
I would try using that first. It's just so much more more performant
than Valgrind, something like a magnitude.



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
