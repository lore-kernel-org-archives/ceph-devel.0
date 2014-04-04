From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Multiple Posix namespaces?
Date: Fri, 4 Apr 2014 14:58:36 -0400
Message-ID: <17BE816D-D0AD-4077-9D85-B43E16F8F1A9@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:41051 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017AbaDDTI3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Apr 2014 15:08:29 -0400
Received: from EXCHCS31.ornl.gov (exchcs31.ornl.gov [128.219.12.145])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by emgwy1.ornl.gov (Postfix) with ESMTPS id 5A3FF10024D
	for <ceph-devel@vger.kernel.org>; Fri,  4 Apr 2014 14:58:47 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel Development <ceph-devel@vger.kernel.org>

Can a single RADOS system support more than one POSIX namespace (i.e. two or more distinct POSIX namespaces sharing the same set of RADOS servers?

Scott