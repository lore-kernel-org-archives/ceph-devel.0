From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: widening Messenger::create
Date: Thu, 29 Jan 2015 12:13:27 -0500 (EST)
Message-ID: <1251857046.66.1422551607854.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CACJqLyb1Vyf+Eb+fUtEYeBxRvFgiS1nN0gTdcQtTbF5ocgAXVQ@mail.gmail.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3634 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbbA2RNd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 12:13:33 -0500
In-Reply-To: <CACJqLyb1Vyf+Eb+fUtEYeBxRvFgiS1nN0gTdcQtTbF5ocgAXVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

There is obvious overlap with policy, but policy is currently not well
structured for this use.

Changing or extending the policy interface seemed plausible, but also seemed
likely to run into more objections.

Matt

----- "Haomai Wang" <haomaiwang@gmail.com> wrote:

> I think it may better that Messenger impl can introspect itself by
> "type", "policy", config and related infos?
> 
> On Fri, Jan 30, 2015 at 12:44 AM, Matt W. Benjamin <matt@cohortfs.com>
> wrote:
> > Hi,
> >
> > ----- "Sage Weil" <sage@newdream.net> wrote:
> >
> >> On Thu, 29 Jan 2015, Matt W. Benjamin wrote:
> >> > Hi,
> >> >
> >> > I'm looking at ways to pass potentially messenger-specific
> options
> >> through the Messenger factory.
> >> > The immediate parameter I need to provide is the number of
> Accelio
> >> portals to set up (this should
> >> > vary by Messenger instance), but I expect others will be needed
> in
> >> future.  I don't think this fits
> >> > cleanly on to the Policy mechanism, though I looked at that.  I
> >> think I'd like to provide a
> >> > generalized argument to the Messenger factory, which can do the
> >> right thing for a given Messenger
> >> > (e.g., constructor).
> >>
> >> In the past we've mostly gotten away with impl-specific config
> >> options.
> >> Is that not sufficient here?  Because you need to pass different
> >> parameters to different instances maybe?
> >
> > Yes, exactly.
> >
> >>
> >> sage
> >
> >
> > --
> > Matt Benjamin
> > CohortFS, LLC.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://cohortfs.com
> >
> > tel.  734-761-4689
> > fax.  734-769-8938
> > cel.  734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
