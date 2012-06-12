From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Testing 10GBE
Date: Tue, 12 Jun 2012 15:59:34 +0200
Message-ID: <4FD74B46.6000805@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45522 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2FLN7h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 09:59:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello List,

right now i'm starting to test 10GBE but i got strange results and have 
no idea why this happens:

0,1 and 2 and 3 testsystems. But i've no idea why only Test system 2 <=> 
3 have problems with speed but 3 with 0 or 2 with 0 does not have a problem.

1 => 0 => 9,9Gbit/s
1 => 2 => 5,7Gbit/s
2 => 0 => 9,9Gbit/s
2 => 1 => 5,7Gbit/s
0 => 1 => 9,9Gbit/s
0 => 2 => 9,9Gbit/s

Any ideas?

Stefan
