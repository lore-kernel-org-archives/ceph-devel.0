From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 4.6-rc1
Date: Sat, 26 Mar 2016 22:46:44 +0100
Message-ID: <CAOi1vP-=j49SgV3cSGq2z4LijkcaD13nT98PynXL2Y8MRy0puw@mail.gmail.com>
References: <alpine.DEB.2.11.1603252132500.29038@cpach.fuggernut.com>
	<CA+55aFyXACVwL6inthTv=Orvp_6wDaA1c_BLvwJTYBORQTXa+w@mail.gmail.com>
	<CAOi1vP_6RX8ZxZNfU2__FkfcOcgT49spHjWn8aGTOArRRNXpew@mail.gmail.com>
	<CA+55aFyrep8hMApzYA4DyFgEoHc8o8KATTV=Jqf6-FgtLsqFOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36513 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbcCZVqq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Mar 2016 17:46:46 -0400
In-Reply-To: <CA+55aFyrep8hMApzYA4DyFgEoHc8o8KATTV=Jqf6-FgtLsqFOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sage@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Mar 26, 2016 at 10:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Mar 26, 2016 at 2:19 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> This really is a result of a miscommunication between us and Al.
>> Lesson learned.  Please reconsider and pull.
>
> No.
>
> If you guys rebase, I don't pull.
>
> Stop rebasing. Really.
>
> STOP REBASING.
>
> There are no excuses. Just stop doing it. I'll handle the merge
> issues. If there are complicated merge problems that you really worry
> about, what you can do is
>
>  (a) make a test-merge just to check
>
>  (b) do NOT send me that test-merge
>
>  (c) as part of the pull request, tell me that "there's a conflict
> because xyz, and this is how we think it should be handled".
>
> Because I'm really getting f*cking tired of having to get rebased
> trees that don't match -next for no good reason every single merge
> window.

FWIW, it matches -next content-wise.  SHAs don't match because of an
extra Signed-off-by in an unrelated commit, outside of fs/ceph.

>
> So I'm done with it.
>
> Let me repeat that one more time:
>
>      If you rebase during the merge window without having a damn good
> reason, don't expect me to pull the end result.

Mea culpa, my fault.

Thanks,

                Ilya
