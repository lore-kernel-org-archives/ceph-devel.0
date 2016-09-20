From: Joe Perches <joe@perches.com>
Subject: Re: "CodingStyle: Clarify and complete chapter 7" in docs-next (was
 Re: [PATCH 03/47] block-rbd: Adjust the position of a jump label in
 rbd_header_from_disk())
Date: Mon, 19 Sep 2016 19:46:06 -0700
Message-ID: <1474339566.1954.25.camel@perches.com>
References: <CAOi1vP8Y6V3mWs1bv=-CCVRfGi59P+3F85n6rzMn0=K6FqQkcw@mail.gmail.com>
         <20160920001159.GM2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160920001159.GM2356@ZenIV.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, Ilya Dryomov <idryomov@gmail.com>, Andy Whitcroft <apw@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jean Delvare <jdelvare@suse.de>, Jonathan Corbet <corbet@lwn.net>, Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, 2016-09-20 at 01:11 +0100, Al Viro wrote:
> IMO what we need is to go through all rules in CodingStyle and if for
> some rule there is no overwhelming majority in the core kernel, well,
> the list has grown way too large and could use massive trimming.

I'm in complete agreement.

I also think that checkpatch's ERROR/WARNING/CHECK message naming is
far too severe and injunctive and could use a renaming to something
more silly, bug related and less commanding like FLEAS/GNATS/NITS.

