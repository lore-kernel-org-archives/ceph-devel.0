From: chris holcombe <chris.holcombe@canonical.com>
Subject: Crc32 Challenge
Date: Tue, 17 Nov 2015 08:51:16 -0800
Message-ID: <564B5B04.8040503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36470 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbKQQvT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Nov 2015 11:51:19 -0500
Received: by pacdm15 with SMTP id dm15so13816043pac.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2015 08:51:19 -0800 (PST)
Received: from [192.168.1.10] (c-73-180-29-35.hsd1.or.comcast.net. [73.180.29.35])
        by smtp.gmail.com with ESMTPSA id fl9sm3180117pab.45.2015.11.17.08.51.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2015 08:51:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello Ceph Devs,

I'm almost certain at this point that I have discovered a major bug in 
ceph's crc32c mechanism.  http://tracker.ceph.com/issues/13713 I'm 
totally open to be proven wrong and that's what this email is about.  
Can someone out there write a piece of code using an outside library 
that produces the same crc32c checksums that Ceph does?  If they can 
I'll close my bug and stand corrected :).  I've tried 3 python libraries 
and 1 rust library so far and my conclusions are 1) they are all in 
agreement and 2) they all produce different checksums than ceph's 
checksums 
https://github.com/ceph/ceph/blob/83e10f7e2df0a71bd59e6ef2aa06b52b186fddaa/src/test/common/test_crc32c.cc#L21

Start small and see if you can verify the "foo bar baz" checksum and 
then try some of the others.

For a known good checksum to test your program against use this: 
http://www.pdl.cmu.edu/mailinglists/ips/mail/msg04970.html  In there 
Mark Bakke talks about a 32 byte array of all 00h should produce a 
checksum of 8A9136AA.  Printing that with python in decimal: 2324772522

The implications of this are unfortunately tricky.  If I'm right and we 
fix ceph's algorithm then it won't be able to talk to any previous 
version of ceph past the beginning protocol handshake. There would have 
to be a mechanism introduced so that any x and older version would speak 
the previous crc and anything y and newer would speak the new version.  
Another option is we could break ceph's crc code out into a library and 
make that available to everyone and call it ceph-crc32c.

Thanks!
Chris
