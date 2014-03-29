From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: drop an unsafe assertion
Date: Sat, 29 Mar 2014 19:27:13 +0200
Message-ID: <CALFYKtBx_vKbi4NHbOxf=24+7HQO3DNqewAy7mY8nkrcUjQF=w@mail.gmail.com>
References: <1395867122-9340-1-git-send-email-elder@linaro.org>
	<alpine.DEB.2.00.1403281739030.22715@cobra.newdream.net>
	<53362600.1090904@linaro.org>
	<CALFYKtDDpbjGKpR-vPn=bRMUN1PLFXTAHEpPNrkDne+rUnPTVQ@mail.gmail.com>
	<alpine.DEB.2.00.1403290915440.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:52771 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaC2R1N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Mar 2014 13:27:13 -0400
Received: by mail-qg0-f41.google.com with SMTP id e89so1995908qgf.28
        for <ceph-devel@vger.kernel.org>; Sat, 29 Mar 2014 10:27:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1403290915440.22715@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@linaro.org>, Ceph Development <ceph-devel@vger.kernel.org>, ob@daevel.fr

On Sat, Mar 29, 2014 at 6:23 PM, Sage Weil <sage@inktank.com> wrote:
> On Sat, 29 Mar 2014, Ilya Dryomov wrote:
>> On Sat, Mar 29, 2014 at 3:46 AM, Alex Elder <elder@linaro.org> wrote:
>> > On 03/28/2014 07:41 PM, Sage Weil wrote:
>> >> Hi Alex, Ilya,
>> >>
>> >> I've added this and the previous patch to a for-linus branch to send to
>> >> Linux for 3.14.  The net of the two patches is simply removing the assert,
>> >> however... the first changes several lines that then get changed back.
>> >> Should we squash them?
>> >
>> > In my opinion, yes.  Ilya's movement of the assert within
>> > the spinlock was solving one problem, but ultimately that
>> > assertion should go away.
>>
>> Sage, the way you squashed it we lost Alex's authorship and ended up
>> with his Signed-off-by, my Reviewed-by and me as an Author.  Since you
>> haven't pulled it into kernel.org yet, I did
>>
>> git commit --amend --author='Alex Elder <elder@linaro.org>'
>>
>> on for-linus to restore justice ;)
>
> Thanks!  I'm noticing now that the commit description doesn't make much
> sense, though, since it is talking about the conditions after the first
> patch.. might just send the originals, unless Alex wants to rewrite it.

I don't see it that way.  The conditions it is talking about are true
even w/o the first patch, it's just the first patch made it a lot
easier to hit the bug.

Thanks,

                Ilya
