From: Sage Weil <sage@newdream.net>
Subject: Re: formatting bytes and object counts in ceph status ouput
Date: Tue, 9 Jan 2018 13:06:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801091256470.24931@piezo.novalocal>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop> <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com> <20180109094508.e3uyo6h2towppph6@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:42894 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757233AbeAINGn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jan 2018 08:06:43 -0500
In-Reply-To: <20180109094508.e3uyo6h2towppph6@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Fajerski <jfajerski@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-Users <ceph-users@ceph.com>

On Tue, 9 Jan 2018, Jan Fajerski wrote:
> On Tue, Jan 02, 2018 at 04:54:55PM +0000, John Spray wrote:
> > On Tue, Jan 2, 2018 at 10:43 AM, Jan Fajerski <jfajerski@suse.com> wrote:
> > > Hi lists,
> > > Currently the ceph status output formats all numbers with binary unit
> > > prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
> > > 1048576 objects.  I received a bug report from a user that printing object
> > > counts with a base 2 multiplier is confusing (I agree) so I opened a bug
> > > and
> > > https://github.com/ceph/ceph/pull/19117.
> > > In the PR discussion a couple of questions arose that I'd like to get some
> > > opinions on:
> > 
> > > - Should we print binary unit prefixes (MiB, GiB, ...) since that would be
> > > technically correct?
> > 
> > I'm not a fan of the technically correct base 2 units -- they're still
> > relatively rarely used, and I've spent most of my life using kB to
> > mean 1024, not 1000.
> We could start changing the "rarely used" part ;) But I can certainly live
> with keeping the old units.
> > 
> > > - Should counters (like object counts) be formatted with a base 10
> > > multiplier or  a multiplier woth base 2?
> > 
> > I prefer base 2 for any dimensionless quantities (or rates thereof) in
> > computing.  Metres and kilograms go in base 10, bytes go in base 2.
> > 
> > It's all very subjective and a matter of opinion of course, and my
> > feelings aren't particularly strong :-)
> As far as I understand the standards regarding this (IEC 60027, ISO/IEC 80000,
> probably more) are talking about base 2 units for digital data related units
> only. I might of course misunderstand.
> What is problematic I find is that other tools will (mostly?) use base 10
> units for everything not data related. Say I plot the object count of ceph in
> Grafana.  It'll use base 10 multipliers for a dimensionless number. Since
> Grafana (and I imagine other toolsllike this) consume raw numbers we'll end up
> with Grafana displaying a different object count then "ceph -s". Say 1.04M vs
> 1M. Now this is not terrible but it'll get worse with higher counts quickly.
> In the original tracker issue it's noted that this was reported with cluster
> containing 7150896726 objects. The difference from grafana to "ceph -s" was
> 7150M vs 6835M.

Right.

I find the *iB units annoying myself, and I'm not sure I'll ever be able 
to say "pebibyte" out loud, but I can't think of a good reason not to be 
correct and precise.

As a practical matter, I wonder if the PR should eliminate si_t entirely 
and replace it with dec_si_t and bin_si_t.  Or, since the binary units 
aren't actually SI units, replace si_t with dec_si_t (to be explicit!) and 
bin_unit_t, or {dec,bin}_unit_t, or similar.  I suspect that si_t vs iec_t 
or similar won't be sufficient for the developer to choose the right 
thing.

sage
