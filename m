From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: VLA detection ...
Date: Mon, 5 Jun 2017 23:03:57 +0200
Message-ID: <2f2fbedc-1916-8838-e7f0-2b1c62e65cd2@digiware.nl>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl>
 <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com>
 <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl>
 <alpine.DEB.2.11.1706041826470.3646@piezo.novalocal>
 <0cc648f1-6f35-9a4b-060a-704c19333ef6@digiware.nl>
 <alpine.LSU.2.21.1706051215130.14104@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:27180 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdFEVEG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 17:04:06 -0400
In-Reply-To: <alpine.LSU.2.21.1706051215130.14104@ancalagon.suse.de>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Sage Weil <sage@newdream.net>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/06/2017 22:02, Jesse Williamson wrote:
> On Sun, 4 Jun 2017, Willem Jan Withagen wrote:
> 
> Hi,
> 
>>>> And next the major complaint I find about it, is that these structures
>>>> are build on the stack, which might cause stackoverlows (and that
>>>> mostly
>>>> on embedded computers) That would be something for programmers to be
>>>> aware of.
> 
> There are a few potential issues to consider. I'll highlight a couple of
> them.
> 
> I think it's definitely important to mention that VLAs are certainly
> useful, and there are cases where they can be important for performance
> reasons. This is why I suggest -Wvla rather than -Wvla-error (though I'm
> okay with that, too, and disabling on a case-by-case basis).
> 
> The main issue with VLAs: they're really, really easy to write.
> 
> While this is in part a feature, it also means that programmers can use
> this feature entirely inadvertently. Seeing this happen "in the wild" is
> actually why I'm suggesting adding -Wvla: they can be useful, but I
> think the potential issues they can cause, and resultant effort
> debugging, make them worth warning about since they're so easy to invoke
> by accident.
> 
> VLAs allow unbounded and entirely unchecked allocation on the stack.
> There is no way to detect overflow or any other error. If the allocation
> exceeds the available stack space, the call stack is straight-up
> clobbered, which is not very easy to debug when it's the third item in a
> 30 layer deep call stack that's spoiling the fun. Note that some
> platforms start the stack at the end of the address space and count
> backwards.
> 
> Maybe a miscalculated VLA will crash. But if you're having a bad Monday,
> that won't happen: the program might keep ticking along for hours, with
> random parts of memory silently corrupted. (Note: alloca() does not save
> you from this.) There's no way to detect this error.
> 
> And, this can also go in the other direction-- consider what happens here:
>     int foo[bar] = { 1, 2, 3, 4, 5, 6 };
> ...great, unless bar is < 6... but you won't know until things go wrong.
> 
> Finally, note that sizeof(my_vla) is a /runtime/ calculation.

Excuse me for sounding like an old fart, but I've been programming way
too long already. Yes I do like programming in Pascal and Ada, fully
structured and you cannot even get going without putting your seatbelts
on first.

I think your remarks are all valid and referencing VLA could/should be
done with some careful gards. On the otherhand the code is full with
pointer, and not all constructs are 100% C++ type, and can also run out
of bound. (As I've already noticed a few times)

So care has to be taken when VLA are used, as with all constructs one
selects to solve a problem.

> Anyway, as I said, I'm not suggesting we outright ban them, but I think
> a warning is a good idea because I've seen people write these completely
> accidentally. There's a lot of current effort in the committee to
> provide a feature like this, but to my knowledge it's not yet settled--
> other than general agreement that the C approach doesn't work so well in
> C++.[1]

The disadvantage with just switching on warnings is that they start to
bloat. And as such start to create noise, masquerading/distracting from
new real important warning. Because that is what is going to happen:
People start just reading over them, and then some more.

> Naturally, we're used to courting some danger since we're using C family
> languages, but I hope I've helped to at least raise awareness as to why
> it may be a good idea to warn when this non-standard feature is used.

I, for one, disagree with that. It is not going to help the problem by
switching the warnings on. The actual issue needs to be fixed, Kefu
tried that, and declared his first attempt not really satisfactory.

So I think this is going to stay here until "the stds group", in its
infinite wisdom has designed a solution for this that actually works.
Until then, all bets are of.

> * Some more background on VLAs and C++:
>         http://www.stroustrup.com/examples_short.pdf
> 
>     There have been some proposals to add features like this, but no takers
>     yet. There are others, but for example (and some discussion):
>     http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3497.html
>     http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3810.pdf

Not to sound pedantic, but this is all part of this of code requirements
that are sort underlying this project. But I have yet to see that people
are being hit over the head with these rules. (Unlike in other projects
where I work and we had regular audits to check confirmity to the code
rules)

>>> Yep, my bad for assuming the cleanup was already done (or trivial)!
> 
> My bad for not submitting patches along with adding -Wvla, and not
> flagging the PR "RFC", which is what I should have done. Sorry for the
> trouble.

No harm there, it is of for the time being. And if you feel really
strong about this, feel free to run this on your private repo and start
fixing the VLAs. I think everybody will welcome you submissions.
Or be like me, I try to keep things FreeBSD compatible, and try to chase
people using VLAs suggesting that they pick a different solution.

Lets get back to programming.....

--WjW

> -Jesse
> 
> 1. This is a discussion that seems to generate some heat:
> "https://groups.google.com/forum/#!searchin/comp.std.c$2B$2B/vlas|sort:relevance/comp.std.c++/K_4lgA1JYeg/2qRcUvmGhBEJ"
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

