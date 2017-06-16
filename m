From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Clang does not like constexpression
Date: Fri, 16 Jun 2017 22:24:11 +0200
Message-ID: <6df88279-f533-ecec-8083-e5ff277d36df@digiware.nl>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
 <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
 <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
 <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
 <20170614181932.GA12086@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65351 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdFPUYT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Jun 2017 16:24:19 -0400
In-Reply-To: <20170614181932.GA12086@ultraspiritum.eng.arb.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Jesse Williamson <jwilliamson@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

On 14-6-2017 20:19, Adam C. Emerson wrote:
> On 14/06/2017, Radoslaw Zarzynski wrote:
>> May we put this somewhere under common/? Although the mentioned
>> Clang build failure has been resolved this morning, I bet the constexpr-
>> capable variant of strlen (ceph::strlen?) will be very useful in the future.
>> Also, I would love to make a clean-up PR based on it.
> 
> Feel free! I didn't know if it would be better if Casey stuck it in his
> string-reserve-join PR, since he has a similar string_length overload,
> or I can make a PR for it later.
> 

Let me resurrect this discussion once more:
// specializations for char*/const char* use strlen()
template <>
struct string_traits<const char*> {
  static constexpr size_t size(const char* s) { return std::strlen(s); }
};

generates:
In file included from
/home/jenkins/workspace/ceph-master/src/test/rgw/test_rgw_string.cc:16:
/home/jenkins/workspace/ceph-master/src/rgw/rgw_string.h:140:27: error:
constexpr function never produces a constant expression
[-Winvalid-constexpr]
  static constexpr size_t size(const char* s) { return std::strlen(s); }
                          ^

--WjW
