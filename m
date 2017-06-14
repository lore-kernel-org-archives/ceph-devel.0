From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: Help build a drive reliability service!
Date: Wed, 14 Jun 2017 17:37:05 +0200
Message-ID: <CABZ+qqmiKrca=AsoAYS3CaW+TTOieoSn1T_Z=gWzaxzmeA1stQ@mail.gmail.com>
References: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Patrick,

We've just discussed this internally and I wanted to share some notes.

First, there are at least three separate efforts in our IT dept to
collect and analyse SMART data -- its clearly a popular idea and
simple to implement, but this leads to repetition and begs for a
common, good solution.

One (perhaps trivial) issue is that it is hard to define exactly when
a drive has failed -- it varies depending on the storage system. For
Ceph I would define failure as EIO, which normally correlates with a
drive medium error, but there were other ideas here. So if this should
be a general purpose service, the sensor should have a pluggable
failure indicator.

There was also debate about what exactly we could do with a failure
prediction model. Suppose the predictor told us a drive should fail in
one week. We could proactively drain that disk, but then would it
still fail? Will the vendor replace that drive under warranty only if
it was *about to fail*?

Lastly, and more importantly, there is a general hesitation to publish
this kind of data openly, given how negatively it could impact a
manufacturer. Our lab certainly couldn't publish a report saying "here
are the most and least reliable drives". I don't know if anonymising
the data sources would help here, but anyway I'm curious what are your
thoughts on that point. Maybe what can come out of this are the
_components_ of a drive reliability service, which could then be
deployed privately or publicly as appropriate.

Thanks!

Dan




On Wed, May 24, 2017 at 8:57 PM, Patrick McGarry <pmcgarry-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hey cephers,
>
> Just wanted to share the genesis of a new community project that could
> use a few helping hands (and any amount of feedback/discussion that
> you might like to offer).
>
> As a bit of backstory, around 2013 the Backblaze folks started
> publishing statistics about hard drive reliability from within their
> data center for the world to consume. This included things like model,
> make, failure state, and SMART data. If you would like to view the
> Backblaze data set, you can find it at:
>
> https://www.backblaze.com/b2/hard-drive-test-data.html
>
> While most major cloud providers are doing this for themselves
> internally, we would like to replicate/enhance this effort across a
> much wider segment of the population as a free service.  I think we
> have a pretty good handle on the server/platform side of things, and a
> couple of people who have expressed interest in building the
> reliability model (although we could always use more!), what we really
> need is a passionate volunteer who would like to come forward to write
> the agent that sits on the drives, aggregates data, and submits daily
> stats reports via an API (and potentially receives information back as
> results are calculated about MTTF or potential to fail in the next
> 24-48 hrs).
>
> Currently my thinking is to build our collection method based on the
> Backblaze data set so that we can use it to train our model and build
> from going forward. If this sounds like a project you would like to be
> involved in (especially if you're from Backblaze!) please let me know.
> I think a first pass of the agent should be something we can build in
> a couple of afternoons to start testing with a small pilot group that
> we already have available.
>
> Happy to entertain any thoughts or feedback that people might have. Thanks!
>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com  ||  http://community.redhat.com
> @scuttlemonkey || @ceph
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
