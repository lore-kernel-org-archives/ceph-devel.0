From: John Spray <jspray@redhat.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to crush_location_hook
Date: Mon, 23 Oct 2017 14:29:49 +0200
Message-ID: <CALe9h7fO0d8NFoA4=1XjqKM9bX2rfCKDEaUnzH+9Ackh-o=32Q@mail.gmail.com>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl>
 <CABZ+qq=pnAjbDKVfHkH_=G3yLpU4-=Ko_Qvyqq8x7XfQ5=pQjw@mail.gmail.com>
 <alpine.DEB.2.11.1710191331210.24806@piezo.us.to> <1075089278.3447.1508741633932@ox.pcextreme.nl>
 <alpine.DEB.2.11.1710231210310.16763@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:53197 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbdJWMaL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 08:30:11 -0400
Received: by mail-wr0-f172.google.com with SMTP id k62so17173745wrc.9
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 05:30:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710231210310.16763@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@42on.com>, Dan van der Ster <dan@vanderster.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 23, 2017 at 2:11 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 23 Oct 2017, Wido den Hollander wrote:
>> > Op 19 oktober 2017 om 15:34 schreef Sage Weil <sage@newdream.net>:
>> >
>> >
>> > On Thu, 19 Oct 2017, Dan van der Ster wrote:
>> > > Hi Wido,
>> > >
>> > > Unexpected crush location changes can indeed be quite nasty.
>> > >
>> > > With this in mind, I wonder if a crush lock would be useful.
>> > >
>> > >     ceph osd set nocrushchange
>> > >
>> > > With that flag set, osds could still go in and out, but crush
>> > > move/add/remove/etc..., also tunables changes, would be blocked.
>> >
>> > The problem I see with this is that it would prevent new OSD additions or
>> > other changes.. and if you went to unset the flag in order to allow a new
>> > node to be adjusted or brought online then you might get an avalance of
>> > blocked changes.
>> >
>> > I think what we actually want is a more targetted variation of
>> > osd_crush_update_on_start that only updates teh location if it has never
>> > been set (i.e., it is a new osd).  Like, osd_crush_update_on_create.  Then
>> > it's left to the admin to move OSDs?
>> >
>> > > On Mon, Oct 16, 2017 at 2:02 PM, Wido den Hollander <wido@42on.com> wrote:
>> > > > Hi,
>> > > >
>> > > > I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.
>> > > >
>> > > > When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.
>> > > >
>> > > > Was this an oversight with Luminous or was it intentional?
>> >
>> > The implications are an oversight.. I didn't think about customized hooks
>> > that would get reverted if the config option wasn't changed.  Otherwise
>> > the item in the release notes would have read more like a warning:
>> >
>> > * The `osd crush location` config option is no longer supported.  Please
>> >   update your ceph.conf to use the `crush location` option instead.
>> >
>>
>> Yes, we probably need a big warning for this in the ReleaseNotes.
>>
>> Are you going to make sure it goes in?
>
> https://github.com/ceph/ceph/pull/18482
>
> I think we also want to make the old config option work too; that isn't
> done yet.  John, I wonder if it is worth adding an 'alias' mechanism
> into the options framework, so that all users of the option don't have to
> check for the old and new?

The thought crossed my mind -- it's a little awkward for someone who
dumps back their config, as they'll see a differently named option
than the one they thought they set.  However, I think it's worth it on
balance: I'm a fan of thing that enable us to sanitize the naming.

The alias field should come with a mandatory version field that says
which version the old alias was from, so that we can systematically
remove them a couple versions later.

John

>
> sage
>
