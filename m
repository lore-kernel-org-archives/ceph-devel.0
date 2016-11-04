From: Sage Weil <sweil@redhat.com>
Subject: Re: kraken
Date: Fri, 4 Nov 2016 13:13:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611041312080.20331@piezo.us.to>
References: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to> <1478212585.17105.3.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1529238077-1478265225=:20331"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755812AbcKDNNq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 09:13:46 -0400
In-Reply-To: <1478212585.17105.3.camel@poochiereds.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: ceph-devel@vger.kernel.org, John Spray <jspray@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1529238077-1478265225=:20331
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 3 Nov 2016, Jeff Layton wrote:
> On Tue, 2016-11-01 at 13:20 +0000, Sage Weil wrote:
> > Hey everyone,
> > 
> > I think we're about ready for a kraken feature freeze.  The main item we 
> > were waiting for was the EC overwrites and Sam has a working branch for 
> > review this week.  There are still a few odds and ends that I have on my 
> > list to get in (like the new CRUSH tunable), but it's a short list.
> > 
> > How does next Monday (11/7) sound for an initial freeze?
> > 
> > 
> 
> I have a PR up that I'd like to see go in that fixes some really slow
> fsync performance in libcephfs:
> 
>     https://github.com/ceph/ceph/pull/11710
> 
> The catch here is that it requires a protocol change in MClientCaps, so
> it'd be good to merge that in with the btime/change_attr stuff before
> release. At this point though, I just want to understand whether the
> general approach is sound. Do we want to allow the client to hint to
> the MDS that it should flush its log.

I think so.  The MDS could always ignore it if it wanted to.

Also, the protocol change doesn't need a feature bit since it's only in 
the message encoding (new field), so there's no need to tie it with the 
other changes.  I commented on the PR how to do that.

> Also, we probably need to think about what to do with the libcephfs API
> overhaul:
> 
>     https://github.com/ceph/ceph/pull/11647
> 
> That will rev the libcephfs version to "2", and break the API. I have
> the ganesha and samba patches done.
> 
> Do we want that in kraken, or should it wait for luminous?

I can go either way.  Slight preference for kraken.  Is it ready?

sage
--8323329-1529238077-1478265225=:20331--
