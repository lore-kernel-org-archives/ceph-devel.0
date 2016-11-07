From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: ceph-disk and /dev/dm-* permissions - race condition?
Date: Mon, 7 Nov 2016 15:09:55 -0500
Message-ID: <CAGbvivJgNhEFLjAYst-zBCVLFxC0U4ZVHP=v+fXBrUDSfOauvA@mail.gmail.com>
References: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
 <CADEhWsOYJeq3kVUL31fzsCmi6E2jueYQsy08OV+jXx-waqZe5w@mail.gmail.com> <CAGbvivKV1RNfUETQuKaAhGcRz98dNrCO-X8ha_a9CveFhXbNNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35668 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbcKGUJ6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 15:09:58 -0500
Received: by mail-it0-f53.google.com with SMTP id e187so112696680itc.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2016 12:09:57 -0800 (PST)
In-Reply-To: <CAGbvivKV1RNfUETQuKaAhGcRz98dNrCO-X8ha_a9CveFhXbNNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajib Hossen <rajib.hossen.ipvision@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

The workaround to put "@reboot chown -R ceph:ceph /dev/vdb1" in
crontab doesn't work because the /dev/dm-* devices change ownership
after they start up.

Im not sure of all of the interactions between ceph-osd and udev and
the /dev/mapper for handling encrypted partitions, but somewhere late
in the startup process just after ceph-osd has started running, the
permissions on the /dev/dm-* devices change from ceph:ceph to
"root:disk" which makes it impossible for an an OSD process to ever
restart again due to not being able to read the encrypted journal.

My workaround was to add a line to the udev 55-dm.rules file just
before the 'GOTO="dm_end"' line towards the end of that file:
OWNER:="ceph", GROUP:="ceph", MODE:="0660"

Even though this workaround seems to work for our situation, I still
maintain that there is a bug in the ceph-osd startup sequence that is
causing the ownership to change back to "root:disk" where it should be
"ceph:ceph".

Wyllys Ingersoll
Keeper Technology, LLC



On Sat, Nov 5, 2016 at 8:36 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
>
> Thats an interesting workaround, I may end up using it if all else fails.
>
> I watch the permissions on /dev/dm-* devices during the boot
> processes, they start out correctly as "ceph:ceph", but at the end of
> the ceph disk preparation, a "ceph-disk trigger" is executed which
> seems to cause the permissions to get reset back to "root:disk".  This
> leaves the ceph-osd processes that are running able to continue, but
> if they have to restart for any reason, they will fail to restart.
>
> It could be a problem with the udev rules for the encrypted data and
> journal partitions.  Debugging udev is a nightmare.  Im hoping someone
> else has already solved this one.
>
>
>
> On Sat, Nov 5, 2016 at 1:13 AM, Rajib Hossen
> <rajib.hossen.ipvision@gmail.com> wrote:
> > Hello,
> > I had the similar issue. I solved it via a cronjob. In crontab -e
> > "@reboot chown -R ceph:ceph /dev/vdb1". say my journal is in disk vdb and
> > first partition(vdb1). vdb2 is my data disk.
> >
> > On Fri, Nov 4, 2016 at 8:51 PM, Wyllys Ingersoll
> > <wyllys.ingersoll@keepertech.com> wrote:
> >>
> >> We are running 10.2.3 with encrypted OSDs and journals using the old
> >> (i.e. non-Luks) keys and are seeing issues with the ceph-osd processes
> >> after a reboot of a storage server.  Our data and journals are on
> >> separate partitions on the same disk.
> >>
> >> After a reboot, sometimes the OSDs fail to start because of
> >> permissions problems.  The /dev/dm-* devices come back with
> >> permissions set to "root:disk" sometimes instead of "ceph:ceph".
> >> Weirder still is that sometimes the ceph-osd will start and work in
> >> spite of the incorrect perrmissions (root:disk) and other times they
> >> will fail and the logs show permissions errors when trying to access
> >> the journals. Sometimes half of the /dev/dm- devices are "root:disk"
> >> and others are "ceph:ceph".  There's no clear pattern, so that's what
> >> leads me to think its a race condition in the ceph_disk "dmcrypt_map"
> >> function.
> >>
> >> Is there a known issue with ceph-disk and/or ceph-osd related to
> >> timing of the encrypted devices being setup and the permissions
> >> getting changed to the ceph processes can access them?
> >>
> >> Wyllys Ingersoll
> >> Keeper Technology, LLC
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
