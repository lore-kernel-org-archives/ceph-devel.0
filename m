From: Martin Mailand <martin@tuxadero.com>
Subject: Re: wip-librbd-caching
Date: Wed, 18 Apr 2012 14:50:17 +0200
Message-ID: <4F8EB889.4080106@tuxadero.com>
References: <4F872D48.6070801@tuxadero.com> <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:49953 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab2DRMu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 08:50:29 -0400
In-Reply-To: <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

Am 12.04.2012 21:45, schrieb Sage Weil:
> The config options you'll want to look at are client_oc_* (in case you
> didn't see that already :).  "oc" is short for objectcacher, and it isn't
> only used for client (libcephfs), so it might be worth renaming these
> options before people start using them.

Hi,

I changed the values and the performance is still very good and the 
memory footprint is much smaller.

OPTION(client_oc_size, OPT_INT, 1024*1024* 50)    // MB * n
OPTION(client_oc_max_dirty, OPT_INT, 1024*1024* 25)    // MB * n  (dirty 
OR tx.. bigish)
OPTION(client_oc_target_dirty, OPT_INT, 1024*1024* 8) // target dirty 
(keep this smallish)
// note: the max amount of "in flight" dirty data is roughly (max - target)

But I am not quite sure about the meaning of the values.
client_oc_size Max size of the cache?
client_oc_max_dirty max dirty value before the writeback starts?
client_oc_target_dirty ???


-martin
