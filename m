From: Gregory Farnum <greg@inktank.com>
Subject: Re: CEPH IOPS Baseline Measurements with MemStore
Date: Mon, 23 Jun 2014 13:41:31 -0400
Message-ID: <CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>
References: <36031eee-ed15-448d-8f84-ae940f627dbc@mailpro>
	<ae132423-84b1-490c-b36e-e29ee226c8e5@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:52963 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbaFWRlc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 13:41:32 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so6198311qge.39
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jun 2014 10:41:32 -0700 (PDT)
In-Reply-To: <ae132423-84b1-490c-b36e-e29ee226c8e5@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Milosz Tanski <milosz@adfin.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 20, 2014 at 12:41 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
> They are also a tracker here
> http://tracker.ceph.com/issues/7191
> "Replace Mutex to RWLock with fdcache_lock in FileStore"
>
> seem to be done, but I'm not sure it's already is the master branch ?

I believe this particular patch is still not merged (reviews etc on it
and some related things are in progress), but some other pieces of the
puzzle are in master (but not being backported to Firefly). In
particular, we've enabled an "ms_fast_dispatch" mechanism which
directly queues ops from the Pipe thread into the "OpWQ" (rather than
going through a DispatchQueue priority queue first), and we've sharded
the OpWQ. In progress but coming soonish are patches that should
reduce the CPU cost of lfn_find and related FileStore calls, as well
as sharding the fdcache lock (unless that one's merged already; I
forget).
And it turns out the "xattr spillout" patches to avoid doing so many
LevelDB accesses were broken, and those are fixed in master (being
backported to Firefly shortly).

So there's a fair bit of work going on to address most all of those
noted bottlenecks; if you're interested in it you probably want to run
tests against master and try to track the conversations on the Tracker
and ceph-devel. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
