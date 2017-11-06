From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Does anything still use the separate ceph-qa-suite repo?
Date: Mon, 6 Nov 2017 19:55:53 +0100
Message-ID: <CAOi1vP_tcDsDg3x9pRoKNku7Vq-6UDP0ZX=WswdT7M=f_xH-+Q@mail.gmail.com>
References: <CALe9h7c+dYCK4uX4gEoEvRmWY=gjMe+gVx7KtSiwhCDKeiSHLw@mail.gmail.com>
 <alpine.DEB.2.11.1711020236590.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:48595 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbdKFSzy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 13:55:54 -0500
Received: by mail-it0-f41.google.com with SMTP id c3so6607558itc.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 10:55:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711020236590.2819@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Nov 2, 2017 at 3:37 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 1 Nov 2017, John Spray wrote:
>> I think all the old stable branches got their own merge into the
>> ceph.git qa/ directory, so is there anything out there that would
>> still want the separate repo at https://github.com/ceph/ceph-qa-suite
>> ?
>>
>> If not, it seems like it's been long enough to just go ahead and
>> remove this entirely now?  The value of keeping it around for
>> archaeology is probably less than the cost of it occasionally
>> confusing folks.
>
> +1

I found myself engaged in said archaeology today and remembered about
this email.  Removing ceph-qa-suite repo would break a lot of links in
the tracker, eliminate (however occasional) PR discussions, etc.

Does it really cause that much confusion?  If "DEPRECATED; see
ceph.git/qa" in the title isn't enough, perhaps add it to README as
well instead?

Thanks,

                Ilya
