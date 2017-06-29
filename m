From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Thu, 29 Jun 2017 17:32:26 -0400
Message-ID: <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
 <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
 <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38662 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdF2VcV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 29 Jun 2017 17:32:21 -0400
In-Reply-To: <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On 06/29/2017 05:18 PM, Sage Weil wrote:
> On Thu, 29 Jun 2017, Mohamad Gebai wrote:
>> Also, preloading libtcmalloc makes this behavior disappear (at least for
>> this program), which confirms further the hypothesis, since tcmalloc
>> does larger allocations internally.
> What do you mean by that last paragraph?  We should be linking against 
> tcmalloc in ceph.  But you see that using tcmalloc avoids the problem in 
> the reproducer?
>

Yes, that's exactly it. That's why I'm asking about the pattern usage,
so I can try to reproduce it in Ceph. I'll try fio as you suggested and
follow up. If you have any thoughts in the mean time, please let me know.

Mohamad

