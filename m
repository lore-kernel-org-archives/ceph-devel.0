From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 14:19:32 -0400
Message-ID: <20170614181932.GA12086@ultraspiritum.eng.arb.redhat.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
 <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
 <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
 <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbdFNSTe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:19:34 -0400
Content-Disposition: inline
In-Reply-To: <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Michal Jarzabek <stiopa@gmail.com>, Jesse Williamson <jwilliamson@suse.de>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 14/06/2017, Radoslaw Zarzynski wrote:
> May we put this somewhere under common/? Although the mentioned
> Clang build failure has been resolved this morning, I bet the constexpr-
> capable variant of strlen (ceph::strlen?) will be very useful in the future.
> Also, I would love to make a clean-up PR based on it.

Feel free! I didn't know if it would be better if Casey stuck it in his
string-reserve-join PR, since he has a similar string_length overload,
or I can make a PR for it later.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
