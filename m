From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Pull Request for ISA EC plug-in
Date: Mon, 28 Jul 2014 15:12:31 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7509E3@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:1702 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbaG1PMe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 11:12:34 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

here is a PULL request for the ISA EC plugin rebased against master of today for review.

https://github.com/ceph/ceph/pull/2155

I have added as discussed the exhaustive test of all possible failures scenarios for both supported matrix types for a (k=12,m=4) configuration to the unit tests ( which helped indeed to spot a bug in the table caching ) 

Cheers Andreas.





