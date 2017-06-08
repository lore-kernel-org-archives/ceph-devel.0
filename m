From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: How's "rados-level async replication" going?
Date: Thu, 8 Jun 2017 18:28:34 +0100
Message-ID: <7364b0b8-ac32-983a-4aa4-c1580f7872b2@suse.de>
References: <CAJACTuezGPsG-CZWwFCHGJmokcbqvG0W9jwmvR37MW8k3P8u=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751392AbdFHR2g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Jun 2017 13:28:36 -0400
In-Reply-To: <CAJACTuezGPsG-CZWwFCHGJmokcbqvG0W9jwmvR37MW8k3P8u=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>, ceph-devel@vger.kernel.org

On 06/08/2017 05:43 PM, Xuehan Xu wrote:
> Hi, everyone.
>
> Recently, in the ppt "Architecting block and object geo-replication
> solutions with ceph", I learned that there was a "rados-level async
> replication" mechanism under consideration. However, I can't find any
> development in this direction. Why? Is it abandoned?

There's at least a prospective effort by Ricardo Dias (cc'ed) and I in 
this direction. So far we've come up with a broad idea on how to 
approach the problem, but only intend to start looking a bit more 
seriously into this in mid-June.

I am not aware of other efforts.

   -Joao

