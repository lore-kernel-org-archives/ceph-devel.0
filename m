From: Sage Weil <sage@inktank.com>
Subject: Re: ObjectContext : check that all references are gone
Date: Mon, 15 Jul 2013 14:53:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307151452110.3857@cobra.newdream.net>
References: <51E44C97.8040902@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59581 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620Ab3GOVxa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jul 2013 17:53:30 -0400
In-Reply-To: <51E44C97.8040902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 15 Jul 2013, Loic Dachary wrote:
> Hi Sage,
> 
> You mentionned that there is code somewhere checking the fact that all references to an ObjectContext are gone and that replacing manual reference counting with shared_ptr should preserve this ( i.e. in relation to https://github.com/ceph/ceph/pull/414 "replace ObjectContext pointers with shared_ptr" ). However, I've not been able to find such code. Would you be so kind as to show me where it is ?
> 
> Cheers

It's in ReplicatedPG.cc:

void ReplicatedPG::on_flushed()
{
  assert(object_contexts.empty());
}

which is called from the Reset state of the PG peering state machine.

sage
