From: =?utf-8?Q?=C5=81ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: problem with removing osd
Date: Fri, 30 Dec 2016 00:33:30 +0100
Message-ID: <1693513172.20161230003330@tlen.pl>
References: <16310616780.20161229160718@tlen.pl>
  <alpine.DEB.2.11.1612291908472.10615@piezo.novalocal>
  <109878557.20161229212030@tlen.pl>
  <alpine.DEB.2.11.1612292025280.10615@piezo.novalocal>
  <1498014063.20161229214621@tlen.pl>
  <alpine.DEB.2.11.1612292048580.10615@piezo.novalocal>
  <1039341611.20161229215518@tlen.pl>
  <alpine.DEB.2.11.1612292137550.10615@piezo.novalocal>
  <10710520745.20161229230211@tlen.pl>
  <alpine.DEB.2.11.1612292216160.10615@piezo.novalocal>
  <CAF-wwdE9rnDbrXyxEaBfNShfvYpfmEzqunDz8b7in8Uf5cECZA@mail.gmail.com>
Reply-To: =?utf-8?Q?=C5=81ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.140]:10217 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbcL2Xde (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Dec 2016 18:33:34 -0500
In-Reply-To: <CAF-wwdE9rnDbrXyxEaBfNShfvYpfmEzqunDz8b7in8Uf5cECZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Thank You for suggestion - I will read about it.

Regards
Luk

> Have you thought through your use of '"min_size": 1' on many of these pools?


> See recent discussions on this mailing list on the subject for background.

> Just FYI.


> On Fri, Dec 30, 2016 at 8:18 AM, Sage Weil <sage@newdream.net> wrote:
>> On Thu, 29 Dec 2016, Łukasz Chrustek wrote:
>>> Hi,
>>>
>>> Thank  You  very  much for analize and the file ! I had similar :) but
>>> wasn't sure if it wan't distroy something in cluster.
>>>
>>> > The encoded tree bucket -11 had bad values.  I don't really trust the tree
>>> > bucket code in crush... it's not well tested (and is a poor balance
>>> > computation and efficiency anyway).  We should probably try to remove tree
>>> > entirely.
>>>
>>> > I've attached a fixed map that you can inject with
>>>
>>> >  ceph osd setcrushmap -i <filename>
>>>
>>> Now it works, and also ceph osd crush dump -f json-pretty runs OK.
>>
>> Great news!
>>
>>> > Bucket -11 is now empty; not sure what was supposed to be in it.
>>>
>>> this server will be reinstalled, there where three osds.
>>>
>>> > I suggest switching all of your tree buckets over to straw2 as soon as
>>> > possible.  Note that this will result in some rebalancing.  You could do
>>> > it one bucket a time if that's concerning.
>>>
>>> OK,  changing  alg  to straw2 will rebalance ale PGs on all nodes ?
>>
>> For any bucket you change from tree -> straw2, you'll see PGs shuffle
>> between the children of that bucket.  So for hosts, you'll see data move
>> between the disks.  And fixing ssd-intel-s3700 will shuffle data between
>> hosts.
>>
>> I'd also switch the straw buckets to straw2, although that will move a
>> comparatively small amount of data.
>>
>> sage






-- 
Pozdrowienia,
 Łukasz Chrustek

