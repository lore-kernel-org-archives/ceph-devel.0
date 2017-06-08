From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Thu, 8 Jun 2017 19:54:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal> <5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdFHTyV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Jun 2017 15:54:21 -0400
In-Reply-To: <5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <Bassam.Tabbara@Quantum.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Thu, 8 Jun 2017, Bassam Tabbara wrote:
> Thanks Sage.
> 
> > At CDM yesterday we talked about removing the ability to name your ceph 
> > clusters. 
> 
> Just to be clear, it would still be possible to run multiple ceph 
> clusters on the same nodes, right?

Yes, but you'd need to either (1) use containers (so that different 
daemons see a different /etc/ceph/ceph.conf) or (2) modify the systemd 
unit files to do... something.  

This is actually no different from Jewel. It's just that currently you can 
run a single cluster on a host (without containers) but call it 'foo' and 
knock yourself out by passing '--cluster foo' every time you invoke the 
CLI.

I'm guessing you're in the (1) case anyway and this doesn't affect you at 
all :)

sage
