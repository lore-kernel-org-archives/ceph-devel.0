From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Wed, 13 Sep 2017 21:37:44 -0700
Message-ID: <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com>
 <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:46770 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdINEiQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 00:38:16 -0400
Received: by mail-io0-f173.google.com with SMTP id d16so13001926ioj.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 21:38:16 -0700 (PDT)
In-Reply-To: <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

On Wed, Sep 13, 2017 at 8:49 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> On Wed, Sep 13, 2017 at 8:40 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> This email is an attempt to make sure that all are clear on luminous
>> v12.2.1 release status.
>>
>> Dev leads - what is left before we can start QE validation?
>
> To be merged into master today and then backported:
> http://tracker.ceph.com/issues/21378
> Luminous backport: http://tracker.ceph.com/issues/21357
> To be merged into master today and then backported:
> http://tracker.ceph.com/issues/20594

Final list of CephFS backports needed for 12.2.1:

http://tracker.ceph.com/issues/21323
http://tracker.ceph.com/issues/21114
http://tracker.ceph.com/issues/21107
http://tracker.ceph.com/issues/21357
http://tracker.ceph.com/issues/21322
http://tracker.ceph.com/issues/21384

-- 
Patrick Donnelly
