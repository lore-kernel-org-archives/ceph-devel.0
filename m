From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Possible memory leak in mon?
Date: Thu, 03 May 2012 07:58:27 +0930
Message-ID: <4FA1B50B.8080603@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:53111 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab2EBWdn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 May 2012 18:33:43 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q42MSR56017254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 3 May 2012 07:58:35 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear devs,

I have three mons and two of them suddenly consumed around 4G of RAM 
while third one happily lived with 150M. This immediately prompts few 
questions:

1. What is expected memory use of mon? I believed that mon merely 
directs clients to relevant OSDs and should not consume a lot of 
resources - please correct me if I am wrong.
2. In both cases where mon consumed a lot of memory it was preceded by 
disk-full condition and both machines where incidents happened are 64 
bit, rest of cluster 32 bit. mon fs and log files happened to be in the 
same partition - ceph osd produced a lot of messages, filled up disk, 
mon crashed (no core as disk was full), manually deleted logs, restarted 
mon without any issue, some time later found mon using 4G of RAM. 
Running 0.45. Should I deliberately recreate conditions and crash mon to 
get more debug info (if you need it of course, and if yes then what)?
3. Does figure 4G per process coming from 32 bit pointers in mon? Or mon 
potentially can consume more than 4G?

Regards,
Vladimir
