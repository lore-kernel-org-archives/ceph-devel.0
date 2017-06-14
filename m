From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 11:35:23 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706141130570.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de> <20170614182330.GB12086@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35597 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751644AbdFNSf2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:35:28 -0400
In-Reply-To: <20170614182330.GB12086@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Adam C. Emerson wrote:

> That is true, but only in the case when it throws, and it's similar to the usage in...

Right, and certainly an intentional feature. We may want to see what's 
provided by Boost. (Unfortunately, Hana requries C++14, but it provides 
things like folding, etc.)

The other issue (I have not tried this yet) is that I think we still have 
no nullptr checking, since that requires a runtime address-- so we'd still 
be in a bit of trouble just treating it like strlen().

-Jesse
