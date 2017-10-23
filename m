From: Wido den Hollander <wido@42on.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to
 crush_location_hook
Date: Mon, 23 Oct 2017 08:53:53 +0200 (CEST)
Message-ID: <1075089278.3447.1508741633932@ox.pcextreme.nl>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl>
 <CABZ+qq=pnAjbDKVfHkH_=G3yLpU4-=Ko_Qvyqq8x7XfQ5=pQjw@mail.gmail.com>
 <alpine.DEB.2.11.1710191331210.24806@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se04-out.mail.pcextreme.nl ([185.87.184.124]:49233 "EHLO
        se04-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751113AbdJWJUX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Oct 2017 05:20:23 -0400
In-Reply-To: <alpine.DEB.2.11.1710191331210.24806@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Dan van der Ster <dan@vanderster.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 19 oktober 2017 om 15:34 schreef Sage Weil <sage@newdream.net>:
> 
> 
> On Thu, 19 Oct 2017, Dan van der Ster wrote:
> > Hi Wido,
> > 
> > Unexpected crush location changes can indeed be quite nasty.
> > 
> > With this in mind, I wonder if a crush lock would be useful.
> > 
> >     ceph osd set nocrushchange
> > 
> > With that flag set, osds could still go in and out, but crush
> > move/add/remove/etc..., also tunables changes, would be blocked.
> 
> The problem I see with this is that it would prevent new OSD additions or 
> other changes.. and if you went to unset the flag in order to allow a new 
> node to be adjusted or brought online then you might get an avalance of 
> blocked changes.
> 
> I think what we actually want is a more targetted variation of 
> osd_crush_update_on_start that only updates teh location if it has never 
> been set (i.e., it is a new osd).  Like, osd_crush_update_on_create.  Then 
> it's left to the admin to move OSDs?
> 
> > On Mon, Oct 16, 2017 at 2:02 PM, Wido den Hollander <wido@42on.com> wrote:
> > > Hi,
> > >
> > > I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.
> > >
> > > When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.
> > >
> > > Was this an oversight with Luminous or was it intentional?
> 
> The implications are an oversight.. I didn't think about customized hooks 
> that would get reverted if the config option wasn't changed.  Otherwise 
> the item in the release notes would have read more like a warning:
> 
> * The `osd crush location` config option is no longer supported.  Please
>   update your ceph.conf to use the `crush location` option instead.
> 

Yes, we probably need a big warning for this in the ReleaseNotes.

Are you going to make sure it goes in?

Wido

> Sorry about that!
> 
> sage
