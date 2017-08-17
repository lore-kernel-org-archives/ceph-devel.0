From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: multi-line comments
Date: Thu, 17 Aug 2017 11:05:12 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1708171100570.15772@linux-psd4>
References: <CAJE9aOMyuw2dgnxRCbYwOB74C_ixMxT-f1DZB5HzyMXkeoL_2w@mail.gmail.com> <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753283AbdHQSFW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Aug 2017 14:05:22 -0400
In-Reply-To: <CAJ4mKGZ10RyY6HmDy3sf_5howHuhB=78meX_St0F5N+v75awrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, amitkuma@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Aug 2017, Gregory Farnum wrote:

> Similarly, do we have a rule or guidance about contractions anywhere?

I vote to not ban them with a rule. I agree that it's got an element of 
personal preference involved, and accordingly folks should be allowed to 
choose what they feel makes the most sense to them.

I disagree with Nitin that it has much to do with modern C++: both styles 
are used freely. For example, have a peek at Boost or your favorite 
standard library implementation.

-Jesse
