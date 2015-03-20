From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Hitchhiker erasure code
Date: Fri, 20 Mar 2015 12:37:23 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE8CF7E2@CERNXCHG43.cern.ch>
References: <550BF72E.6030406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx12.cern.ch ([188.184.36.48]:7074 "EHLO CERNMX12.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbbCTMmk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 08:42:40 -0400
In-Reply-To: <550BF72E.6030406@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic, 
I looked at that some time ago.

Table 1 in the paper says it all:

If you care about decoding and reconstruction of data it gives a good improvement.
If you care mainly about encoding speed, it is not the optimal choice (+72.1%).

The algorithm optimizes the reconstruction of data units. This is relevant if your read-size is typically smaller than the block-size e.g. you encode 4 MB objects and you read 4kb pages. With normal EC you get a read amplification of K*4k if a data stripe is down, while with hitchhiker you get only 2/3 of that traffic in case of (10,4).

The most interesting to implement is probably Hitchhiker-XOR+, which you have to combine with a Vandermonde matrix, it requires that the first parity is just the xor of all data chunks.

So, yes, there is certainly a benefit in implementing that compared to other approaches (Xorbas,LRC) since it does not involve a space overhead and opens the door to use larger K values and save space!

Cheers Andreas.






 

