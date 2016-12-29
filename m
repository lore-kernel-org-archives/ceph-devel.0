From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: problem with removing osd
Date: Fri, 30 Dec 2016 09:13:27 +1000
Message-ID: <CAF-wwdE9rnDbrXyxEaBfNShfvYpfmEzqunDz8b7in8Uf5cECZA@mail.gmail.com>
References: <16310616780.20161229160718@tlen.pl> <alpine.DEB.2.11.1612291908472.10615@piezo.novalocal>
 <109878557.20161229212030@tlen.pl> <alpine.DEB.2.11.1612292025280.10615@piezo.novalocal>
 <1498014063.20161229214621@tlen.pl> <alpine.DEB.2.11.1612292048580.10615@piezo.novalocal>
 <1039341611.20161229215518@tlen.pl> <alpine.DEB.2.11.1612292137550.10615@piezo.novalocal>
 <10710520745.20161229230211@tlen.pl> <alpine.DEB.2.11.1612292216160.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37197 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbcL2XN3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 18:13:29 -0500
Received: by mail-wm0-f45.google.com with SMTP id t79so343767295wmt.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2016 15:13:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612292216160.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?Q?=C5=81ukasz_Chrustek?= <skidoo@tlen.pl>, ceph-devel <ceph-devel@vger.kernel.org>

Have you thought through your use of '"min_size": 1' on many of these pools?


See recent discussions on this mailing list on the subject for background.

Just FYI.


On Fri, Dec 30, 2016 at 8:18 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 29 Dec 2016, Łukasz Chrustek wrote:
>> Hi,
>>
>> Thank  You  very  much for analize and the file ! I had similar :) but
>> wasn't sure if it wan't distroy something in cluster.
>>
>> > The encoded tree bucket -11 had bad values.  I don't really trust the tree
>> > bucket code in crush... it's not well tested (and is a poor balance
>> > computation and efficiency anyway).  We should probably try to remove tree
>> > entirely.
>>
>> > I've attached a fixed map that you can inject with
>>
>> >  ceph osd setcrushmap -i <filename>
>>
>> Now it works, and also ceph osd crush dump -f json-pretty runs OK.
>
> Great news!
>
>> > Bucket -11 is now empty; not sure what was supposed to be in it.
>>
>> this server will be reinstalled, there where three osds.
>>
>> > I suggest switching all of your tree buckets over to straw2 as soon as
>> > possible.  Note that this will result in some rebalancing.  You could do
>> > it one bucket a time if that's concerning.
>>
>> OK,  changing  alg  to straw2 will rebalance ale PGs on all nodes ?
>
> For any bucket you change from tree -> straw2, you'll see PGs shuffle
> between the children of that bucket.  So for hosts, you'll see data move
> between the disks.  And fixing ssd-intel-s3700 will shuffle data between
> hosts.
>
> I'd also switch the straw buckets to straw2, although that will move a
> comparatively small amount of data.
>
> sage



-- 
Cheers,
Brad
