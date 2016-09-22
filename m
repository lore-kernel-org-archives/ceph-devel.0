From: Jean Delvare <jdelvare@suse.de>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 14:46:48 +0200
Message-ID: <20160922144648.10efc7ac@endymion>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
        <20160920001159.GM2356@ZenIV.linux.org.uk>
        <1474339566.1954.25.camel@perches.com>
        <alpine.DEB.2.10.1609200751110.3346@hadrien>
        <1474353123.1954.28.camel@perches.com>
        <20160922112407.47da9393@endymion>
        <8760pop63l.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <8760pop63l.fsf@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>, Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Jani,

On Thu, 22 Sep 2016 13:43:42 +0300, Jani Nikula wrote:
> On Thu, 22 Sep 2016, Jean Delvare <jdelvare@suse.de> wrote:
> > You need to think in terms of actual use cases. Who uses checkpatch and
> > why? I think there are 3 groups of users:
> > * Beginners. They won't run the script by themselves, instead they will
> >   submit a patch which infringes a lot of coding style rules, and the
> >   maintainer will point them to checkpatch and ask for a resubmission
> >   which makes checkpatch happy. Being beginners, they can only rely on
> >   the script itself to only report things which need to be fixed, by
> >   default.
> > * Experienced developers. Who simply want to make sure they did not
> >   overlook anything before they post their work for review. They have
> >   the knowledge to decide if they want to ignore some of the warnings.
> > * People with too much spare time, looking for anything they could
> >   "contribute" to the kernel. They will use --subjective and piss off
> >   every maintainer they can find.
> >
> > Sadly there's not much we can do about the third category, short of
> > killing option --subjective altogether.
> 
> You could make checkpatch have different defaults for patches and files,
> to encourage better style in new code, but to discourage finding
> problems in existing code.

Fixing old code isn't wrong per se. It's good actually. But only if
done the right way by the right person. I don't think it makes any
sense to use this task as an introduction to kernel development for
newcomers. It doesn't teach them anything about the kernel, really.

-- 
Jean Delvare
SUSE L3 Support
