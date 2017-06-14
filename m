From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 14:23:30 -0400
Message-ID: <20170614182330.GB12086@ultraspiritum.eng.arb.redhat.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
 <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
 <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
 <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11611 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdFNSXc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:23:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1706141118120.5364@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 14/06/2017, Jesse Williamson wrote:
> This will no longer be constexpr.

That is true, but only in the case when it throws, and it's similar to the usage in...

http://en.cppreference.com/w/cpp/language/constexpr

>    // constexpr functions signal errors by throwing exceptions
>    // in C++11, they must do so from the conditional operator ?:
>    constexpr char operator[](std::size_t n) const
>    {
>        return n < sz? p[n] : throw std::out_of_range("");
>    }

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
