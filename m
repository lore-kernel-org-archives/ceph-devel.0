From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 17:05:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1609221702050.2981@hadrien>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>        <20160920001159.GM2356@ZenIV.linux.org.uk>        <1474339566.1954.25.camel@perches.com>        <alpine.DEB.2.10.1609200751110.3346@hadrien>        <1474353123.1954.28.camel@perches.com>
        <20160922112407.47da9393@endymion>        <1474540930.8253.9.camel@perches.com>        <20160922135758.0399725d@endymion>        <20160922131103.GW2356@ZenIV.linux.org.uk> <20160922165837.1363860b@endymion>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160922165837.1363860b@endymion>
Sender: linux-doc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

> > The main intent of checkpatch these days appears to be providing an easy
> > way of thoughtless inflation of commit counts, everything else be damned.
> > Make-work, in other words.
>
> Yes, I've noticed the trend too :-( But that's a problem with the
> people using the tool, mostly, not with the tool itself.

With respect to at least one person in this category, I don't think that
their main original inspiration was checkpatch in the first place.  More
random information collected from developer comments, that person's own
notion of what good code is, etc.  So there may be limits to what one can
do to checkpatch that will have an impact on this issue.

Furthermore, probably people who use checkpatch in the right way, ie to
check their patches, don't actually mention their use of checkpatch.  They
just fix up their commits and move on.

julia
