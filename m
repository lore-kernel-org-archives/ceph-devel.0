From: Sage Weil <sweil@redhat.com>
Subject: Re: OSD creation and device class
Date: Mon, 10 Apr 2017 13:49:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704101347260.2999@piezo.novalocal>
References: <9c19c5c5-8640-63d3-debd-7105e16ceb75@dachary.org> <alpine.DEB.2.11.1704101327320.2999@piezo.novalocal> <da8a2939-332d-5670-7a46-7e9432b27cb2@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-696905710-1491832173=:2999"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbdDJNte (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Apr 2017 09:49:34 -0400
In-Reply-To: <da8a2939-332d-5670-7a46-7e9432b27cb2@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: joao@suse.de, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-696905710-1491832173=:2999
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Mon, 10 Apr 2017, Loic Dachary wrote:
> On 04/10/2017 03:32 PM, Sage Weil wrote:
> > On Mon, 10 Apr 2017, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> When the OSD is prepared, we add a --device-class option to ceph-disk 
> >> that creates a device_class file and activate can use it use when 
> >> creating the the OSD[1]. The ceph osd create command is given an 
> >> additional optional argument (device class). If the device class 
> >> argument is present, ceph osd create[2] creates a device entry in the 
> >> crushmap (it currently does nothing with the crushmap) so that the 
> >> corresponding device class can be preserved. This happens before 
> >> update_crush_location[3] is called and since the device is not included 
> >> in any crush tree it won't be used.
> >>
> >> I'm not happy about adding an argument to osd create. We could instead 
> >> have a new dedicated command create-with-device-class but I like that 
> >> even less. We could also add a "ceph osd crush create-device" and have 
> >> ceph-disk call it right after "ceph osd create", followed by "ceph osd 
> >> crush set-device-class". That would be my second favorite: the only 
> >> drawback is having a multi-step device creation during activation but 
> >> all steps are idempotents that should not be a problem.
> >>
> >> What do you think ?
> > 
> > We're aiming toward a new osd create command anyway that does all of this 
> > stuff at once (create osd id and set uuid, set cephx key, set lockbox key 
> > for dmcrypt, add to crush map).  Having it also set the device class seems 
> > like an easy addition.  I believe Joao has started or is about to start 
> > work on this?
> > 
> > In the meantime, I would do the simplest thing, which is probably just 
> > calling 'ceph osd crush set-device-class'.  It could be done before the 
> > 'osd crush create-or-move' in OSD::update_crush_location(), 
> 
> Does that mean we should have a --device-class argument to ceph-osd --mkfs ? Or is there another way I'm not seeing ?

If you're putting a file in the osd_data directory, you can use 
ObjectStore::read_meta() (and/or write_meta()) to easily access it.

Thinking about this a bit more, if the admin has explicitly specified the 
type like this, I don't think we need to worry about set-but-do-not-change 
behavior like I suggested below...

sage

> 
> > but then we'd 
> > probably want to make it only set it if a device class isn't already set 
> > (i.e., don't change it if the admin set it to something else).  Or at some 
> > convenient point during the initial activation that similarly avoids 
> > clobbering the value if the admin set it...
> > 
> > sage
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--8323329-696905710-1491832173=:2999--
