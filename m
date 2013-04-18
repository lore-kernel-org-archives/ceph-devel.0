From: "Plaetinck, Dieter" <dieter@vimeo.com>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 17:31:13 -0400
Message-ID: <20130418173113.74a53769@dieter-t420s>
References: <20130418162842.0c61d1e2@dieter-t420s>
	<alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
	<517060B2.80706@inktank.com>
	<51706120.2060702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lav-excas.iac.com ([208.185.199.15]:18083 "EHLO
	ny-iacmail.iac.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753048Ab3DRVbX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 17:31:23 -0400
In-Reply-To: <51706120.2060702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, cdl@asgaard.org, danm@annaisystems.com

On Thu, 18 Apr 2013 16:09:52 -0500
Mark Nelson <mark.nelson@inktank.com> wrote:

> On 04/18/2013 04:08 PM, Josh Durgin wrote:
> > On 04/18/2013 01:47 PM, Sage Weil wrote:
> >> On Thu, 18 Apr 2013, Plaetinck, Dieter wrote:
> >>> sorry to bring this up again, googling revealed some people don't
> >>> like the subject [anymore].
> >>>
> >>> but I'm working on a new +- 3PB cluster for storage of immutable files.
> >>> and it would be either all cold data, or mostly cold. 150MB avg
> >>> filesize, max size 5GB (for now)
> >>> For this use case, my impression is erasure coding would make a lot
> >>> of sense
> >>> (though I'm not sure about the computational overhead on storing and
> >>> loading objects..? outbound traffic would peak at 6 Gbps, but I can
> >>> make it way less and still keep a large cluster, by taking away the
> >>> small set of hot files.
> >>> inbound traffic would be minimal)
> >>>
> >>> I know that the answer a while ago was "no plans to implement erasure
> >>> coding", has this changed?
> >>> if not, is anyone aware of a similar system that does support it? I
> >>> found QFS but that's meant for batch processing, has a single
> >>> 'namenode' etc.
> >>
> >> We would love to do it, but it is not a priority at the moment (things
> >> like multi-site replication are in much higher demand).  That of course
> >> doesn't prevent someone outside of Inktank from working on it :)
> >>
> >> The main caveat is that it will be complicate.  For an initial
> >> implementation, the full breadth of the rados API probably wouldn't be
> >> support for erasure/parity encoded pools (thinkgs like rados classes and
> >> the omap key/value api get tricky when you start talking about parity).
> >> But for many (or even most) use cases, objects are just bytes, and those
> >> restrictions are just fine.
> >
> > I talked to some folks interested in doing a more limited form of this
> > yesterday. They started a blueprint [1]. One of their ideas was to have
> > erasure coding done by a separate process (or thread perhaps). It would
> > use erasure coding on an object and then use librados to store the
> > rasure-encoded pieces in a separate pool, and finally leave a marker in
> > place of the original object in the first pool.
> >
> > When the osd detected this marker, it would proxy the request to the
> > erasure coding thread/process which would service the request on the
> > second pool for reads, and potentially make writes move the data back to
> > the first pool in a tiering sort of scenario.
> >
> > I might have misremembered some details, but I think it's an
> > interesting way to get many of the benefits of erasure coding with a
> > relatively small amount of work compared to a fully native osd solution.
> >
> > Josh
> 
> Neat. :)
> 

@Bryan: I did come across cleversafe.  all the articles around it seemed promising,
but unfortunately it seems everything related to the cleversafe open source project
somehow vanished from the internet.  (e.g. http://www.cleversafe.org/) quite weird...

@Sage: interesting. I thought it would be more relatively simple if one assumes
the restriction of immutable files.  I'm not familiar with those ceph specifics you're mentioning.
When building an erasure codes-based system, maybe there's ways to reuse existing ceph
code and/or allow some integration with replication based objects, without aiming for full integration or
full support of the rados api, based on some tradeoffs.

@Josh, that sounds like an interesting approach.  Too bad that page doesn't contain any information yet :)

Dieter
