From: Jean Delvare <jdelvare@suse.de>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 11:24:07 +0200
Message-ID: <20160922112407.47da9393@endymion>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
 <20160920001159.GM2356@ZenIV.linux.org.uk>
 <1474339566.1954.25.camel@perches.com>
 <alpine.DEB.2.10.1609200751110.3346@hadrien>
 <1474353123.1954.28.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60801 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755220AbcIVJYL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 05:24:11 -0400
In-Reply-To: <1474353123.1954.28.camel@perches.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org

Hi Joe,

On Mon, 19 Sep 2016 23:32:03 -0700, Joe Perches wrote:
> On Tue, 2016-09-20 at 07:53 +0200, Julia Lawall wrote:
> > I think it is better to be clear.  CHECK was never really clear to me,
> > especially if you see it in isolation, on a file that doesn't also have
> > ERROR or WARNING.  NITS is a common word in this context, but not FLEAS
> > and GNATS, as far as I know.
> > There could also be a severity level: high medium and low
> 
> I agree clarity is good.
> 
> The seriousness with which some beginners take these message
> types though is troublesome,

You need to think in terms of actual use cases. Who uses checkpatch and
why? I think there are 3 groups of users:
* Beginners. They won't run the script by themselves, instead they will
  submit a patch which infringes a lot of coding style rules, and the
  maintainer will point them to checkpatch and ask for a resubmission
  which makes checkpatch happy. Being beginners, they can only rely on
  the script itself to only report things which need to be fixed, by
  default.
* Experienced developers. Who simply want to make sure they did not
  overlook anything before they post their work for review. They have
  the knowledge to decide if they want to ignore some of the warnings.
* People with too much spare time, looking for anything they could
  "contribute" to the kernel. They will use --subjective and piss off
  every maintainer they can find.

Sadly there's not much we can do about the third category, short of
killing option --subjective altogether.

The default settings should work out of the box for for the first
category.

> Maybe prefix various different types of style messages.
> 
> Something like:
> 
> ERROR	-> CODE_STYLE_DEFECT
> WARNING -> CODE_STYLE_UNPREFERRED
> CHECK	-> CODE_STYLE_NIT

I don't think you clarify anything with these changes, as they do not
carry the requirement from a submitter's perspective. If you really
want to change the names, I would rather suggest:

ERROR -> MUST_FIX
WARNING -> SHOULD_FIX
CHECK -> MAY_FIX

Or explain the categories in plain English, see below.

> I doubt additional external documentation would help much.

I agree. If anything needs to be explained, it should be included in
the output of checkpatch directly. For example, if any ERROR was
printed, include the following after the count summary:

"ERROR means the code is infringing a core coding style rule. This MUST
be fixed before the patch is submitted upstream."

And if any WARNING was printed, include the following:

"WARNING means the code is not following the best practice. This SHOULD
be fixed before the patch is submitted upstream, unless the maintainer
agreed otherwise."

Not sure if we need something for CHECK, as these messages are not
printed by default so I'd assume people who get them know what they
asked for. But apparently these confused Julia so maybe a similar
explanation would be needed for them too.

-- 
Jean Delvare
SUSE L3 Support
