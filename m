From: Abhishek <abhishek@suse.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Wed, 14 Feb 2018 12:00:04 +0100
Message-ID: <f974c18b4ad913359a935acfb72737c5@suse.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967114AbeBNLAG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:00:06 -0500
In-Reply-To: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, "Deza, Alfredo" <adeza@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-devel-owner@vger.kernel.org

On 2018-02-13 22:36, Yuri Weinstein wrote:
> Details of this release summarized here
> http://tracker.ceph.com/issues/22665#note-4
> 
> The following suites included:
> 
> rados
> rgw
> rbd
> krbd
> fs
> kcephfs
> multimds
> knfs
> hadoop - EXCLUDED
> samba - EXCLUDED
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade-hammer (luminous)
> upgrade/client-upgrade-kraken (luminous)
> upgrade/client-upgrade-jewel (luminous)
> upgrade/jewel-x (luminous)
> upgrade/kraken-x (luminous)
> upgrade/luminous-x (master) - EXCLUDED
> powercycle
> ceph-ansible
> ceph-volume
> (please speak up if something is missing)
> 
> Please see all details in the ticket and add comments in the tracker.
> 
> Seeking approval from the dev leads.
> 
> Issues:
> 
> rados - passed, Josh pls confirm approval.
> 
> rgw - Casey, Abhishek - do we want to ad//merge
> https://github.com/ceph/ceph/pull/20407 ?
> 
> rbd, krbd - approved by Jason
> 
> fs, kcephfs, multimds - approved by Patrick
> 
> knfs - pending review/approval from Jeff 
> (http://tracker.ceph.com/issues/22995)
> 
> ceph-deploy - approved by Vasu
> 
> upgrade/client-upgrade-kraken - Nathan, do/can we include your fix
> into this release ?
> 
> upgrade/kraken-x (luminous) - some jobs still rerunning
> 
> upgrade/luminous-x (master) - Sage you to exclude this suite for now?
> 
> ceph-volume - pending approval from  Alfredo, Andrew

Alfredo mentioned he's working on a critical fix that needs to go in for
12.2.3, waiting for merge + approval

PS. for some reason replies to this thread from my email always failed. 
Hopefully we don't get multiple copies of the same message.

> 
> Pls reply
> 
> Thx
> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

