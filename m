From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 20:14:59 +0200
Message-ID: <CA+H5UW10tDxJiADk+tqPpkBn_93vXc1xsz30p65wABwoFtfLfw@mail.gmail.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
 <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com> <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33823 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdFNSPB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 14:15:01 -0400
Received: by mail-qt0-f180.google.com with SMTP id c10so9806455qtd.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 11:15:00 -0700 (PDT)
In-Reply-To: <20170614175928.GA6666@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Michal Jarzabek <stiopa@gmail.com>, Jesse Williamson <jwilliamson@suse.de>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 7:59 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> #include <iostream>
> #include <cstdlib>
> #include <stdexcept>
>
> namespace _ {
> constexpr std::size_t string_length_(const char* s, std::size_t i,
>                                      std::size_t n) {
>   return i < n ? (*(s + i) == '\0' ? i : string_length_(s, i + 1, n))
>              : throw std::invalid_argument("Unterminated string constant.");
> }
> }
>
> template<std::size_t N>
> constexpr std::size_t string_length(const char(&s)[N]) {
>   return _::string_length_(s, 0, N);
> }
>
> constexpr const char s1[] = "cat";
> constexpr const char s2[] = "cat\0dog";
> constexpr const char s3[3] = { 'c', 'a', 't' };
> constexpr std::size_t n1 = string_length(s1);
> constexpr std::size_t n2 = string_length(s2);
>
> int main(void) {
>   std::cout << "string_length(s1): " << n1 << std::endl;
>   std::cout << "string_length(s2): " << n2 << std::endl;
>   try {
>     std::cout << "string_length(s3): " << string_length(s3) << std::endl;
>   } catch (const std::invalid_argument& e) {
>     std::cerr << "How exceptional! " << e.what() << std::endl;
>   }
> }

May we put this somewhere under common/? Although the mentioned
Clang build failure has been resolved this morning, I bet the constexpr-
capable variant of strlen (ceph::strlen?) will be very useful in the future.
Also, I would love to make a clean-up PR based on it.

Regards,
Radek
