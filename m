From: Igor Fedotov <ifedotov@mirantis.com>
Subject: mem leaks in Bluestore?
Date: Mon, 27 Jun 2016 17:11:38 +0300
Message-ID: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:32851 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcF0OLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 10:11:40 -0400
Received: by mail-lf0-f54.google.com with SMTP id f6so156868256lfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 07:11:40 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id l11sm3375469lfl.23.2016.06.27.07.11.38
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 07:11:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

let me share some observations I collected while running 
ceph_test_objectstore against the bluestore.

Initially I started this investigations due to a failure in 
SyntheticMatrixCompressionAlgorithm test case. The issue appeared while 
running the the whole test suite and had a pretty odd symptom: failed 
test case was run with settings that aren't provided for it: compression 
= none, compression algorithm = snappy. No attempts to run for zlib 
despite the fact zlib is the first in the list. When running single test 
case everything is OK.
Additional investigations led me to the fact that RAM at my VM decreases 
almost to zero while running the test suite and that probably prevents 
from setting desired config params. Hence I proceeded with mem leak 
investigation.

Since Synthetic test cases are pretty complex I switched to less complex 
one - Many4KWriteNoCSumTest. As it performs writes only against the 
single object this eliminates other ops, compression, csum, multiple 
object handlings etc from under the suspicion.
Currently I can see ~6Gb mem consumption when doing ~3000 random writes 
(up to 4K) over 4M object. Counting Bluestore's Buffer, Blob and Onode 
objects shows that they aren't grow unexpectedly over the time for the 
test case.
Then I changed the test case to perform fixed length(64K) writes - mem 
consumption for 3000 writes reduced to 500M but I can see that Buffer 
count is permanently growing - one buffer per single write. Thus 
original issue is rather specific for small writes. But probably there 
is another issue with buffer cache for big ones.
That's all what I have so far.

Any comments/ideas are appreciated.


Thanks,
Igor


