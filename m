From: Li Wang <liwang@ubuntukylin.com>
Subject: Blueprint: inline data support (step 2)
Date: Wed, 31 Jul 2013 08:10:01 +0800
Message-ID: <51F855D9.6070306@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:47156 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab3GaAKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 20:10:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

We have worked out a preliminary implementation for inline data support, 
and observed obvious speed up for small file access.

The step 2 will focus on (1) Try to make things simpler to eliminate the 
state of a file half-inlined; (2) To efficiently deal with the share 
write or read/write; (3) Protocal backword compatability

We submitted a blueprint for this, anyone interested is welcome to join 
the discussion.
