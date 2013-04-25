From: Martin Mailand <martin@tuxadero.com>
Subject: Re: cuttlefish countdown -- OSD doesn't get marked out
Date: Thu, 25 Apr 2013 15:04:00 +0200
Message-ID: <517929C0.4050407@tuxadero.com>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net> <51791C83.3010403@tuxadero.com> <517927E6.2000903@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:59008 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab3DYNEH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 09:04:07 -0400
In-Reply-To: <517927E6.2000903@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Wido,

I did not set the noosdout flag.

-martin

On 25.04.2013 14:56, Wido den Hollander wrote:
> Could you dump your osdmap? The first 10 lines would be interesting.
> There is a flag where you say "noosdout", could it be that the flag is set?
> 
> Wido


epoch 206
fsid 13538f8a-a9b5-4f57-ad72-b0f9bec56a3e
created 2013-03-28 20:19:20.790878
modified 2013-04-25 13:09:55.825509
flags

pool 0 'data' rep size 2 min_size 1 crush_ruleset 0 object_hash rjenkins
pg_num 1600 pgp_num 1600 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 min_size 1 crush_ruleset 1 object_hash
rjenkins pg_num 1600 pgp_num 1600 last_change 1 owner 0
pool 2 'rbd' rep size 2 min_size 1 crush_ruleset 2 object_hash rjenkins
pg_num 1600 pgp_num 1600 last_change 77 owner 0
        removed_snaps [1~1]
pool 3 'volumes' rep size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 128 pgp_num 128 last_change 199 owner 0
pool 4 'images' rep size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 128 pgp_num 128 last_change 204 owner 0
        removed_snaps [1~1]

max_osd 24
