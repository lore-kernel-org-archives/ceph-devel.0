From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Fri, 16 Jun 2017 14:20:49 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706161420150.3182@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl> <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de> <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com> <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com> <20170614181932.GA12086@ultraspiritum.eng.arb.redhat.com>
 <6df88279-f533-ecec-8083-e5ff277d36df@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750792AbdFPVUz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Jun 2017 17:20:55 -0400
In-Reply-To: <6df88279-f533-ecec-8083-e5ff277d36df@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

On Fri, 16 Jun 2017, Willem Jan Withagen wrote:

> Let me resurrect this discussion once more:
> // specializations for char*/const char* use strlen()
> template <>
> struct string_traits<const char*> {
>  static constexpr size_t size(const char* s) { return std::strlen(s); }
> };

Not the most elegant of solutions, but see if this works for you:

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

...and make the above call to ceph::util::strlen().

-Jesse

