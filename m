From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: ext4 store and device-mapper
Date: Thu, 14 Apr 2011 21:26:17 +0200
Message-ID: <4DA74A59.9050505@provocation.net>
References: <4DA73FEE.2060404@provocation.net> <20110414190026.GF30604@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:36205 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481Ab1DNT0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 15:26:22 -0400
In-Reply-To: <20110414190026.GF30604@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/14/2011 09:00 PM, Tommi Virtanen wrote:

>> 2011-04-14 20:22:24.887172 7fdc84de1720 OSD::mkfs: couldn't mount FileStore: error -95
>> 2011-04-14 20:22:24.887226 7fdc84de1720  ** ERROR: error creating empty object store in /mnt/osd: error 95: Operation not supported
>> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.ShIRgaTSnR --init-daemon osd.0'

> That usually means you're missing user_xattr from the mount
> options. Can you confirm?

You're absolutely right; it works! Thank you.

> The error message was recently changed to be more helpful, just to
> help people falling into this particular trap.

I just put it in the wiki as well, it might help the next guy...

Z




