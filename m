From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 15:46:59 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706141521010.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de> <20170614182841.GC12086@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1706141832010.3646@piezo.novalocal> <alpine.LSU.2.21.1706141139090.5364@ancalagon.suse.de> <alpine.DEB.2.11.1706141939190.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbdFNWrF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 18:47:05 -0400
In-Reply-To: <alpine.DEB.2.11.1706141939190.32269@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Sage Weil wrote:

> But nobody does that.  It's stuff like
>
> 	strlen("\r\nffffffffffffffff;chunk-signature=")
>
> which can just be
>
> 	sizeof("whatever") - 1
>
> and it is clear to the reader of the code that it isn't strlen and \0's in
> the string aren't relevant.

In that case, I agree, though it's worth considering that operator sizeof 
won't give us the right result when the argument is deduced as a pointer. 
That is:

const char *msg = "Hello, World!";
auto sz = sizeof(msg) - 1;

...sz != strlen(msg). We certainly have constants and macros in our code.

Consider also the innocuous-looking:

const char s[10] = {};

...where again sizeof(s) - 1 and strlen(s) differ.

Nothing about /having/ a compile-time strlen() function precludes someone 
from using sizeof(s) - 1 when we have an array, of course.

With respect to having character arrays in our code with multiple NULL 
characters, there are instances in in our own submodules, in our test 
code, and at least one case where Ceph code uses that technique at runtime 
to send split strings to Python-- so, I think that if it is put in a 
function and given a name, we don't want to claim it computes a string 
length if it is computing size - 1.

The proposed version from Adam with the runtime check should be okay if we 
want a checked version, or we can use another implementation.

> IOW I don't see why we would need a fully C-like constexpr strlen...

In this specific situation, I guess the use is to help solve Willem's 
problem. :-) In a general library where we're doing compile-time slicing 
and dicing, it would be pretty important.

Another idea is to wrap the compiler intrinsics, which will give us 
constexpr-ness across at least GCC and clang (and may be helpful in 
Willem's case). Something like this might work:

namespace ceph {
namespace util {

constexpr size_t strlen(const char *s)
{
#if __clang__
  return __builtin_strlen(s);
#else
  return std::strlen(s);
#endif
}

}} // namespace ceph::util

I hope this is useful-- it's always fun when "simple" things generate 
lively discussion!

-Jesse
