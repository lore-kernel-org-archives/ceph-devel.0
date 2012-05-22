From: Greg Farnum <greg@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 12:35:24 -0700
Message-ID: <B141A2FBE87F4859AF931D71A339468E@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35476 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2EVTfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:35:30 -0400
Received: by dady13 with SMTP id y13so8673153dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 12:35:30 -0700 (PDT)
In-Reply-To: <4FBB8A5B.9010500@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

What does your test look like? With multiple large IOs in flight we can regularly fill up a 1GbE link on our test clusters. With smaller or fewer IOs in flight performance degrades accordingly. 


On Tuesday, May 22, 2012 at 5:45 AM, Stefan Priebe - Profihost AG wrote:

> Hi list,
> 
> my ceph block testcluster is now running fine.
> 
> Setup:
> 4x ceph servers
> - 3x mon with /mon on local os SATA disk
> - 4x OSD with /journal on tmpfs and /srv on intel ssd
> 
> all of them use 2x 1Gbit/s lacp trunk.
> 
> 1x KVM Host system (2x 1Gbit/s lacp trunk)
> 
> With one KVM i do not get more than 40MB/s and my network link is just
> at 40% of 1Gbit/s.
> 
> Is this expected? If not where can i start searching / debugging?
> 
> Thanks,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



