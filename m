From: Wido den Hollander <wido@42on.com>
Subject: Re: kraken
Date: Tue, 1 Nov 2016 14:44:08 +0100 (CET)
Message-ID: <125721903.870.1478007848558@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:34552 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169195AbcKANoN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 09:44:13 -0400
In-Reply-To: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


> Op 1 november 2016 om 14:20 schreef Sage Weil <sweil@redhat.com>:
> 
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

Sounds good to me. I'd would like #11665 [0] to be reviewed, small change (1 line), but could have a big impact.

I would rather not change this in Luminous, but do it in the release before a LTS so everybody can get used to it. Still, not even sure this default behavior will change, depends on the community.

Wido

[0]: https://github.com/ceph/ceph/pull/11665

> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
