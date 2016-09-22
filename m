From: Jean Delvare <jdelvare@suse.de>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 13:57:58 +0200
Message-ID: <20160922135758.0399725d@endymion>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
        <20160920001159.GM2356@ZenIV.linux.org.uk>
        <1474339566.1954.25.camel@perches.com>
        <alpine.DEB.2.10.1609200751110.3346@hadrien>
        <1474353123.1954.28.camel@perches.com>
        <20160922112407.47da9393@endymion>
        <1474540930.8253.9.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474540930.8253.9.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 22 Sep 2016 03:42:10 -0700, Joe Perches wrote:
> On Thu, 2016-09-22 at 11:24 +0200, Jean Delvare wrote:
> > I would rather suggest:
> > 
> > ERROR -> MUST_FIX
> > WARNING -> SHOULD_FIX
> > CHECK -> MAY_FIX
> 
> MUST is much stronger language than I would prefer.

That's what error means, really. When your compiler fails with an
error, you have no choice but to fix your code. Warnings on the other
hand may be ignored sometimes.

> There are still about a quarter million ERRORs just for
> spacing issues in the kernel tree.
> 
> Here are the top 10 ERROR checkpatch messages treewide as of
> a few days ago,
> 
> $ grep ERROR checkpatch.short_sorted_20160917
>  268308  ERROR:SPACING
>   37340  ERROR:CODE_INDENT
>   27678  ERROR:TRAILING_WHITESPACE
>   21024  ERROR:COMPLEX_MACRO
>   14048  ERROR:POINTER_LOCATION
>   12207  ERROR:TRAILING_STATEMENTS
>   11079  ERROR:OPEN_BRACE
>    6802  ERROR:ASSIGN_IN_IF
>    3940  ERROR:RETURN_PARENTHESES
>    2322  ERROR:NON_OCTAL_PERMISSIONS
> 
> Maybe there could be some better classifications of the various
> messages.
> 
> But there are about two million checkpatch messages overall in
> the kernel tree.
> 
> That's a lot.

Sure. But I'm afraid you keep changing topics and I have no idea where
you are going. We started with "should there be a space before jump
labels", then out of nowhere we were discussing the wording of the
output of checkpatch (how is that related?) and now you pull statistics
out of your hat, like these numbers imply anything.

checkpatch was called checkPATCH for a reason. It's main intent was to
prevent NEW (coding-style mostly) errors from creeping into the kernel.
The fact that old code does now always follow these recommendations is
unfortunate but that doesn't make checkpatch wrong or bad.

ERROR means that the new code isn't allowed to do that. Period.

-- 
Jean Delvare
SUSE L3 Support
