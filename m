From: Jeff Layton <jlayton@redhat.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Tue, 13 Feb 2018 16:59:54 -0500
Message-ID: <1518559194.4756.6.camel@redhat.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
         <7fded75b-a345-5265-4428-0ddce89241a8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33956 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965871AbeBMV76 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 16:59:58 -0500
Received: by mail-qt0-f170.google.com with SMTP id d14so5422211qtg.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 13:59:57 -0800 (PST)
In-Reply-To: <7fded75b-a345-5265-4428-0ddce89241a8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>

On Tue, 2018-02-13 at 16:41 -0500, Casey Bodley wrote:
> 
> On 02/13/2018 04:36 PM, Yuri Weinstein wrote:
> > Details of this release summarized here
> > http://tracker.ceph.com/issues/22665#note-4
> > 
> > The following suites included:
> > 
> > rados
> > rgw
> > rbd
> > krbd
> > fs
> > kcephfs
> > multimds
> > knfs
> > hadoop - EXCLUDED
> > samba - EXCLUDED
> > ceph-deploy
> > ceph-disk
> > upgrade/client-upgrade-hammer (luminous)
> > upgrade/client-upgrade-kraken (luminous)
> > upgrade/client-upgrade-jewel (luminous)
> > upgrade/jewel-x (luminous)
> > upgrade/kraken-x (luminous)
> > upgrade/luminous-x (master) - EXCLUDED
> > powercycle
> > ceph-ansible
> > ceph-volume
> > (please speak up if something is missing)
> > 
> > Please see all details in the ticket and add comments in the tracker.
> > 
> > Seeking approval from the dev leads.
> > 
> > Issues:
> > 
> > rados - passed, Josh pls confirm approval.
> > 
> > rgw - Casey, Abhishek - do we want to ad//merge
> > https://github.com/ceph/ceph/pull/20407 ?
> 
> yes please - that one was identified as a qa suite fix for a multisite 
> test failure in the last round of testing
> 
> > 
> > rbd, krbd - approved by Jason
> > 
> > fs, kcephfs, multimds - approved by Patrick
> > 
> > knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)
> > 

So, we have two recent test runs, both with 2 failures:

The first run had one failure due to OSD_DOWN being in the logs, and
another due to what looks like a softlockup in the kernel on one of the
nodes. No stack trace to go with the softlockup, so I have no idea what
went wrong there. The second run just shows two OSD_DOWN failures. For
now I don't see anything that looks directly related to knfsd on either
of these.

Yuri looked and saw that we have a lot of failing runs on this suite so
it may be that this is just a broken test. I'll look more closely
tomorrow and see if I can figure out whether that's the case or whether
there is a real bug here.

Cheers,
 
> > ceph-deploy - approved by Vasu
> > 
> > upgrade/client-upgrade-kraken - Nathan, do/can we include your fix
> > into this release ?
> > 
> > upgrade/kraken-x (luminous) - some jobs still rerunning
> > 
> > upgrade/luminous-x (master) - Sage you to exclude this suite for now?
> > 
> > ceph-volume - pending approval from  Alfredo, Andrew
> > 
> > Pls reply
> > 
> > Thx
> > YuriW
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>
