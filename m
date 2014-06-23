From: Milosz Tanski <milosz@adfin.com>
Subject: Re: CEPH IOPS Baseline Measurements with MemStore
Date: Mon, 23 Jun 2014 16:33:03 -0400
Message-ID: <CANP1eJG2a1tg6wMs1o1HNL_nn3MWtpduot-X5HRxX6Vi11OBPQ@mail.gmail.com>
References: <36031eee-ed15-448d-8f84-ae940f627dbc@mailpro>
	<ae132423-84b1-490c-b36e-e29ee226c8e5@mailpro>
	<CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:54983 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbaFWUdF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 16:33:05 -0400
Received: by mail-we0-f180.google.com with SMTP id x48so7482376wes.25
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jun 2014 13:33:04 -0700 (PDT)
In-Reply-To: <CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

I'm working on getting mutrace going on the OSD to profile the hot
contented lock paths in master. Hopefully I'll have something soon.

On Mon, Jun 23, 2014 at 1:41 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Fri, Jun 20, 2014 at 12:41 AM, Alexandre DERUMIER
> <aderumier@odiso.com> wrote:
>> They are also a tracker here
>> http://tracker.ceph.com/issues/7191
>> "Replace Mutex to RWLock with fdcache_lock in FileStore"
>>
>> seem to be done, but I'm not sure it's already is the master branch ?
>
> I believe this particular patch is still not merged (reviews etc on it
> and some related things are in progress), but some other pieces of the
> puzzle are in master (but not being backported to Firefly). In
> particular, we've enabled an "ms_fast_dispatch" mechanism which
> directly queues ops from the Pipe thread into the "OpWQ" (rather than
> going through a DispatchQueue priority queue first), and we've sharded
> the OpWQ. In progress but coming soonish are patches that should
> reduce the CPU cost of lfn_find and related FileStore calls, as well
> as sharding the fdcache lock (unless that one's merged already; I
> forget).
> And it turns out the "xattr spillout" patches to avoid doing so many
> LevelDB accesses were broken, and those are fixed in master (being
> backported to Firefly shortly).
>
> So there's a fair bit of work going on to address most all of those
> noted bottlenecks; if you're interested in it you probably want to run
> tests against master and try to track the conversations on the Tracker
> and ceph-devel. :)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
