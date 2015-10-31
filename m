From: Sage Weil <sage@newdream.net>
Subject: Re: why we use two ObjectStore::Transaction in
 ReplicatedBackend::submit_transaction?
Date: Sat, 31 Oct 2015 06:18:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57516 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbbJaNSl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 09:18:41 -0400
In-Reply-To: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 31 Oct 2015, ??? wrote:
> hi, all:
> 
>     There are two ObjectStore::Transaction in
> ReplicatedBackend::submit_transaction, one is op_t and the other one
> is local_t. Is that something
>     critilal logic we should consider?
> 
>     If we could reuse variable op_t it would be great. Because it is
> expensive to calling local_t.append(*op_t).
> 
>     There are similar logic in ReplicatedBackend::sub_op_modify_impl.

The local_t items are only applied locally; the op_t items are encoded and 
sent over the wire to the replicas.

If append() is expensive we should just refactor to avoid that.  IIRC I 
got partway down this path but apparently didn't finish.  The ObjectStore 
interface takes a list of transactions to apply, so I think it's just a 
matter of refactoring the interfaces a bit...?

sage

