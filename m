From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Date: Tue, 25 Jun 2019 18:50:39 -0400
Message-ID: <20190625185039.08fa5a4f@gandalf.local.home>
References: <20190619164528.31958-1-jlayton@kernel.org>
        <20190620102410.GT9224@smile.fi.intel.com>
        <7c12abe8a7e6cd3cfe9129a1e74d9c788ff2f1a9.camel@kernel.org>
        <CAMuHMdUtwtruJtcUe4-YQJQ5h9B-WCcjK57hVMvxjnrZeFjrfA@mail.gmail.com>
        <d8218bd280f19ebbd38f396dbf4e763b945d40bd.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8218bd280f19ebbd38f396dbf4e763b945d40bd.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>, sage@redhat.com, agruenba@redhat.com, Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: ceph-devel.vger.kernel.org

On Thu, 20 Jun 2019 09:54:13 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> > snprintf() to a temporary buffer, and memcpy() to the final destination.
> > These are all fairly small buffers (most are single integer values),
> > so the overhead should be minimal, right?
> >   
> 
> Yeah. I was trying to avoid having to deal with a second buffer, but
> this is not a performance-critical codepath, so maybe that's the best
> option.

Yes, this looks like the better solution than adding a new library
function for other people to (ab)use.

-- Steve
