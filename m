From: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Cache Tiering Investigation and Potential Patch
Date: Wed, 25 Nov 2015 19:36:01 -0000
Message-ID: <c0914e9d.9Ro.9Gf.1Y.jZU57J@mailjet.com>
References: <3196669f.9Ro.9Gf.11.jZLaYO@mailjet.com>
	<alpine.DEB.2.00.1511250936470.11017@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-gb
In-Reply-To: <alpine.DEB.2.00.1511250936470.11017-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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

Hi Sage

> -----Original Message-----
> From: Sage Weil [mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org]
> Sent: 25 November 2015 17:38
> To: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
> Cc: 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> 'Mark Nelson' <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Subject: Re: Cache Tiering Investigation and Potential Patch
> 
> On Wed, 25 Nov 2015, Nick Fisk wrote:
> > Presentation from the performance meeting.
> >
> > I seem to be unable to post to Ceph-devel, so can someone please
> > repost there if useful.
> 
> Copying ceph-devel.  The problem is just that your email is HTML-formatted.
> If you send it in plaintext vger won't reject it.

Right ok, let's see if this gets through. 

> 
> > I will try and get a PR sorted, I realise that this change modifies
> > the way the cache was originally designed but I think it provides a
> > quick win for the performance increase involved. If there are plans
> > for a better solution in time for the next release, then I would be
> > really interested in working to that goal instead.
> 
> It's how it was intended/documented to work, so I think this falls in the 'bug
> fix' category.  I did a quick PR here:
> 
> 	https://github.com/ceph/ceph/pull/6702
> 
> Does that look right?

Yes  I think that should definitely be an improvement. I can't quite get my head around how it will perform in instances where you miss 1 hitset but all others are a hit. Like this:

H H H M H H H H H H H H

And recency is set to 8 for example. It maybe that it doesn't have much effect on the overall performance. It might be that there is a strong separation of really hot blocks and hot blocks, but this could turn out to be a good thing.

Would it be useful for me to run all 3 versions (Old, this and mine) through the same performance test I did before?

Also I saw pull request 6623, is it still relevant to get the list order right?

Thanks for your support on this.
Nick

> 
> Thanks!
> sage
