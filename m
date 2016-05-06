From: Sage Weil <sweil@redhat.com>
Subject: Re: removing 'rados cppool' command
Date: Fri, 6 May 2016 17:27:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605061726250.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605061538160.1841@cpach.fuggernut.com> <CADRKj5TO=TwyGqVC4wVfhN-09+SXwzeBftY7+HbtSgBRZwhuhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557AbcEFV05 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 17:26:57 -0400
In-Reply-To: <CADRKj5TO=TwyGqVC4wVfhN-09+SXwzeBftY7+HbtSgBRZwhuhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Fri, 6 May 2016, Yehuda Sadeh-Weinraub wrote:
> On Fri, May 6, 2016 at 12:41 PM, Sage Weil <sweil@redhat.com> wrote:
> > This PR
> >
> >         https://github.com/ceph/ceph/pull/8975
> >
> > removes the 'rados cppool' command.  The main problem is that the command
> > does not make a faithful copy of all data because it doesn't preserve the
> > snapshots (and snapshot related metadata).  That means if you copy an RBD
> > pool it will render the images somewhat broken (snaps won't be present and
> > won't work properly).  It also doesn't preserve the user_version field
> > that some librados users may rely on.
> >
> > Since it's obscure and of limited use, this PR just removes it.
> >
> > Alternatively, we could add safeguards so that it refuses to make a copy
> > if there are any selfmanaged_snaps, and/or generate some warnings.
> >
> > Any objections?
> 
> I prefer the alternative. I found this command pretty useful for
> testing config upgrade scenarios with rgw. After generating config
> scenarios in older versions, I used this command to store the config
> on another pool, and then I could get the different config whenever
> needed.

Keep in mind that all of these calls in rgw

	rgw/rgw_rados.cc:  epoch = ref.ioctx.get_last_version();

may be subtley broken by cppool because user_version is not preserved...

sage
