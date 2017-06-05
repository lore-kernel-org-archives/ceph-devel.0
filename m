From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: VLA detection ...
Date: Mon, 5 Jun 2017 13:02:34 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706051215130.14104@ancalagon.suse.de>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl> <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com> <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl> <alpine.DEB.2.11.1706041826470.3646@piezo.novalocal>
 <0cc648f1-6f35-9a4b-060a-704c19333ef6@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46899 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751178AbdFEUCk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 16:02:40 -0400
In-Reply-To: <0cc648f1-6f35-9a4b-060a-704c19333ef6@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 4 Jun 2017, Willem Jan Withagen wrote:

Hi,

>>> And next the major complaint I find about it, is that these structures
>>> are build on the stack, which might cause stackoverlows (and that mostly
>>> on embedded computers) That would be something for programmers to be
>>> aware of.

There are a few potential issues to consider. I'll highlight a couple of 
them.

I think it's definitely important to mention that VLAs are certainly 
useful, and there are cases where they can be important for performance 
reasons. This is why I suggest -Wvla rather than -Wvla-error (though I'm 
okay with that, too, and disabling on a case-by-case basis).

The main issue with VLAs: they're really, really easy to write.

While this is in part a feature, it also means that programmers can use 
this feature entirely inadvertently. Seeing this happen "in the wild" is 
actually why I'm suggesting adding -Wvla: they can be useful, but I think 
the potential issues they can cause, and resultant effort debugging, make 
them worth warning about since they're so easy to invoke by accident.

VLAs allow unbounded and entirely unchecked allocation on the stack. There 
is no way to detect overflow or any other error. If the allocation exceeds 
the available stack space, the call stack is straight-up clobbered, which 
is not very easy to debug when it's the third item in a 30 layer deep call 
stack that's spoiling the fun. Note that some platforms start the stack at 
the end of the address space and count backwards.

Maybe a miscalculated VLA will crash. But if you're having a bad Monday, 
that won't happen: the program might keep ticking along for hours, with 
random parts of memory silently corrupted. (Note: alloca() does not save 
you from this.) There's no way to detect this error.

And, this can also go in the other direction-- consider what happens here:
 	int foo[bar] = { 1, 2, 3, 4, 5, 6 };
...great, unless bar is < 6... but you won't know until things go wrong.

Finally, note that sizeof(my_vla) is a /runtime/ calculation.

Anyway, as I said, I'm not suggesting we outright ban them, but I think a 
warning is a good idea because I've seen people write these completely 
accidentally. There's a lot of current effort in the committee to provide 
a feature like this, but to my knowledge it's not yet settled-- other than 
general agreement that the C approach doesn't work so well in C++.[1]

Naturally, we're used to courting some danger since we're using C family 
languages, but I hope I've helped to at least raise awareness as to why it 
may be a good idea to warn when this non-standard feature is used.

* Some more background on VLAs and C++:
         http://www.stroustrup.com/examples_short.pdf

 	There have been some proposals to add features like this, but no takers
 	yet. There are others, but for example (and some discussion):
 	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3497.html
 	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3810.pdf

>> Yep, my bad for assuming the cleanup was already done (or trivial)!

My bad for not submitting patches along with adding -Wvla, and not 
flagging the PR "RFC", which is what I should have done. Sorry for the 
trouble.

-Jesse

1. This is a discussion that seems to generate some heat:
"https://groups.google.com/forum/#!searchin/comp.std.c$2B$2B/vlas|sort:relevance/comp.std.c++/K_4lgA1JYeg/2qRcUvmGhBEJ"
