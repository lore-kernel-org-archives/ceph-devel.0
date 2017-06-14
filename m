From: Sage Weil <sage@newdream.net>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 18:34:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706141832010.3646@piezo.novalocal>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de> <20170614182841.GC12086@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58243 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdFNSeE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 14:34:04 -0400
In-Reply-To: <20170614182841.GC12086@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Adam C. Emerson wrote:
> On 14/06/2017, Jesse Williamson wrote:
> > This will no longer be constexpr.
> 
> Alternatively we could just have it return n-1 in that case, though
> that risks letting things that we /expect/ to be C strings that won't
> interoperate with C sneak through.

It seems like that ambiguity would be explicitly communicated by using the 
originally proposed string_length() instead of a clever 
strlen()-lookalike.

Also... wouldn't sizeof("foo")-1 work just as well as string_length()?

sage
