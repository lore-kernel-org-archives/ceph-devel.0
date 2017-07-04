From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Tue, 4 Jul 2017 05:52:48 -0400
Message-ID: <d058e3ee-256d-5acb-3392-6bb095a6ab73@suse.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
 <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
 <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
 <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
 <72854a7f-2441-b940-c10f-b71cb65600d6@mirantis.com>
 <214435da-9714-7929-00a0-3e9235c6d833@suse.com>
 <e248a9c3-052a-cd77-1c77-cb0ec3e812ee@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43666 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdGDJwy (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 4 Jul 2017 05:52:54 -0400
In-Reply-To: <e248a9c3-052a-cd77-1c77-cb0ec3e812ee@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On 06/30/2017 10:55 AM, Igor Fedotov wrote:
>
> But AFAIR the scenario was pretty trivial - build Ceph with ALLOCATOR
> configured to tcmalloc and run an UT with the diff from the ticket.
>

But the unit tests aren't linked against libtcmalloc.so, and therefore
aren't using tcmalloc, right? Do I have to set LD_PRELOAD to force ctest
to use tcmalloc? If I do set LD_PRELOAD, I don't see the memory problem
anymore.

Mohamad

