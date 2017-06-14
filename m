From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 13:59:28 -0400
Message-ID: <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
 <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbdFNR7b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 13:59:31 -0400
Content-Disposition: inline
In-Reply-To: <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Michal Jarzabek <stiopa@gmail.com>, Jesse Williamson <jwilliamson@suse.de>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 14/06/2017, Radoslaw Zarzynski wrote:
> This isn't a drop-in replacement for strlen(). It works differently
> for strings with \0 buried somewhere in the middle.

#include <iostream>
#include <cstdlib>
#include <stdexcept>

namespace _ {
constexpr std::size_t string_length_(const char* s, std::size_t i,
                                     std::size_t n) {
  return i < n ? (*(s + i) == '\0' ? i : string_length_(s, i + 1, n))
             : throw std::invalid_argument("Unterminated string constant.");
}
}

template<std::size_t N>
constexpr std::size_t string_length(const char(&s)[N]) {
  return _::string_length_(s, 0, N);
}

constexpr const char s1[] = "cat";
constexpr const char s2[] = "cat\0dog";
constexpr const char s3[3] = { 'c', 'a', 't' };
constexpr std::size_t n1 = string_length(s1);
constexpr std::size_t n2 = string_length(s2);

int main(void) {
  std::cout << "string_length(s1): " << n1 << std::endl;
  std::cout << "string_length(s2): " << n2 << std::endl;
  try {
    std::cout << "string_length(s3): " << string_length(s3) << std::endl;
  } catch (const std::invalid_argument& e) {
    std::cerr << "How exceptional! " << e.what() << std::endl;
  }
}
