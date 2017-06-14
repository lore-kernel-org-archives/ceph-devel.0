From: Sage Weil <sage@newdream.net>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 19:43:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706141939190.32269@piezo.novalocal>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de> <20170614182841.GC12086@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1706141832010.3646@piezo.novalocal> <alpine.LSU.2.21.1706141139090.5364@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59409 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdFNTnH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 15:43:07 -0400
In-Reply-To: <alpine.LSU.2.21.1706141139090.5364@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Jesse Williamson wrote:
> > Also... wouldn't sizeof("foo")-1 work just as well as string_length()?
> 
> constexpr char *s[] = { 'f', 'o', 'o', '\0', '\0' };
> 
> ...seems like it would still be a problem using sizeof(). (But, runtime
> strlen() and a constexpr string_length() would still return the same
> result.)

But nobody does that.  It's stuff like

	strlen("\r\nffffffffffffffff;chunk-signature=")

which can just be

	sizeof("whatever") - 1

and it is clear to the reader of the code that it isn't strlen and \0's in 
the string aren't relevant.

IOW I don't see why we would need a fully C-like constexpr strlen...

sage
