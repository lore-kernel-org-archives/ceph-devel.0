From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: boost submodule update
Date: Fri, 30 Sep 2016 08:42:28 -0400 (EDT)
Message-ID: <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to> <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:50156 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbcI3Mm3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Sep 2016 08:42:29 -0400
In-Reply-To: <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Ken,

I'm doubtful that case will arise in practice?

Matt

----- Original Message -----
> From: "Ken Dreyer" <kdreyer@redhat.com>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, September 29, 2016 6:42:48 PM
> Subject: Re: boost submodule update
> 
> On Thu, Sep 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
> >  * There is still the option to use a system boost via a cmake option.  I
> > doubt anyone will opt for this in practice given the distros tend to lag,
> > but they can if they want.
> 
> Can we have it automatically enable the system boost if it's > 1.6.1?
> Otherwise I'm afraid no one will set WITH_SYSTEM_BOOST :)
> 
> Fedora 26 or 27 will probably have Boost 1.6.2+
> (https://bugzilla.redhat.com/1374088)
> 
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
