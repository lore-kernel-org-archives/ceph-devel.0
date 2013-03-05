From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Using different storage types on same osd hosts?
Date: Tue, 05 Mar 2013 21:48:22 +0100
Message-ID: <51365A16.4020103@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:46896 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab3CEUsW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:48:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

right now i have a bunch of OSD hosts (servers) which have just 4 disks 
each. All of them use SSDs right now.

So i have a lot of free harddisk slots in the chassis. So my idea was to 
create a second ceph system using these free slots. Is this possible? Or 
should i just the first one with different rules? Any hints?

Greets,
Stefan

