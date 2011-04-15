From: Sage Weil <sage@newdream.net>
Subject: Re: Mounting
Date: Thu, 14 Apr 2011 20:40:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104142039570.32417@cobra.newdream.net>
References: <4DA786E7.9060305@provocation.net> <20110415000027.GG30604@dreamer>
 <4DA794B2.2010302@provocation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58643 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab1DODhV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 23:37:21 -0400
In-Reply-To: <4DA794B2.2010302@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

> I tried them all:
> 
> # cauthtool -l /etc/ceph/admin.keyring
> [client.admin]
> 	key = AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==
> 	auid = 18446744073709551615
> # mount.ceph 192.168.178.100:6789:/ /vol -v -o name=18446744073709551615,secret=AQATSKdNGBnwLhAAnNDKnH65FmVKpXZJVasUeQ==

The client 'name' to use for this key is 'admin'.

sage
