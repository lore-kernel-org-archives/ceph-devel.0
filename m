From: John Spray <jspray@redhat.com>
Subject: Re: reStructuredText vs. AsciiDoc
Date: Wed, 21 Sep 2016 14:00:43 +0100
Message-ID: <CALe9h7cPsco20LgLoRkONf1nztWiLMmGQjxn9VDE5aBTAnghNw@mail.gmail.com>
References: <CALe9h7ewfBg0Q5fUV7zknDEy4pMpwNP9DQ-EYLm53tLmuRnbvw@mail.gmail.com>
 <CALqRxCwMyRKJnwhOUgOaL1hzwvgNqs1bSAJfoMGF2wFO=QNx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35587 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933101AbcIUNBE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 09:01:04 -0400
Received: by mail-qk0-f169.google.com with SMTP id t7so44266809qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 06:01:03 -0700 (PDT)
In-Reply-To: <CALqRxCwMyRKJnwhOUgOaL1hzwvgNqs1bSAJfoMGF2wFO=QNx+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 1:43 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Tue, Sep 20, 2016 at 5:25 AM, John Spray <jspray@redhat.com> wrote:
>> So does anyone have any strong attachment to the restructuredtext
>> format currently in use?
>
> No strong attachment here. Though, we would need a replacement for
> https://github.com/michaeljones/breathe , I guess?

Good point.

In general the generated API documentation is going to have different
contributors and consumers than our main user manuals, so I'm not sure
how tightly integrated they really need to be.  Building one
integrated document is neat, but I'm not sure how essential it is?

John

>
> - Ken
