From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: EC-ISA buffer alignment
Date: Thu, 25 Sep 2014 15:18:28 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7D9EC3@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:40514 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbaIYPSc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:18:32 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all, 
find attached a pull request to honor 32 byte buffer alignment independent of compilation environment (vector size) as it was discussed on the list beforehand.

https://github.com/ceph/ceph/pull/2573

Cheers Andreas.


