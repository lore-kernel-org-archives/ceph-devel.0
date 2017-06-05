From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: VLA detection ...
Date: Mon, 5 Jun 2017 14:25:31 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706051405131.14104@ancalagon.suse.de>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl> <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com> <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl> <alpine.DEB.2.11.1706041826470.3646@piezo.novalocal>
 <0cc648f1-6f35-9a4b-060a-704c19333ef6@digiware.nl> <alpine.LSU.2.21.1706051215130.14104@ancalagon.suse.de> <2f2fbedc-1916-8838-e7f0-2b1c62e65cd2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53781 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751188AbdFEVZh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 17:25:37 -0400
In-Reply-To: <2f2fbedc-1916-8838-e7f0-2b1c62e65cd2@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 5 Jun 2017, Willem Jan Withagen wrote:

Hi Willem,

Thank you for your comments!

> I think your remarks are all valid and referencing VLA could/should be
> done with some careful gards. On the otherhand the code is full with
> pointer, and not all constructs are 100% C++ type, and can also run out
> of bound. (As I've already noticed a few times)

We certainly need to be able to use "dangerous" constructs, and to be sure 
they're present for good reasons.

In my view, the problem isn't that VLAs exist, it's that're so easy to use 
by complete accident, and if ever mis-used can lead to some extremely 
subtle problems that in a bad case are difficult to reproduce and even 
harder to find.

> So care has to be taken when VLA are used, as with all constructs one
> selects to solve a problem.

Definitely agreed.

> The disadvantage with just switching on warnings is that they start to
> bloat. And as such start to create noise, masquerading/distracting from
> new real important warning. Because that is what is going to happen:
> People start just reading over them, and then some more.

I'm happy to provide patches, and resubmit the PR at some point soon. 
Completely agreed that warnings have to be useful, and if we ignore them 
then they might as well not be there.

> I, for one, disagree with that. It is not going to help the problem by
> switching the warnings on. The actual issue needs to be fixed, Kefu
> tried that, and declared his first attempt not really satisfactory.

I'll try to catch up with Kefu and see where the pain points were.

> So I think this is going to stay here until "the stds group", in its
> infinite wisdom has designed a solution for this that actually works.
> Until then, all bets are of.

I know that there are some relevant proposals, but AFAIK not super strong 
traction just yet.

As long as nothing's actually exploded, I suppose it's like pointing at a 
bunch of TNT and saying "hey, we probably shouldn't smoke near that", but 
nobody's happend to do it yet so it seems fine. ;-)

> Not to sound pedantic, but this is all part of this of code requirements
> that are sort underlying this project. But I have yet to see that people
> are being hit over the head with these rules. (Unlike in other projects
> where I work and we had regular audits to check confirmity to the code
> rules)

It's unclear to me what extensions we do and do not allow. If the project 
is in standard C++11, VLAs shouldn't be allowed because they're not part 
of the language. Then again, that sort of pedanticism may be of limited 
actual utility.

> Or be like me, I try to keep things FreeBSD compatible, and try to chase
> people using VLAs suggesting that they pick a different solution.

I'll try to see where we're using them now and get a sense of where they 
are specifically chosen and useful.

> Lets get back to programming.....

Always a good plan! :-)

-Jesse
