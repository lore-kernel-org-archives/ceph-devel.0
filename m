From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: boost submodule update
Date: Wed, 5 Oct 2016 13:27:58 -0400 (EDT)
Message-ID: <875100430.1764088.1475688478169.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to> <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com> <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com> <CALqRxCz0rH+DNmb3M0MCuz9pYd8S=WtgAHx5QjaXCAfunwrsfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:46563 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754758AbcJER17 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Oct 2016 13:27:59 -0400
In-Reply-To: <CALqRxCz0rH+DNmb3M0MCuz9pYd8S=WtgAHx5QjaXCAfunwrsfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sorry.  The outcome of upstream discussion was to prefer to use the bundled Boost unless overridden.  It might make sense to override when we know a platform has a Boost version >= the expected, and the complement of that case I thought likely not to happen.

Matt

----- Original Message -----
> From: "Ken Dreyer" <kdreyer@redhat.com>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, October 5, 2016 1:23:20 PM
> Subject: Re: boost submodule update
> 
> Hi Matt,
> 
> I'm not following? You're doubtful that what will arise?
> 
> - Ken
> 
> On Fri, Sep 30, 2016 at 6:42 AM, Matt Benjamin <mbenjamin@redhat.com> wrote:
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
> >> >  * There is still the option to use a system boost via a cmake option.
> >> >  I
> >> > doubt anyone will opt for this in practice given the distros tend to
> >> > lag,
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
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
