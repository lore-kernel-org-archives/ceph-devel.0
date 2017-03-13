From: Martin Bukatovic <mbukatov@redhat.com>
Subject: Re: Fwd: tendrl stragegy for ceph cluster map hierarchy
Date: Mon, 13 Mar 2017 11:04:24 +0100
Message-ID: <89f191fb-1561-058d-1ba4-458ccef0f45b@redhat.com>
References: <bf3c1e56-5355-7b68-69ac-e2082089542b@redhat.com>
 <85cfd1d7-d808-69a4-4258-44acf8ae1be9@redhat.com>
 <alpine.DEB.2.11.1703081442540.1727@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdCMKE0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Mar 2017 06:04:26 -0400
In-Reply-To: <alpine.DEB.2.11.1703081442540.1727@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, tendrl-devel@redhat.com

On 03/08/2017 03:52 PM, Sage Weil wrote:
> Usually the OSDs know enough to put the devices under the correct host, 
> but usually hosts don't know where they exist within the larger cluster.  
> (There are hooks to do this on the host, but it currently relies on 
> something like ansible or chef or puppet to put this somewhere in /etc so 
> that we can tell which rack etc the host lives in.)  That means it's 
> usually the admin who ensure the hosts are positioned properly in the 
> overall hierarchy.  So probably teh first thing would be to make the GUI 
> let you create racks/rows/datacenters/whatever and drag parts of the tree 
> around.

That's a good point. Right now Tendrl is in a early stage of
development and don't have this yet. That said, we need to consider
this feature from the beginning.

I expect that ceph-ansible and ceph-installer provides a way to
achieve this (for the node to know where in hierarchy it is for
ceph to place it into correct place in the crush cluster hierarchy).

To Tendrl team: do we have a plan for such feature?

> As far as visualizing the cluster, the key thing I think we should address 
> from the get-go is how to do it in a way that will scale gracefully to 
> clusters with 100s, 1000s, and 10000s of OSDs.  The most promising 
> thing I've seen (and admittedly I haven't seen much) was from a 
> paper someone (Loic?) sent around a few weeks ago:
> 
> 	http://www.aviz.fr/wiki/uploads/Teaching2014/bundles_infovis.pdf
> 
> See, for example Fig 1 and Fig 13a.  The circle grouping can scale down as 
> the cluster scales up (or you zoom in/out).  (And the actual subject 
> of the paper--data flows--can be applied to show things like data movement 
> during rebalancing/recovery or proposed CRUSH changes.)

Thanks for the link the the paper.

What is the opinion of the Tendrl design and gui people about this
idea? We don't need to have a proper visualization of the cluster in
1st version, but when we start working on it, having scaling to
10000s OSDs in mind is a very good approach.

-- 
Martin Bukatovic
USM QE team
