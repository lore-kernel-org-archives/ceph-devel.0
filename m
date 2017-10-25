From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Messenger V2: multiple bind support
Date: Wed, 25 Oct 2017 15:42:40 +0100
Message-ID: <add34139-4ed6-fcca-fdac-a05f58aff433@suse.de>
References: <1508855817.10018.25.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbdJYOmn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 10:42:43 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50000AAAD
        for <ceph-devel@vger.kernel.org>; Wed, 25 Oct 2017 14:42:42 +0000 (UTC)
In-Reply-To: <1508855817.10018.25.camel@suse.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 10/24/2017 03:36 PM, Ricardo Dias wrote:
> Hi list,
> 
> I was wondering if it makes sense to support multiple binds with a
> single messenger instance.
> 
> The use case I have in mind is when there are multiple public/cluster
> networks specified in ceph.conf and we want to listen for connections
> in one interface of each network. With the support for multiple binds,
> we could use a single messenger instance to listen to all interfaces.
> 
> Do you think it is worth to implement such support or is the above use
> case easily handled by having multiple messenger instances?

I would think multiple binds would make sense, but how would this affect 
setting the policies? Would we be sharing a single policy across 
multiple binds, or would we be allowed different policies for different 
binds?

Regardless, and not knowing the code, wouldn't this make sense for 
multiplexing multiple daemons on a single messenger? Making the 
messenger sort of a blackbox, that everyone could just use seamlessly 
without having to figure too many things out?

E.g., instead of multiplexing several osds on a messenger for the public 
network, and then the same set of osds on a messenger for the cluster 
network, we could simply have one messenger (bound to public and 
cluster) and have just that one messenger for all the osds.

Anyway, from an abstraction point-of-view it makes sense to me; no idea 
how feasible that would be though.

   -Joao
