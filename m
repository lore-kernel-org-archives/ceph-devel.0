From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Date: Thu, 20 Jun 2019 15:34:25 +0300
Message-ID: <20190620123425.GZ9224@smile.fi.intel.com>
References: <20190619164528.31958-1-jlayton@kernel.org>
 <20190620102410.GT9224@smile.fi.intel.com>
 <7c12abe8a7e6cd3cfe9129a1e74d9c788ff2f1a9.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c12abe8a7e6cd3cfe9129a1e74d9c788ff2f1a9.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com, joe@perches.com, pmladek@suse.com, rostedt@goodmis.org, geert+renesas@glider.be
List-Id: ceph-devel.vger.kernel.org

On Thu, Jun 20, 2019 at 07:41:06AM -0400, Jeff Layton wrote:
> On Thu, 2019-06-20 at 13:24 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 19, 2019 at 12:45:25PM -0400, Jeff Layton wrote:

> > So, then don't use snprintf() for this, simple memcpy() designed for that kind
> > of things.
> > 
> 
> memcpy from what? For many of these xattrs, we need to format integer
> data into strings. I could roll my own routine to do this formatting,
> but that's sort of what sprintf and its variants are for and I'd rather
> not reimplement all of it from scratch.

So, use bigger temporary buffer and decide what to do with data if it doesn't
fit the destination one.

String without nul is not considered as a string, thus, memcpy() the data.

> > > This patch makes ceph's virtual xattrs not include NULL termination
> > > when formatting their values. In order to handle this, a new
> > > snprintf_noterm function is added, and ceph is changed over to use
> > > this to populate the xattr value buffer.
> > 
> > In terms of vsnprintf(), and actually compiler point of view, it's not a string
> > anymore, it's a text-based data.
> > 
> > Personally, I don't see an advantage of a deep intrusion into vsnprintf().
> > The wrapper can be made to achieve this w/o touching the generic code. Thus,
> > you can quickly and cleanly fix the issue, while discussing this with wider
> > audience.
> > 
> 
> Sorry, if I'm being dense but I'm not sure I follow here.
> 
> Are you suggesting I should just copy/paste most of vsnprintf into a new
> function that just leaves off the termination at the end, and leave the
> original alone?

Yes. The data you are expecting is not a string anymore from these functions
point of view. Even GCC nowadays complains on strncpy() when nul doesn't fit
the destination buffer.

> That seems like a bit of a waste, but if that's the
> consensus then ok.

My personal view is not a consensus, let's wait for more opinions.

-- 
With Best Regards,
Andy Shevchenko
