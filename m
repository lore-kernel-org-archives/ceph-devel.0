From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 11:40:58 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706141139090.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de> <20170614182841.GC12086@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1706141832010.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35887 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751628AbdFNSlE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:41:04 -0400
In-Reply-To: <alpine.DEB.2.11.1706141832010.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Sage Weil wrote:

> It seems like that ambiguity would be explicitly communicated by using the
> originally proposed string_length() instead of a clever
> strlen()-lookalike.

Right, since we aren't talking about general handling of compile-time 
arrays.

size_t constexpr string_length(const char *s)
{
  return 0 == *s ? 0 : 1 + string_length(1 + s);
}

...won't compile if you try something like:

constexpr auto l = string_length(nullptr);

> Also... wouldn't sizeof("foo")-1 work just as well as string_length()?

constexpr char *s[] = { 'f', 'o', 'o', '\0', '\0' };

...seems like it would still be a problem using sizeof(). (But, runtime
strlen() and a constexpr string_length() would still return the same
result.)

-Jesse
