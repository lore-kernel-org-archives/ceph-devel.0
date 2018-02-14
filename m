From: Alfredo Deza <adeza@redhat.com>
Subject: Re: 12.2.3 QE Luminous validation status
Date: Wed, 14 Feb 2018 11:46:11 -0500
Message-ID: <CAC-Np1ywR_rnOfcQJohZ_TGzBiG-TpH7_XT-BN34rBEQrB0TzA@mail.gmail.com>
References: <CAMMFjmHppXYtqbUA7a6DE3g2fH_pF60BzMtKPhW6y1uVGru0Nw@mail.gmail.com>
 <CAMMFjmFmkFGy4HnzbDedMFHKcN4Ww1At27SAwJWz1j5Bj2LPwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:42967 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032720AbeBNQqM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Feb 2018 11:46:12 -0500
Received: by mail-qt0-f174.google.com with SMTP id k25so2470138qtj.9
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 08:46:11 -0800 (PST)
In-Reply-To: <CAMMFjmFmkFGy4HnzbDedMFHKcN4Ww1At27SAwJWz1j5Bj2LPwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, Karol Mroz <KMroz@suse.com>, Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>

On Wed, Feb 14, 2018 at 11:39 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> re: upgrade/kraken-x we need kraken fix merged for
> http://tracker.ceph.com/issues/22740
>
> Jason, will you approve or merge that PR for 12.2.3?
>
> On Tue, Feb 13, 2018 at 1:36 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Details of this release summarized here
>> http://tracker.ceph.com/issues/22665#note-4
>>
>> The following suites included:
>>
>> rados
>> rgw
>> rbd
>> krbd
>> fs
>> kcephfs
>> multimds
>> knfs
>> hadoop - EXCLUDED
>> samba - EXCLUDED
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade-hammer (luminous)
>> upgrade/client-upgrade-kraken (luminous)
>> upgrade/client-upgrade-jewel (luminous)
>> upgrade/jewel-x (luminous)
>> upgrade/kraken-x (luminous)
>> upgrade/luminous-x (master) - EXCLUDED
>> powercycle
>> ceph-ansible
>> ceph-volume
>> (please speak up if something is missing)
>>
>> Please see all details in the ticket and add comments in the tracker.
>>
>> Seeking approval from the dev leads.
>>
>> Issues:
>>
>> rados - passed, Josh pls confirm approval.
>>
>> rgw - Casey, Abhishek - do we want to ad//merge
>> https://github.com/ceph/ceph/pull/20407 ?
>>
>> rbd, krbd - approved by Jason
>>
>> fs, kcephfs, multimds - approved by Patrick
>>
>> knfs - pending review/approval from Jeff (http://tracker.ceph.com/issues/22995)
>>
>> ceph-deploy - approved by Vasu
>>
>> upgrade/client-upgrade-kraken - Nathan, do/can we include your fix
>> into this release ?
>>
>> upgrade/kraken-x (luminous) - some jobs still rerunning
>>
>> upgrade/luminous-x (master) - Sage you to exclude this suite for now?
>>
>> ceph-volume - pending approval from  Alfredo, Andrew
ceph-volume is good to go, both PRs got everything passing and merged today

https://github.com/ceph/ceph/pull/20429
https://github.com/ceph/ceph/pull/20438
>>
>> Pls reply
>>
>> Thx
>> YuriW
