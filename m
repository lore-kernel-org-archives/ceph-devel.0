From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Mounting
Date: Fri, 15 Apr 2011 14:59:45 +0200
Message-ID: <4DA84141.1090604@provocation.net>
References: <4DA786E7.9060305@provocation.net> <20110415000027.GG30604@dreamer> <4DA794B2.2010302@provocation.net> <Pine.LNX.4.64.1104142039570.32417@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:43305 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab1DOM7r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 08:59:47 -0400
In-Reply-To: <Pine.LNX.4.64.1104142039570.32417@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/15/2011 05:40 AM, Sage Weil wrote:

>> I tried them all:

>> # cauthtool -l /etc/ceph/admin.keyring
>> [client.admin]
>> 	key = AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==
>> 	auid = 18446744073709551615
>> # mount.ceph 192.168.178.100:6789:/ /vol -v -o name=18446744073709551615,secret=AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==

> The client 'name' to use for this key is 'admin'.

Oops. Thanks!

Z (feeling stupid)

