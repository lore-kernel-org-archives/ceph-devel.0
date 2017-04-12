From: Sage Weil <sweil@redhat.com>
Subject: Re: Minimal crush weight_set integration
Date: Wed, 12 Apr 2017 18:35:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704121833280.10661@piezo.novalocal>
References: <fcb0529a-ff48-1e50-5f8a-ad40f73d12c8@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1981790006-1492022119=:10661"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbdDLSfZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Apr 2017 14:35:25 -0400
In-Reply-To: <fcb0529a-ff48-1e50-5f8a-ad40f73d12c8@dachary.org>
Content-ID: <alpine.DEB.2.11.1704121835210.10661@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1981790006-1492022119=:10661
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1704121835211.10661@piezo.novalocal>

On Wed, 12 Apr 2017, Loic Dachary wrote:
> Hi Sage,
> 
> Assuming the weight set is implemented in crush[1], it could be used 
> with a weight_set matrix for each pool, encoded/decoded with the 
> crushmap[2]. If the weight_set for a given pool does not exist the 
> legacy behavior is preserved. Whenever a pool size, pgp_num changes, the 
> weight_set should also be updated simultaneously.
> 
> Currently CrushWrapper re-creates the workspace for each call to 
> crush_do_rule which is expensive. It could instead be cached. The 
> workspace is created with the replication count as an argument and could 
> then be populated with the weight_set for the corresponding pool which 
> is assumed to be in sync with the pool state (size, pgp_num etc).

Hmm.  The current workspace is meant to be a private temporary space that 
is not shared across threads (this allows the crush mapping functions to 
be const and called on a const OSDMap/CrushWrapper without any locks).  
We should keep its setup as fast/cheap as possible...

I think the weight set is also effectively const, which suggests that 
it probably shouldn't be the same structure after all...

sage

> 
> This would be a very loose implementation of the weight_set relying on 
> external tools to be in sync. The next step would be to add commands on 
> top of that to make it less error prone.
> 
> Do you think we should come up with a robust use case / cli / syntax 
> before implementing this first step ? Or does it look like a sound first 
> step ?
> 
> Cheers
> 
> [1] http://libcrush.org/main/libcrush/merge_requests/30/diffs
> [2] https://github.com/ceph/ceph/pull/14486
> [3] https://github.com/ceph/ceph/pull/14486/files#diff-215e8db28af558a5e445f6267530c786R1179
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--8323329-1981790006-1492022119=:10661--
