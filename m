From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: v2 aligned buffer changes for erasure codes
Date: Thu, 18 Sep 2014 14:47:51 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7D16E6@CERNXCHG44.cern.ch>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411036435-18860-1-git-send-email-j@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1265@CERNXCHG44.cern.ch>
 <20140918124039.GB25730@jannau.net>
 <3472A07E6605974CBC9BC573F1BC02E4AE7D1488@CERNXCHG44.cern.ch>,<20140918132355.GD25730@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:34486 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694AbaIROry convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 10:47:54 -0400
In-Reply-To: <20140918132355.GD25730@jannau.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I fail to see how the 32 * k is related to alignment. It's only used for
> to pad the total size so it becomes a mulitple of k * 32. That is ok
> since we want k 32-byte aligned chunks. The alignment for each chunk is
> just 32-bytes.

Yes, agreed! The alignment for each chunk should be 32 bytes. 

And the implementation is most efficient if the given encoding buffer is already padded to k*32 bytes, it avoids an additional buffer allocation and copy.

Cheers Andreas.