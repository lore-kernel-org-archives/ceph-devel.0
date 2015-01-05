From: Stefan Priebe <s.priebe@profihost.ag>
Subject: 10 times higher disk load with btrfs
Date: Mon, 05 Jan 2015 19:36:37 +0100
Message-ID: <54AAD9B5.5080207@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:59339 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbbAESgI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 13:36:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi devs,

while btrfs is now declared as stable ;-) i wanted to retest btrfs on 
our production cluster on 2 out of 54 osds. So if they crash it doesn't 
hurt.

While if those OSDs run XFS have spikes of 20MB/s every 4-7s. The same 
OSDs after formatting them with btrfs have spikes of 190MB/s every 4-7s.

Why does just another filesystem raises the disk load by a factor of 10?

I'm running dumpling.

Greets Stefan
