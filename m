From: Sage Weil <sweil@redhat.com>
Subject: Re: kraken rc is out, and kraken is branched!
Date: Wed, 14 Dec 2016 14:43:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612141442570.10615@piezo.novalocal>
References: <alpine.DEB.2.11.1612132349030.343@piezo.novalocal> <CAGkCoNKdkOnV8+aDdwcuo6ah36Ddy3EC=gxyZiJf8V8f9+FcPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16921 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754768AbcLNOoE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 09:44:04 -0500
In-Reply-To: <CAGkCoNKdkOnV8+aDdwcuo6ah36Ddy3EC=gxyZiJf8V8f9+FcPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 14 Dec 2016, Zhi Zhang wrote:
> Hi Sage, or others,
> 
> Just a quick question. Which ceph version will be the next long term
> support after Hammer? Jewel or Kraken or both?

Jewel.  The next LTS after that will be Luminous, which is due out in the 
spring.

You can find this information here:

	http://docs.ceph.com/docs/master/releases/

sage

> We are using Hammer on production, but still met some bugs which have
> been fixed in higher ceph version. And some of the bug fixes are
> really not easy to backport because of the code base those fixes
> depend on, so we have to fix them or workaround them in our internal
> code base. We would like to try avoiding such things later after we
> choose a higher version to upgrade. So want to ask for some
> suggestions here with stability, compatibility and long-term
> supporting into consideration.
> 
> Thanks a lot.
> 
> Regards,
> Zhi Zhang (David)
> Contact: zhang.david2011@gmail.com
>               zhangz.david@outlook.com
> 
> 
> On Wed, Dec 14, 2016 at 7:51 AM, Sage Weil <sweil@redhat.com> wrote:
> > Please continue to target PRs at master; we will cherry-pick -x them to
> > kraken.  This isn't quite what we usually do (if there is a "usually"
> > here), but for RBD we are reverting some half-completed features and we
> > don't want those to get merged back into master.
> >
> > Thanks!
> > sage
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
