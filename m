From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 11:21:49 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706141119410.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbdFNSVy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:21:54 -0400
In-Reply-To: <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Radoslaw Zarzynski wrote:

> May we put this somewhere under common/? Although the mentioned
> Clang build failure has been resolved this morning, I bet the constexpr-
> capable variant of strlen (ceph::strlen?) will be very useful in the future.
> Also, I would love to make a clean-up PR based on it.

I'd certainly like to see this, as well as a few other goodies for 
wrangling C (I have some ideas, and soon some code).

For folks who haven't seen Matt Godbolt's compiler explorer, this is a 
super useful tool for testing things like this, since you can see the 
assembly output from different compilers produced in a very handy way 
(warning: lots of fun, may be addictive!):
https://godbolt.org/

-Jesse
