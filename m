From: Sage Weil <sweil@redhat.com>
Subject: Re: boost submodule update
Date: Wed, 5 Oct 2016 13:25:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610051322430.19850@piezo.us.to>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to> <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com> <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com> <20161005023148.GC6047@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbcJENZK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Oct 2016 09:25:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBFA36A6AC
        for <ceph-devel@vger.kernel.org>; Wed,  5 Oct 2016 13:25:09 +0000 (UTC)
In-Reply-To: <20161005023148.GC6047@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 5 Oct 2016, Brad Hubbard wrote:
> I acknowledge what Sage says about most of boost being header only but I still
> feel compelled to offer some input here.
> 
> https://www.akkadia.org/drepper/no_static_linking.html
> https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7-Beta/html-single/Developer_Guide/index.html#lib.compatibility.static
> 
> I guess we are aware of these pain points and have decided "it's worth it"?

I don't see anything on those lists that would meaningfully apply to (the 
small fraction of) boost (that links dynamically).  I'm not really the 
expert here, though... anybody else?

sage



> 
> -- 
> Cheers,
> Brad
> 
> On Fri, Sep 30, 2016 at 10:42 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> > Hi Ken,
> >
> > I'm doubtful that case will arise in practice?
> >
> > Matt
> >
> > ----- Original Message -----
> >> From: "Ken Dreyer" <kdreyer@redhat.com>
> >> To: "Sage Weil" <sweil@redhat.com>
> >> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> >> Sent: Thursday, September 29, 2016 6:42:48 PM
> >> Subject: Re: boost submodule update
> >>
> >> On Thu, Sep 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
> >> >  * There is still the option to use a system boost via a cmake option.  I
> >> > doubt anyone will opt for this in practice given the distros tend to lag,
> >> > but they can if they want.
> >>
> >> Can we have it automatically enable the system boost if it's > 1.6.1?
> >> Otherwise I'm afraid no one will set WITH_SYSTEM_BOOST :)
> >>
> >> Fedora 26 or 27 will probably have Boost 1.6.2+
> >> (https://bugzilla.redhat.com/1374088)
> >>
> >> - Ken
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > --
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://www.redhat.com/en/technologies/storage
> >
> > tel.  734-707-0660
> > fax.  734-769-8938
> > cel.  734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
