From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 15:46:54 -0700 (PDT)
Message-ID: <1706570085.5533.1319669214147.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAF3hT9CLd5W-sHk3os_CeoR_HDY2C0Vm5nZVsRHLLhCCSFh7Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:54953 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab1JZWqy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 18:46:54 -0400
In-Reply-To: <CAF3hT9CLd5W-sHk3os_CeoR_HDY2C0Vm5nZVsRHLLhCCSFh7Bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

----- Original Message -----
> From: "Gregory Farnum" <gregory.farnum@dreamhost.com>
> 
> My main concern with this approach as a long-term solution (after
> we've solved our own teething issues) is the branching mess they have
> going on right now, and the pain of maintaining multiple APIs. But if
> everybody uses the Cloudera distro anyway, maybe this isn't actually a
> big deal?

I would tend to agree. Once it's upstream there is many more people
helping to move it forward with the natural Hadoop churn/branching.
And, FWIW, people are probably move likely to have warm fuzzy feeling
that it's in trunk and already for their use.
