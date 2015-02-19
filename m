From: Sage Weil <sweil@redhat.com>
Subject: Re: Standardization of perf counters comments
Date: Thu, 19 Feb 2015 08:10:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502190805230.3074@cobra.newdream.net>
References: <loom.20150211T183150-492@post.gmane.org> <CAC6JEv-YDNstmoGBFG0yNhgw5DOkTCDY2=2bKK1z-5Az4hqfKQ@mail.gmail.com> <CAGd4Wr2MD0JYK0xa_P4E4K6gv47K0RusRrmnaPT-RZh00j=OKA@mail.gmail.com> <CAONhiy6T2OGNDL03vR321HQ8tniTqcCPrO0LeRO9OBfjDOB-vw@mail.gmail.com>
 <CAONhiy6brVPQtFddUxOTYc1u8YDjdQ-oePcSO0kykteWP_bzig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbBSQKM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Feb 2015 11:10:12 -0500
In-Reply-To: <CAONhiy6brVPQtFddUxOTYc1u8YDjdQ-oePcSO0kykteWP_bzig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>
Cc: John Spray <john.spray@redhat.com>, Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 19 Feb 2015, Alyona Kiselyova wrote:
> I made a commit on this feature on my fork and I would like to have
> some feedback :)
> https://github.com/Ved-vampir/ceph/commit/b09abb08ed4b26da19ebe5eae733e03c94e2bc8f\

A few minor comments:

 - I would call it "description" instead of "help"
 - separate out the win/lose correction into a separate patch
 - make one patch add the description field and default arg
 - add actual descriptions in additional patch(es)

> It contains new functionality for perfcounterbuilder class and
> comments for some counters as example.
> I permanently add a default value to parameter: to comment all
> counters is a long work due to their count and I want to have
> successful compilation.
> What do you say about this?
> Should I continue in the same way, or something is wrong?

It looks good!

> And another question: if it's ok, should I comment all counters and
> then create a pool request (it will be large and, may be, difficult to
> review) or better is to create it on every one-two commented files (in
> this case default value will exist before all counters will have their
> descriptions)?

If they're separated into different patches they'll be easy to review.  I 
don't think it matters too much whether we merge them all in one pull 
request or over time... that probably mostly depends on how motivated you 
are to go document all of them :)

Thanks!
sage




> -------------------------------
> Best regards,
> Alyona Kiseleva
> 
> 
> On Thu, Feb 12, 2015 at 1:09 PM, Alyona Kiselyova
> <akiselyova@mirantis.com> wrote:
> > I think, it is a good idea to have both detailed and short description
> > with link in second.
> > But, may be, it isn't bad to start with a simple way - adding
> > functionality to extend schema, and continue with improving it with
> > detailed description in docs.
> >
> > Yes, I agree, that required parameter is better, but if we will be
> > feeling not very conscientious, this required string may contain
> > something useless too :)
> > -------------------------------
> > Best regards,
> > Alyona Kiseleva
> >
> >
> > On Wed, Feb 11, 2015 at 9:39 PM, John Spray <john.spray@redhat.com> wrote:
> >> On Wed, Feb 11, 2015 at 6:02 PM, Gregory Farnum <greg@gregs42.com> wrote:
> >>> On Wed, Feb 11, 2015 at 9:33 AM, Alyona Kiseleva
> >>> <akiselyova@mirantis.com> wrote:
> >>>> Hi,
> >>>> I would like to propose something.
> >>>>
> >>>> There are a lot of perf counters in different places in code, but the most
> >>>> of them are undocumented. I found only one commented counter in OSD.cc code,
> >>>> but not for all metrics. Name of counter is not very clear as it's
> >>>> description, sometimes isn't at all.
> >>>>
> >>>> So, I have an idea, that it would be great, if perf schema would contain not
> >>>> only the counter type, but some description too. It can be added in
> >>>> PerfCountersBuilder methods - at first as optional parameter with empty
> >>>> string by default, later, may be, as required parameter. This short
> >>>> description could be saved in perf_counter_data_any_d struct together with
> >>>> other counter properties and appear in perf schema as the second counter
> >>>> property.
> >>
> >> There will be lots of counters that aren't usefully describable in a
> >> single sentence.  That doesn't excuse them from being documented, but
> >> we should be careful to avoid generating useless tautological strings
> >> like num_strays_delayed -> "Number of strays currently that are
> >> currently delayed".  For lots of things, an understandable definition
> >> will require some level of introduction of terms and concepts -- in my
> >> example, what's a stray?  what does it mean for it to be delayed?
> >>
> >> While we shouldn't hold up the descriptions waiting for documentation
> >> that explains all the needed concepts, we should think about how that
> >> will fit together.  Perhaps, rather than having a single string in the
> >> code, we should look to create a separate metadata file that allows
> >> richer RST docs for each setting, and verify that all settings are
> >> described during the docs build (i.e. a gitbuilder fail will tell us
> >> if someone added a setting without the associated documentation).
> >> That way, the short perfcounter descriptions could include hyperlinks
> >> to related concepts elsewhere in the docs.
> >>
> >> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
