From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 03/47] block-rbd: Adjust the position of a jump label in
 rbd_header_from_disk()
Date: Tue, 13 Sep 2016 18:50:54 +0200
Message-ID: <20160913185054.42c568a2@endymion>
References: <566ABCD9.1060404@users.sourceforge.net>
        <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
        <71b06567-1ea9-204d-d61b-2af4426d9cd1@users.sourceforge.net>
        <CAOi1vP9iQ6u7dm0dRMg4rs6tLaR5mv55yew0URTX00-y6C0S6g@mail.gmail.com>
        <121f05b0-ac94-4d81-289e-9dc3668eab95@users.sourceforge.net>
        <CAOi1vP_XDRj9B-vAYVB=qN5Z-vbq75tYU1dFADRBz6P+J6V56Q@mail.gmail.com>
        <20160913163626.436629af@endymion>
        <CAOi1vP_JCEJoH8WBHtjBufU_C1dH-JaRPJkywRFFJSh8Q6mwdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_JCEJoH8WBHtjBufU_C1dH-JaRPJkywRFFJSh8Q6mwdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 13 Sep 2016 17:30:33 +0200, Ilya Dryomov wrote:
> On Tue, Sep 13, 2016 at 4:36 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Tue, 13 Sep 2016 11:16:13 +0200, Ilya Dryomov wrote:
> >> Jon, could you please yank 865a1caa4b6b ("CodingStyle: Clarify and
> >> complete chapter 7") from your linux-next branch or at least change "It
> >> is advised to indent labels" to something less stronger?  It hasn't
> >> even hit mainline yet and we are already getting spammed.
> >
> > The problem isn't the documentation update nor whether you or me like a
> > space before labels or not. The problem is Markus Elfring. The guy just
> > spend his time flooding maintainers with unneeded changes they never
> > asked for. Ignore him and you'll be much better. If he was not flooding
> > you with this, he would find something else :-(
> >
> > When I wrote "It is advised to indent labels with one space", I never
> > meant that all the existing code should be converted that way. I
> 
> Hi Jean,
> 
> That much is clear, however ...
> 
> > expressed a preference, and provided a rationale for this preference.
> > After that, an advice is just that: an advice.
> >
> >> Looks like 9 out of 10 labels are not indented
> >>
> >> $ git grep '^[a-z0-9]\+:' -- *.c | wc -l
> >> 27945
> >> $ git grep '^ [a-z0-9]\+:' -- *.c | wc -l
> >> 2925
> >
> > Your regexps are wrong ;-) but the ratio is correct.
> 
> ... one of the main points of any coding style is consistency.  When
> someone new wanting to submit say a new driver opens CodingStyle and
> sees "It is advised to indent labels ...", they might start indenting
> labels in their code and advise others to do the same.  Given the 9/10
> existing ratio, that advice is wrong.

Or you could read the thread I pointed you to, where I explain why this
reasoning is wrong.

> If I wanted to clarify the
> situation, I'd have gone with "one space indented labels are also
> acceptable" or so.  The example you've re-indented dates back to 2.6.4
> times...

I can't see how this is relevant.

> >> so I'd say that's a bad advise as far as consistency goes, and the
> >> "diff -p" argument is pretty moot nowadays.
> >
> > It wasn't moot when I sent the documentation update patch. Or why would
> > you think it was? "git diff", by default, behaves exactly the same as
> > "diff -p" with regards to unindented labels (i.e. it doesn't handle
> > them properly.)
> 
> The git diff xfuncname incantation is a few years old now.

It doesn't help if a majority of developers don't know about it (as was
my case until last week), and the project itself doesn't carry the
required configuration bits to make it work out of the box (which
hopefully will be the case soon, see below.)

> git diff also works on regular files, BTW.

I have no idea what you mean here, sorry.

> > However, since then the issue was discussed somewhere else:
> > https://lkml.org/lkml/2016/9/5/214
> >
> > As you can see, alternatives to indenting labels with one space were
> > found. Therefore you will soon be correct saying "the diff -p argument
> > is pretty moot." As soon as my patch hits mainline, actually. Which
> > shouldn't take too long as Andrew Morton picked it 4 days ago.
> >
> > Once this happens, I'm fine with CodingStyle being updated again to
> > reflect the current situation.
> 
> I'm not sure which patch you are talking about - the message you linked
> is not a patch and it's impossible to follow large threads on lkml.org.

The solution was in this thread, which I expected you to read. The
patch proper was sent separately:

http://marc.info/?l=linux-kernel&m=147325166209844&w=2

It uses the git diff xfuncname feature you mentioned above. To be
honest I'm surprised it isn't the git default, it seems odd to have so
many diff drivers included in git and not enable them on obvious file
extensions. Oh well.

-- 
Jean Delvare
SUSE L3 Support
