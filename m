From: David Disseldorp <ddiss@suse.de>
Subject: Re: Samba Ceph dbwrap backend
Date: Tue, 13 Feb 2018 14:43:29 +0100
Message-ID: <20180213144329.19a94a4e@suse.de>
References: <20180213022540.5f9686b7@suse.de>
        <CALe9h7dPuDOtY06RPXJ2u5wkT=j8S6D1PkwgfByuQ8y3cuP9Fg@mail.gmail.com>
        <20180213132941.0208a8b2@suse.de>
        <20180213124838.y2jmrppzpjgsdagb@sernet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964792AbeBMNnc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:43:32 -0500
In-Reply-To: <20180213124838.y2jmrppzpjgsdagb@sernet.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Volker Lendecke <Volker.Lendecke@SerNet.DE>
Cc: ceph-devel@vger.kernel.org, Samba Technical <samba-technical@lists.samba.org>

On Tue, 13 Feb 2018 13:48:38 +0100, Volker Lendecke wrote:

> > Interesting. The same should be possible for Samba when we eventually
> > have a Ceph key-value store backend for Samba's dbwrap, and then use
> > Registry configuration.  
> 
> Is there API docs around for this key-value store?

There are a few different possible approaches to take, the simplest
would probably be to use Ceph omap directly, which is documented at:
http://docs.ceph.com/docs/master/rados/api/librados/

Locking and transactions would need to be layered atop this, possibly via
a separate Samba Object Class[1] running on the Ceph OSDs.

All theoretical at this stage unfortunately, but I hope to get some time
to work on it in the future.

Cheers, David

[1] Ceph Object Classes (slide 28)
https://www.slideshare.net/sageweil1/20150311-vault15-librados
