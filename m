From: Dave Chinner <david@fromorbit.com>
Subject: Re: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Tue, 15 Jul 2014 06:23:31 +1000
Message-ID: <20140714202330.GU4453@dastard>
References: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
	<20140713012624.GS4453@dastard>
	<CA+4uBUZwuh5t28jU5jfQb3ApdUKx8t88hg6m8CXS+0ztpi6OTw@mail.gmail.com>
	<CALFYKtC7J1ZvW40wsSWmVpNS5T3tmAOmY9CP=nsh4r=iUjeznA@mail.gmail.com>
	<20140713225532.GD22339@dastard>
	<CALFYKtBVLLTjXnxS3qc7sCYbc+MfFFrGsbM1D_8jK4oiUd267w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
Content-Disposition: inline
In-Reply-To: <CALFYKtBVLLTjXnxS3qc7sCYbc+MfFFrGsbM1D_8jK4oiUd267w@mail.gmail.com>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Samuel Just <sam.just@inktank.com>, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Jul 14, 2014 at 11:24:05AM +0400, Ilya Dryomov wrote:
> On Mon, Jul 14, 2014 at 2:55 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Sun, Jul 13, 2014 at 09:01:13PM +0400, Ilya Dryomov wrote:
> >> On Sun, Jul 13, 2014 at 5:48 AM, Samuel Just <sam.just@inktank.com> wrote:
> >> I think if you call fsync() or even
> >> fdatasync() before close(fd), it will fail as expected.
> >
> > Only if you are trying to change the extent size immediately after
> > the first write you do to an empty file. Which is, as per the above,
> > not the recommended or intended use of the ioctl.
> 
> That's understood, but that is exactly what Sam's test program happens
> to try to do, so I had to point the "file w/o real extents" thing out.

Oh, I missed that there was a test program attached. That's what
happens when people top post a reply then attach text at the
bottom....

Moral of the story: don't top post ;)

Cheersm

Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
