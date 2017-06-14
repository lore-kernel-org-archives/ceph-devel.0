From: Michal Jarzabek <stiopa@gmail.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 18:16:32 +0100
Message-ID: <CAEFDAA5Ge=68Xu1rerM6uG3aTQNdQXQtMfAfROXCf6x2C9h95w@mail.gmail.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de> <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35371 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbdFNRQe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 13:16:34 -0400
Received: by mail-it0-f44.google.com with SMTP id m62so4291394itc.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:16:33 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

You could also do :

template< size_t N >
constexpr size_t string_length(const char (&)[N] )
{
  return N-1;
}


On Wed, Jun 14, 2017 at 5:50 PM, Jesse Williamson <jwilliamson@suse.de> wrote:
>
>
> Here's a C++11 version that might be useful to you (largely untested,
> and I'm only on my first cup of coffee, so... ;>).
>
> -Jesse
