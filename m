From: Jean Delvare <jdelvare@suse.de>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 21:47:25 +0200
Message-ID: <20160922214725.4082f9dc@endymion>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
        <20160920001159.GM2356@ZenIV.linux.org.uk>
        <1474339566.1954.25.camel@perches.com>
        <alpine.DEB.2.10.1609200751110.3346@hadrien>
        <1474353123.1954.28.camel@perches.com>
        <20160922112407.47da9393@endymion>
        <1474540930.8253.9.camel@perches.com>
        <20160922135758.0399725d@endymion>
        <1474566587.8253.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1474566587.8253.14.camel@perches.com>
Sender: linux-doc-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 22 Sep 2016 10:49:47 -0700, Joe Perches wrote:
> On Thu, 2016-09-22 at 13:57 +0200, Jean Delvare wrote:
> > Sure. But I'm afraid you keep changing topics and I have no idea where
> > you are going. We started with "should there be a space before jump
> > labels", then out of nowhere we were discussing the wording of the
> > output of checkpatch (how is that related?) and now you pull statistics
> > out of your hat, like these numbers imply anything.
> 
> No, not out of a hat.  Those are the results of a silly script that
> runs checkpatch on every .[ch] kernel file (but not tools/) with:
> 
> 	--show-types --terse --emacs --strict --no-summary --quiet -f

Silly is the key word here. Just don't do it.

> The magnitude of "ERRORS" is high and it's not necessary or useful
> to modify old or obsolete code just to reduce that magnitude.

I agree. Just don't do it.

> > checkpatch was called checkPATCH for a reason.
> 
> That's why I promote the --force option to limit using checkpatch on
> files outside of staging.
> 
> https://patchwork.kernel.org/patch/9332205/
> 
> Andrew?  Are you going to apply that one day?

I hope not. Looks plain wrong to me. This wont prevents idiots from
being idiots. All it does is make things more difficult for the rest of
us.

> > ERROR means that the new code isn't allowed to do that. Period.
> 
> Disagree.  The compiler doesn't care.

Which is good, because this has nothing to do with the compiler.

> The value of consistency in reducing defects is very hard to quantify.

That's not the only purpose of consistency.

-- 
Jean Delvare
SUSE L3 Support
