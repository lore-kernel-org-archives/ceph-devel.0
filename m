From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Sun, 27 May 2012 11:11:13 +0200
Message-ID: <4FC1EFB1.5090800@profihost.ag>
References: <96b57450-8d24-48df-8a82-b9bec2ff3c69@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58954 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2E0JLS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 May 2012 05:11:18 -0400
In-Reply-To: <96b57450-8d24-48df-8a82-b9bec2ff3c69@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Can really nobody help?

Am 25.05.2012 17:47, schrieb Alexandre DERUMIER:
> Hi Stephan,
> Do you have same performance with read ?

Read is fine for both versions see here:

3.0.30

Write:
Total time run:        30.872357
Total writes made:     1095
Write size:            4194304
Bandwidth (MB/sec):    141.874

Average Latency:       0.450187
Max latency:           2.00672
Min latency:           0.091783

Read:
Total time run:        22.907021
Total reads made:     1095
Read size:            4194304
Bandwidth (MB/sec):    191.208

Average Latency:       0.333954
Max latency:           1.71987
Min latency:           0.041373

3.4.0

Write:
Total time run:        124.573247
Total writes made:     647
Write size:            4194304
Bandwidth (MB/sec):    20.775

Average Latency:       3.08058
Max latency:           65.2522
Min latency:           0.089587

Read:
Total time run:        13.191562
Total reads made:     647
Read size:            4194304
Bandwidth (MB/sec):    196.186

Average Latency:       0.322895
Max latency:           1.22392
Min latency:           0.043784


> Did you have done some iostats ?
Yes - I/O is heavily jumping between 0 and 60MB/s but of the time it's 0 
or around 10MB/s.

> how much time to flush from journal to disks ?
I don't know how to measure this. As ceph starts to write to journal and 
disk in parallel and tmpfs isn't even shown in iostat.

Greets,
Stefan
