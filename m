From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Mon, 3 Feb 2014 21:31:53 +0000
Message-ID: <20140203213153.GZ10323@ZenIV.linux.org.uk>
References: <CALFYKtDCNWK+9m5m3P01dcxOOV7iHFeNaOH=Q=6Pffuo8gmrMQ@mail.gmail.com>
 <1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
 <CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
 <20140130075421.GA10050@infradead.org>
 <CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
 <20140203102943.GF11829@infradead.org>
 <CA+55aFytvTPdBsv6BwSomUGWXZ_tKP=BxaeJ7FXBft0JNnjBCQ@mail.gmail.com>
 <20140203211955.GY10323@ZenIV.linux.org.uk>
 <20140203212447.GA4843@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140203212447.GA4843@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 03, 2014 at 01:24:47PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2014 at 09:19:55PM +0000, Al Viro wrote:
> > Result *is* a function of inode alone; the problem with 9P is that we
> > are caching FIDs in the wrong place.
> 
> I don't think that's true for CIFS unfortunately, which is path based.

Yes, and...?  CIFS also doesn't have hardlinks, so _there_ d_find_alias()
is just fine.

9P is actually trickier; there we need some massage, but for CIFS it's
literally a matter of one function call.

The problem with 9P is that the way we do it right now, you might pick
the wrong dentry.  _Some_ alias already bears the FID you are after,
but if you end up picking the one that doesn't, you might very well
end up being unable to obtain one either.
