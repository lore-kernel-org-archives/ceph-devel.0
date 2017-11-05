From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: 12.2.2 status
Date: Sun, 5 Nov 2017 13:17:45 +0100
Message-ID: <CAEw75dMUFUQ5JAd4LRX=ycjo0d0C7RmvqMq6d+=5qkKcaGf8ow@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
 <874lqbcl5p.fsf@suse.com> <alpine.DEB.2.11.1711031753520.23234@piezo.novalocal>
 <871slfckae.fsf@suse.com> <CAJE9aOMv3pNFbL3RA3=wiXJKGL9+Mx6N9BazApPZ9E9DMXVp2A@mail.gmail.com>
 <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:47800 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdKEMRr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Nov 2017 07:17:47 -0500
Received: by mail-io0-f181.google.com with SMTP id h70so12964227ioi.4
        for <ceph-devel@vger.kernel.org>; Sun, 05 Nov 2017 04:17:47 -0800 (PST)
In-Reply-To: <7fc4336c-40fc-848c-00f7-e7ebc8aa744c@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Kefu Chai <kchai@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, vumrao@redhat.com, Sage Weil <sweil@redhat.com>, Nathan Cutler <NCutler@suse.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Karol Mroz <KMroz@suse.com>

On Sat, Nov 4, 2017 at 8:51 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> all or nothing. if we want to backport the fix of
>> http://tracker.ceph.com/issues/21762, we will have to backport the
>> "debian: fix package relationships after" fixes. so i think pull/18589
>> is self-contained. and no additional step is needed.
>>
>> and per http://tracker.ceph.com/issues/21762, we need to have it in
>> luminous. but i have no strong opinion on including it in 12.2.2 or
>> post 12.2.2. Vikhyat and Nathan, what do you think?
>
>
> Yes, I tried to make 18589 self-contained by pulling in Kefu's and
> Abhishek's follow-on fixes. I think it would be nice to have it in 12.2.2.

Rebuilt the integration branch with the newer PR and it still fails
with the same reason
http://pulpito.ceph.com/abhi-2017-11-05_11:53:02-ceph-disk-wip-abhi-testing-2017-11-05-0933-distro-basic-vps/
for eg.

Kefu, are there any more commits we need to solve the dependency issue?

Thanks
Abhishek
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
