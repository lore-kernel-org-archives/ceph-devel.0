From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 19:28:48 +0200
Message-ID: <CA+H5UW2CGJ_FHc-GGFbox-yzEUe4B4=8ncB7GBtr2fSKAR6hDg@mail.gmail.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
 <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36522 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdFNR2u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 13:28:50 -0400
Received: by mail-qt0-f170.google.com with SMTP id u19so8099421qta.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:28:49 -0700 (PDT)
In-Reply-To: <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

This isn't a drop-in replacement for strlen(). It works differently
for strings with \0 buried somewhere in the middle.

Regards,
Radek

On Wed, Jun 14, 2017 at 7:16 PM, Michal Jarzabek <stiopa@gmail.com> wrote:
> You could also do :
>
> template< size_t N >
> constexpr size_t string_length(const char (&)[N] )
> {
>   return N-1;
> }
>
>
> On Wed, Jun 14, 2017 at 5:50 PM, Jesse Williamson <jwilliamson@suse.de> wrote:
>>
>>
>> Here's a C++11 version that might be useful to you (largely untested,
>> and I'm only on my first cup of coffee, so... ;>).
>>
>> -Jesse
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
