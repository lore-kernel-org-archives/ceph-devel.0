From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Interesting results
Date: Thu, 28 Jun 2012 16:37:36 -0600
Message-ID: <4FECDCB0.7080406@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48905 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab2F1WiI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 18:38:08 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1EB31D2ECC7
	for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 16:38:06 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 16:37:51 -0600
Received: from mail.sandia.gov (exch04.sandia.gov [134.253.103.4] (may
 be forged)) by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id
 q5SMbaeT004577 for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012
 16:37:36 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Lots of trouble reports go by on the list - I thought
it would be useful to report a success.

Using a patch (https://lkml.org/lkml/2012/6/28/446)
on top of 2.5-rc4 for my OSD servers, the same kernel
for my Linux clients, and a recent master branch
tip (git://github.com/ceph/ceph commit 4142ac44b3f),
I was able to sustain streaming writes from 166 linux
clients for 2 hours:

On 166 clients:
   dd conv=fdatasync if=/dev/zero of=/mnt/ceph/stripe-4M/1/zero0.`hostname -s` bs=4k count=65536k

Elapsed time:   7274.55 seconds
Total data:     45629732.553 MB (43515904 MiB)
Aggregate rate: 6272.516 MB/s

That kernel patch was critical; without it this test
runs into trouble after a few minutes because the
kernel runs into trouble looking for pages to merge
during page compaction.  Also critical were the ceph
tunings I mentioned here:
   http://www.spinics.net/lists/ceph-devel/msg07128.html

-- Jim

