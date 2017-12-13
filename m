From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 11:56:02 -0600
Message-ID: <6e5bf1ee-14bc-8b12-9e8b-ba9304271853@gmail.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:45802 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdLMR4G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Dec 2017 12:56:06 -0500
Received: by mail-it0-f66.google.com with SMTP id z6so4897299iti.4
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 09:56:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 12/13/2017 10:34 AM, Sage Weil wrote:
> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
> ceph, and were talking about where to start...  One candidate was to carve
> off the entire messenger and reimplement using seastar futures/promises.
> 
> Another thought that is somewhat trivial but probably necessary and
> smallish is the log/ framework.  This might be a good test case for the
> legacy <-> seastar communications infrastructure.  It's all one-way, which
> simplifies things a bit, and the implementation should be pretty
> straightforward?
> 
> I know we can't rely on the current debug stuff for
> tracing/instrumentation, but I don't think teh need for a debug log is
> going to go away.
> 
> Another question is how the logger/perfcounters will need to change in a
> seastar world.

That's really exciting!  Josh and Greg mentioned in standup that we 
wouldn't use the seastar memory allocator at all.  Would it be 
difficult/counterproductive to carve out some memory that seastar could 
manage itself while using tcmalloc or whatever for the posix side?

It seems to me like seastar's desire override new/delete isn't really a 
good long term solution for anyone.

Regarding where to start:

I'd be really happy just to see seastar building properly in ceph and a 
reactor up and running doing *anything*.

> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
