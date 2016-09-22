From: Jean Delvare <jdelvare@suse.de>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 16:58:37 +0200
Message-ID: <20160922165837.1363860b@endymion>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
        <20160920001159.GM2356@ZenIV.linux.org.uk>
        <1474339566.1954.25.camel@perches.com>
        <alpine.DEB.2.10.1609200751110.3346@hadrien>
        <1474353123.1954.28.camel@perches.com>
        <20160922112407.47da9393@endymion>
        <1474540930.8253.9.camel@perches.com>
        <20160922135758.0399725d@endymion>
        <20160922131103.GW2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922131103.GW2356@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 22 Sep 2016 14:11:03 +0100, Al Viro wrote:
> On Thu, Sep 22, 2016 at 01:57:58PM +0200, Jean Delvare wrote:
> > > 
> > > MUST is much stronger language than I would prefer.
> > 
> > That's what error means, really. When your compiler fails with an
> > error, you have no choice but to fix your code. Warnings on the other
> > hand may be ignored sometimes.
> 
> And they are errors, because of...?

Because we decided they were important. Of course there is some
subjectivity to this decision, much like all gcc warnings could be
errors and some errors could be warnings. Which is why gcc allows
enabling/disabling individually.

I assume the current set of errors vs. warnings is the result of some
consensus amongst kernel developers. It can certainly be adjusted if
the consensus changes for whatever reason.

> > Sure. But I'm afraid you keep changing topics and I have no idea where
> > you are going. We started with "should there be a space before jump
> > labels", then out of nowhere we were discussing the wording of the
> > output of checkpatch (how is that related?) and now you pull statistics
> > out of your hat, like these numbers imply anything.
> > 
> > checkpatch was called checkPATCH for a reason. It's main intent was to
> > prevent NEW (coding-style mostly) errors from creeping into the kernel.
> > The fact that old code does now always follow these recommendations is
> > unfortunate but that doesn't make checkpatch wrong or bad.
> > 
> > ERROR means that the new code isn't allowed to do that. Period.
> 
> The main intent of checkpatch these days appears to be providing an easy
> way of thoughtless inflation of commit counts, everything else be damned.
> Make-work, in other words.

Yes, I've noticed the trend too :-( But that's a problem with the
people using the tool, mostly, not with the tool itself.

> The _only_ criterion for adding new checks should be a strong consensus in
> the core kernel.  IOW, it should be descriptive, not prescriptive.  "Some
> people do it this way, some - that" is not a valid reason for "let's make it
> uniform; that way is just better, so from now on it's a new requirement".
> Especially when the rationale behind the choice has all the intellectual
> rigour of feng shui.  Some of these checks are common-sense, some are
> absolutely arbitrary, there are far too many of them (...)

That I agree with, I've complained about the same before. But that
doesn't mean checkpatch is not a wonderfully useful tool. It really is,
if used properly.

> and elevating them
> to the level of compiler errors like you seem to do is rather dishonest.

I see. Well clearly this discussion isn't going anywhere so I'll go
back working on things that really matter. See you.

-- 
Jean Delvare
SUSE L3 Support
