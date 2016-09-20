From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next (was
 Re: [PATCH 03/47] block-rbd: Adjust the position of a jump label in
 rbd_header_from_disk())
Date: Tue, 20 Sep 2016 01:11:59 +0100
Message-ID: <20160920001159.GM2356@ZenIV.linux.org.uk>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 19, 2016 at 01:53:37PM +0200, Ilya Dryomov wrote:
> > I did consider the reason to be good enough to warrant a "change",
> > actually. Or more exactly from "one space is allowed" to "one space is
> > recommended." Which is quite different from changing all the code
> > actively. I can understand how you don't like it, but again, this
> > "inconsistency" has been accepted for almost a decade now, so I find it
> > strange to see so much resistance when someone finally tries to sort it
> > out.
> 
> Yeah, I guess that's where our disagreement lies - the "so that `diff
> -p` does not confuse labels with functions" in the age of git, hg and
> others, all of which can be customized to your heart's content is not
> a good enough reason to go from "allowed" to "advised".

On the top of CodingStyle we have
"This is a short document describing the preferred coding style for the
linux kernel."

Let's make it s/describing/& (as in "descriptive, not prescriptive")/.
The lack of consensus (in the core kernel areas) is _not_ an invitation
to pick a rule out of one's arse/nose/armpit/textbook/whatnot and stick
it as The One True Style, and references to uniformity are worthless
in such case.

In particular, "whitespace before labels" kind of patches anywhere in
VFS will be simply rejected.

IMO what we need is to go through all rules in CodingStyle and if for
some rule there is no overwhelming majority in the core kernel, well,
the list has grown way too large and could use massive trimming.
