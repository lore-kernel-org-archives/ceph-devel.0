From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next
Date: Thu, 22 Sep 2016 16:06:00 +0300
Message-ID: <87zin0nkxz.fsf@intel.com>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com> <20160920001159.GM2356@ZenIV.linux.org.uk> <1474339566.1954.25.camel@perches.com> <alpine.DEB.2.10.1609200751110.3346@hadrien> <1474353123.1954.28.camel@perches.com> <20160922112407.47da9393@endymion> <8760pop63l.fsf@intel.com> <20160922144648.10efc7ac@endymion>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160922144648.10efc7ac@endymion>
Sender: linux-doc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>, Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 22 Sep 2016, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Jani,
>
> On Thu, 22 Sep 2016 13:43:42 +0300, Jani Nikula wrote:
>> 
>> You could make checkpatch have different defaults for patches and files,
>> to encourage better style in new code, but to discourage finding
>> problems in existing code.
>
> Fixing old code isn't wrong per se. It's good actually. But only if
> done the right way by the right person. I don't think it makes any
> sense to use this task as an introduction to kernel development for
> newcomers. It doesn't teach them anything about the kernel, really.

Mostly agreed, though I'd go as far as saying certain classes of
(checkpatch) issues aren't worth fixing, at all, by anyone, except
perhaps while changing the code anyway for some other purpose.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
