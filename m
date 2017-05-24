From: John Spray <jspray@redhat.com>
Subject: Re: Help build a drive reliability service!
Date: Wed, 24 May 2017 20:35:48 +0100
Message-ID: <CALe9h7cTf3+ee4BJhhDVV90n-k+i7-rcPE8GmV3osMK1-6+TTA@mail.gmail.com>
References: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33561 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936992AbdEXTgK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 15:36:10 -0400
Received: by mail-wr0-f178.google.com with SMTP id w50so60847187wrc.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 12:36:09 -0700 (PDT)
In-Reply-To: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Wed, May 24, 2017 at 7:57 PM, Patrick McGarry <pmcgarry@redhat.com> wrote:
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

I happen to already have written (some time ago) an agent that
collects smart data and posts it to a web service.  It's in golang and
links with a crudely hacked version of smartmontools to gather the
stats.

Any interest?  (hopefully I can find the code...)

John

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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
