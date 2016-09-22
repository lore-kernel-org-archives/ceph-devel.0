From: Joe Perches <joe@perches.com>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 10:50:44 -0700
Message-ID: <1474566644.8253.15.camel@perches.com>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
         <20160920001159.GM2356@ZenIV.linux.org.uk>
         <1474339566.1954.25.camel@perches.com>
         <alpine.DEB.2.10.1609200751110.3346@hadrien>
         <1474353123.1954.28.camel@perches.com> <20160922112407.47da9393@endymion>
         <1474540930.8253.9.camel@perches.com> <20160922135758.0399725d@endymion>
         <20160922131103.GW2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160922131103.GW2356@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, Jean Delvare <jdelvare@suse.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2016-09-22 at 14:11 +0100, Al Viro wrote:
> The main intent of checkpatch these days appears to be providing an easy
> way of thoughtless inflation of commit counts, everything else be damned.

You've made this statement several times over many years.
I don't believe it's true.
I doubt anyone is getting paid per commit.
Who really cares enough to game some stupid little metric?

If it's really a big deal, name some names.  Otherwise please
stop with this dubious argument/point.

> Some of these checks are common-sense, some are
> absolutely arbitrary,

Essentially all of the checkpatch rules are arbitrary.
The compiler doesn't care one way or another.

All the checks exist just to make code appear more consistent.

The conceit being that more consistent code is easier for humans
to read and spot potential defects and possible reuse patterns.
