From: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Cache Tiering Investigation and Potential Patch
Date: Tue, 1 Dec 2015 16:30:37 -0000
Message-ID: <efd0340f.9Ro.9Gf.12.k75t9V@mailjet.com>
References: <3196669f.9Ro.9Gf.11.jZLaYO@mailjet.com>
	<alpine.DEB.2.00.1511250936470.11017@cobra.newdream.net>
	<2f99090c.9Ro.9Gf.24.jZU57B@mailjet.com>
	<alpine.DEB.2.00.1511251137390.11017@cobra.newdream.net>
	<af1c2841.9Ro.9Gf.22.jZVKGJ@mailjet.com>
	<alpine.DEB.2.00.1511251240010.11017@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-gb
In-Reply-To: <alpine.DEB.2.00.1511251240010.11017-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage/Mark,

I have completed some initial testing of the tiering fix PR you submitted compared to my method I demonstrated at the perf meeting last week.

From a high level both have very similar performance when compared to the current broken behaviour. So I think until Jewel, either way would suffice in fixing the bug.

I have also been running several tests with different cache sizes and recency settings to try and determine if there is any performance differences.

The main thing I have noticed is that when it is based on actual recency method in your PR, you run out of adjustment resolution down the low end of the recency scale. The difference between objects which are in 1,2 or 3 concurrent hit sets is quite large and dramatically affects the promotion behaviour. After that though, there is not much difference between setting it to 3 or setting it to 9, a sort of logarithmic effect. This looks like it might have an impact on being able to tune it to the right setting to be able to fill the cache tier. After the cache had the really hot blocks in it, the promotions tailed off and the tier wouldn't fill up as there just wasn't any more objects getting hit 3 or 4 times in a row. If I dropped the recency down by 1, then there were too many promotions.

In short, if you set the recency anywhere between 3-4 and max(10) then you were pretty much guaranteed reasonable performance with a zipf1.1 profile that I tested with.

With my method, it seemed to have a more linear response and hence more adjustment resolution, but you needed to be a bit more clever about picking the right number. With a zipf1.1 profile and a cache size of around 15% of the volume, a recency setting between 6 and 8 (out of 10 hitsets) provided the best performance. Higher recency meant the cache couldn't find hot enough objects to promote, lower resulted in too many promotions. I think if you take the cache size percentage, then invert it and double it, this should give you a rough idea of the required recency setting. Ie 20% cache size = 6 recency for 10 hitsets. 10% cache size would be 8 for 10 hitsets.

It could probably also do with some logic to promote really hot blocks faster. I'm guessing a combination of the two methods would probably be fairly simple to implement and provide the best gain.

Promote IF
1. Total number of hits in all hitsets > required count
2. Object is in last N recent hitsets

But as I touched on above, both of these methods are still vastly improved on the current code and it might be that it's not worth doing much more work on this, if a proper temperature based list method is likely to be implemented.

I can try and get some graphs captured and jump on the perf meeting tomorrow if it would be useful?


I also had a bit of a think about what you said regarding only keeping 1 copy for non dirty objects and the potential write amplification involved. If we had a similar logic to maybe_promote(), like maybe_dirty(), which would only dirty a block in the cache tier if it's very very hot, otherwise the write gets proxied. That should limit the amount of objects requiring extra copies to be generated every time there is a write. The end user may also want to turn off write caching altogether so that all writes are proxied to take advantage of larger read cache. 

Nick

> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> Sent: 25 November 2015 20:41
> To: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> Cc: 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> 'Mark Nelson' <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Subject: RE: Cache Tiering Investigation and Potential Patch
> 
> On Wed, 25 Nov 2015, Nick Fisk wrote:
> > > > Yes I think that should definitely be an improvement. I can't
> > > > quite get my head around how it will perform in instances where
> > > > you miss 1 hitset but all others are a hit. Like this:
> > > >
> > > > H H H M H H H H H H H H
> > > >
> > > > And recency is set to 8 for example. It maybe that it doesn't have
> > > > much effect on the overall performance. It might be that there is
> > > > a strong separation of really hot blocks and hot blocks, but this
> > > > could turn out to be a good thing.
> > >
> > > Yeah... In the above case recency 3 would be enough (or 9, depending
> > > on whether that's chronological or reverse chronological order).
> > > Doing an N out of M or similar is a bit more flexible and probably
> > > something we should add on top.  (Or, we could change recency to be
> > > N/M instead of just
> > > N.)
> >
> > N out of M, is that similar to what I came up with but combined with
> > the N most recent sets?
> 
> Yeah
> 
> > If you can wait a couple of days I will run the PR in its current
> > state through my test box and see how it looks.
> 
> Sounds great, thanks.
> 
> > Just a quick question, is there a way to just make+build the changed
> > files/package or select just to build the main ceph.deb. I'm just
> > using " sudo dpkg-buildpackage" at the moment and its really slowing
> > down any testing I'm doing waiting for everything to rebuild.
> 
> You can probably 'make ceph-osd' and manualy copy that binary into place,
> assuming distro matches your build and test environments...
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
