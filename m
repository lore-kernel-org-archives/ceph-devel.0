From: Sage Weil <sweil@redhat.com>
Subject: Re: Alibaba's work on async transaction
Date: Thu, 1 Jun 2017 21:42:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706012135210.3646@piezo.novalocal>
References: <C00F39E2-837F-4995-A7D8-1FD100C59E48@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdFAVnC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Jun 2017 17:43:02 -0400
In-Reply-To: <C00F39E2-837F-4995-A7D8-1FD100C59E48@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sheng Qiu <sheng.qiu@alibaba-inc.com>

Hi James,

On Fri, 2 Jun 2017, LIU, Fei wrote:
> Hi Sage, 
>    Here is the slides that I mentioned in morning conference call regarding to async transaction implementation in the backend blustore
> 
>   https://www.slideshare.net/jupiturliu/async-queuetransaction
> 
>   We will modify the PR accordingly with your advice last time.

This is the PR, right?

	https://github.com/ceph/ceph/pull/15141

I don't remember exactly what I said before :), but I think the more 
promising path forward is not to introduce a context switch but instead to 
find a way to drop PG::lock once the operation is serialized on the 
sequencer, or to have a second PG lock just for submitting the 
transaction.  E.g.,

  pg->submit_lock.Lock();
  pg->unlock();
  store->submit_transaction(...);
  pg->submit_lock.Unlock();

This will require a careful look at what is happening inside PG after 
PG::lock is dropped, though.  It probably makes sense to look at this in 
conjuction with something like

	https://github.com/ceph/ceph/pull/11188

which never got finished (and has now gone very stale)...

sage
