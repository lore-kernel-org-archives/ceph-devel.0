From: Casey Bodley <cbodley@redhat.com>
Subject: Re: [ceph-users] Luminous 12.2.3 release date?
Date: Wed, 31 Jan 2018 10:45:18 -0500
Message-ID: <559205dd-6a54-c9f9-5623-0736cf475824@redhat.com>
References: <6016e4d0-5a52-466f-1573-ecd0844b3ec5@42on.com>
 <CALe9h7ciamCzNhJCfzNLbdvtPUEo4X6LQuMt_mCc+Yfj8M9S0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44588 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeAaPpV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jan 2018 10:45:21 -0500
Received: by mail-qt0-f175.google.com with SMTP id l20so22319409qtj.11
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jan 2018 07:45:21 -0800 (PST)
In-Reply-To: <CALe9h7ciamCzNhJCfzNLbdvtPUEo4X6LQuMt_mCc+Yfj8M9S0w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/31/2018 07:12 AM, John Spray wrote:
> (taking to ceph-devel)
>
> I've done a pass of the luminous backports for mgr and made sure the
> ones I think are important are merged.  There were a few ugly bugs in
> there, so I would quite like a 12.2.3 release soon too.
>
> Anyone else have fixes they're waiting for?

yeah, rgw bug fixes have been piling up too. i'd love to see a release soon

> John
>
> On Tue, Jan 30, 2018 at 9:35 AM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> Is there a ETA yet for 12.2.3? Looking at the tracker there aren't that many
>> outstanding issues: http://tracker.ceph.com/projects/ceph/roadmap
>>
>> On Github we have more outstanding PRs though for the Luminous milestone:
>> https://github.com/ceph/ceph/milestone/10
>>
>> Are we expecting 12.2.3 in Feb? I'm asking because there are some Mgr
>> related fixes I'm backporting now for a few people which are in 12.2.3.
>>
>> Wido
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

