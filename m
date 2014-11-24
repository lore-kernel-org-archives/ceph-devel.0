From: John Spray <john.spray@redhat.com>
Subject: Re: Where do MDSHealthMetrics show up?
Date: Mon, 24 Nov 2014 10:05:31 +0000
Message-ID: <CAGd4Wr0StfpqEJMPKm_Ym3+=JZ2mp=thBU=A=_gRzpR-rL=78w@mail.gmail.com>
References: <CAD=PzHKrzs9Wx-pjONM+nL_eoO8+0crr-_K1iVT_PrMJJdr5bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:55646 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaKXKFd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 05:05:33 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so1538352lbv.11
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 02:05:31 -0800 (PST)
In-Reply-To: <CAD=PzHKrzs9Wx-pjONM+nL_eoO8+0crr-_K1iVT_PrMJJdr5bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 21, 2014 at 1:54 AM, Michael Sevilla <mikesevilla3@gmail.com> wrote:
> Hi. Where do the MDSHealthMetrics in MMDSBeacon (e.g.,
> MDS_HEALTH_TRIM) show up in the monitors? When we run ceph -s? I
> suspect I don't see them because I'd have to run ceph -s at the exact
> moment when the MDS is trimming. Is there an easier way to see these
> warning or is there some debug flag I need to turn on?

In the specific case of MDS_HEALTH_TRIM, this is aimed at detecting
systems that are trimming at a pathologically bad rate (or perhaps
stuck entirely due to a bug), so the in such an unhealthy system we
would expect the state to stick around for a while -- it shouldn't
just be a "blink and you miss it" status.  However, you would have to
look at the status sometime in the unhealthy period: there's currently
nothing in the cluster log for that health check.

For the new MDS health warnings, we have some overlapping coverage
between health indications (i.e. things that show up in "ceph -s") and
cluster log messages (i.e. things that show up in "ceph -w").  There
is a general problem here for the health stuff (not just for the MDS
things) that it is only generated on-demand when someone looks at it
-- e.g. things like clock skew also only show up if you happen to run
ceph -s at the right moment.  Internally this corresponds to the
various get_health() functions in the mon subsystems.

It would be good to have a generic way for health indicators (MDS and
beyond) to emit clog messages when they appear and disappear, so that
you don't have to look at the status at the right moment.  That would
be a little hard to implement at the moment because the health
messages are just freeform strings, but I put some notes on cleaning
up health reporting here a while back:
http://tracker.ceph.com/issues/7192

Cheers,
John
