From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 14:11:03 +0100
Message-ID: <20160922131103.GW2356@ZenIV.linux.org.uk>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
 <20160920001159.GM2356@ZenIV.linux.org.uk>
 <1474339566.1954.25.camel@perches.com>
 <alpine.DEB.2.10.1609200751110.3346@hadrien>
 <1474353123.1954.28.camel@perches.com>
 <20160922112407.47da9393@endymion>
 <1474540930.8253.9.camel@perches.com>
 <20160922135758.0399725d@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160922135758.0399725d@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 22, 2016 at 01:57:58PM +0200, Jean Delvare wrote:
> > 
> > MUST is much stronger language than I would prefer.
> 
> That's what error means, really. When your compiler fails with an
> error, you have no choice but to fix your code. Warnings on the other
> hand may be ignored sometimes.

And they are errors, because of...?

> Sure. But I'm afraid you keep changing topics and I have no idea where
> you are going. We started with "should there be a space before jump
> labels", then out of nowhere we were discussing the wording of the
> output of checkpatch (how is that related?) and now you pull statistics
> out of your hat, like these numbers imply anything.
> 
> checkpatch was called checkPATCH for a reason. It's main intent was to
> prevent NEW (coding-style mostly) errors from creeping into the kernel.
> The fact that old code does now always follow these recommendations is
> unfortunate but that doesn't make checkpatch wrong or bad.
> 
> ERROR means that the new code isn't allowed to do that. Period.

The main intent of checkpatch these days appears to be providing an easy
way of thoughtless inflation of commit counts, everything else be damned.
Make-work, in other words.

The _only_ criterion for adding new checks should be a strong consensus in
the core kernel.  IOW, it should be descriptive, not prescriptive.  "Some
people do it this way, some - that" is not a valid reason for "let's make it
uniform; that way is just better, so from now on it's a new requirement".
Especially when the rationale behind the choice has all the intellectual
rigour of feng shui.  Some of these checks are common-sense, some are
absolutely arbitrary, there are far too many of them and elevating them
to the level of compiler errors like you seem to do is rather dishonest.
