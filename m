From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 03/47] block-rbd: Adjust the position of a jump label in
 rbd_header_from_disk()
Date: Mon, 19 Sep 2016 11:37:24 +0200
Message-ID: <20160919113724.07fc3752@endymion>
References: <566ABCD9.1060404@users.sourceforge.net>
        <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
        <71b06567-1ea9-204d-d61b-2af4426d9cd1@users.sourceforge.net>
        <CAOi1vP9iQ6u7dm0dRMg4rs6tLaR5mv55yew0URTX00-y6C0S6g@mail.gmail.com>
        <121f05b0-ac94-4d81-289e-9dc3668eab95@users.sourceforge.net>
        <CAOi1vP_XDRj9B-vAYVB=qN5Z-vbq75tYU1dFADRBz6P+J6V56Q@mail.gmail.com>
        <20160913163626.436629af@endymion>
        <CAOi1vP_JCEJoH8WBHtjBufU_C1dH-JaRPJkywRFFJSh8Q6mwdQ@mail.gmail.com>
        <20160913185054.42c568a2@endymion>
        <CAOi1vP8uL32MR0hMW6-=P2=R7q5HD4GoSoZk3pXQvnN+C7xNew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP8uL32MR0hMW6-=P2=R7q5HD4GoSoZk3pXQvnN+C7xNew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>
List-Id: ceph-devel.vger.kernel.org

Hi Ilya,

Sorry for the late answer.

On Tue, 13 Sep 2016 20:31:57 +0200, Ilya Dryomov wrote:
> Sorry, navigating lkml.org archive is a pain, and I was expecting to
> see patch.  Your points
> 
> "The acceptance of an optional single space before labels dates back to
> at least June 2007, as supported by the very first incarnation of
> checkpatch.pl. So nothing really new here, except for a preference
> (my preference, admittedly, but I'm know I'm not alone) being expressed
> in the coding style document."
> 
> "Recommendations are not meant to document what people are currently
> doing but what we think they should be doing."
> 
> are valid, but note that there is a world of difference between an
> acceptance and a preference.  The *only* point of whitespace guidelines
> is to keep the code base consistent.

Consistency is half of the reason, the other half is readability. This
is why the CodingStyle document has a number of rationales explained.
This is also why we put whitespace in the first place, while the C
language doesn't require any ;-)

The sense of my proposal was to address a readability (or usability)
issue.

> You don't go changing whitespace
> preferences in such a huge project, not unless you have a *very* good
> rationale and existing code base is swayed (which it isn't, given the
> 9/10 ratio).

I did consider the reason to be good enough to warrant a "change",
actually. Or more exactly from "one space is allowed" to "one space is
recommended." Which is quite different from changing all the code
actively. I can understand how you don't like it, but again, this
"inconsistency" has been accepted for almost a decade now, so I find it
strange to see so much resistance when someone finally tries to sort it
out.

> >> If I wanted to clarify the
> >> situation, I'd have gone with "one space indented labels are also
> >> acceptable" or so.  The example you've re-indented dates back to 2.6.4
> >> times...
> >
> > I can't see how this is relevant.
> 
> That was a 12 year old example, codifying an existing style used in
> ~90% cases, serving as a guideline for new contributors.

OK, I get your point now. But the CodingStyle document isn't carved
into stone. I see 43 changes to that file in recent history (since
April 2005), some of which are actual changes or clarifications of our
coding style. This very section of the document was updated in December
2014, so not so long ago.

In the end I suppose it boils down to how problematic you consider the
current situation to be. Apparently you and several other maintainers
think it's just fine, while me (and a few others apparently) think it
is not.

> >> git diff also works on regular files, BTW.
> >
> > I have no idea what you mean here, sorry.
> 
> Oh, just that it works outside of git repos too, so you aren't stuck
> with diffutils if you want to diff two random .c files.

Oh, I had never thought of that. Thanks for the hint :-)

> > (...)
> > http://marc.info/?l=linux-kernel&m=147325166209844&w=2
> >
> > It uses the git diff xfuncname feature you mentioned above. To be
> > honest I'm surprised it isn't the git default, it seems odd to have so
> > many diff drivers included in git and not enable them on obvious file
> > extensions. Oh well.
> 
> This came up before: http://www.spinics.net/lists/git/msg164216.html,
> Linus didn't like it.  I suggest you add him to the CC on this patch to
> see if he changed his mind.

Thanks for the pointer. It is interesting to see many people had been
bothered by the same problem for many years and even proposed solution
for it. But also sad to see that nothing happened :-(

Well Linus suggested to improve the default, he was not opposed to the
change per se I think. But it was 5 years ago and nothing happened
since then, so I'd rather go with what is available today. Which means
either one space before labels, or drivers in .gitattributes. Choose
your poison ;-)

Thanks,
-- 
Jean Delvare
SUSE L3 Support
