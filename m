From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: kraken
Date: Tue, 1 Nov 2016 17:20:08 +0000
Message-ID: <EAD3EBB1-A294-401A-8352-BCF19A3FBECC@Teradata.com>
References: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:38784 "EHLO
        rpc7279.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751568AbcKARUN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 13:20:13 -0400
In-Reply-To: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Content-Language: en-US
Content-ID: <8977033419A49C42B3157BA57ED2A61A@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I noticed current master is broken on SLES. I pushed a PR with a single line change for it. 
I would like Kraken to have this fix.

https://github.com/ceph/ceph/pull/11708


Thanks,
Nitin

> On Nov 1, 2016, at 6:20 AM, Sage Weil <sweil@redhat.com> wrote:
> 
> Hey everyone,
> 
> I think we're about ready for a kraken feature freeze.  The main item we 
> were waiting for was the EC overwrites and Sam has a working branch for 
> review this week.  There are still a few odds and ends that I have on my 
> list to get in (like the new CRUSH tunable), but it's a short list.
> 
> How does next Monday (11/7) sound for an initial freeze?
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

