From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 22:54:12 +0200
Message-ID: <4FBBFCF4.5060905@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <4FBBFBA5.9090604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47519 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409Ab2EVUyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:54:15 -0400
In-Reply-To: <4FBBFBA5.9090604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 22.05.2012 22:48, schrieb Mark Nelson:
> Can you use something like iostat or collectl to check and see if the
> write throughput to each SSD is roughly equal during your tests?
It is but just around 20-40MB/s. But they can write 260MB/s with 
sequential writes.

 > Also, what FS are you using and how did you format/mount it?
just:
mkfs.xfs /dev/sdb1
mount options: noatime,nodiratime,nobarrier,discard

Stefan
