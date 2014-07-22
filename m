From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Adding a delay when restarting all OSDs on a host
Date: Tue, 22 Jul 2014 18:58:33 +0400
Message-ID: <CABYiri_YnWbC7H60WaMSWGwSTXtj4GKzVkPn36LRQv3v37zcJQ@mail.gmail.com>
References: <53CE64D0.5050308@42on.com> <CABYiri8hsZahorNYeeFZBO-bE6u8BZULcnNfs8eBSyYOJL+9jw@mail.gmail.com>
 <53CE7503.8030901@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:43668 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbaGVO6x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 10:58:53 -0400
Received: by mail-oa0-f42.google.com with SMTP id n16so9948964oag.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 07:58:53 -0700 (PDT)
In-Reply-To: <53CE7503.8030901@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 22, 2014 at 6:28 PM, Wido den Hollander <wido@42on.com> wrote:
> On 07/22/2014 03:48 PM, Andrey Korolyov wrote:
>>
>> On Tue, Jul 22, 2014 at 5:19 PM, Wido den Hollander <wido@42on.com> wrote:
>>>
>>> Hi,
>>>
>>> Currently on Ubuntu with Upstart when you invoke a restart like this:
>>>
>>> $ sudo restart ceph-osd-all
>>>
>>> It will restart all OSDs at once, which can increase the load on the
>>> system
>>> a quite a bit.
>>>
>>> It's better to restart all OSDs by restarting them one by one:
>>>
>>> $ sudo ceph restart ceph-osd id=X
>>>
>>> But you then have to figure out all the IDs by doing a find in
>>> /var/lib/ceph/osd and that's more manual work.
>>>
>>> I'm thinking of patching the init scripts which allows something like
>>> this:
>>>
>>> $ sudo restart ceph-osd-all delay=180
>>>
>>> It then waits 180 seconds between each OSD restart making the proces even
>>> smoother.
>>>
>>> I know there are currently sysvinit, upstart and systemd scripts, so it
>>> has
>>> to be implemented on various places, but how does the general idea sound?
>>>
>>> --
>>> Wido den Hollander
>>> Ceph consultant and trainer
>>> 42on B.V.
>>>
>>> Phone: +31 (0)20 700 9902
>>> Skype: contact42on
>>> --
>>
>>
>>
>> Hi,
>>
>> this behaviour obviously have a negative side of increased overall
>> peering time and larger integral value of out-of-SLA delays. I`d vote
>> for warming up necessary files, most likely collections, just before
>> restart. If there are no enough room to hold all of them at once, we
>> can probably combine both methods to achieve lower impact value on
>> restart, although adding a simple delay sounds much more straight than
>> putting file cache to ram.
>>
>
> In the case I'm talking about there are 23 OSDs running on a single machine
> and restarting all the OSDs causes a lot of peering and reading PG logs.
>
> A warm-up mechanism might work, but that would be a lot of work.
>
> When upgrading your cluster you simply want to do this:
>
> $ dsh -g ceph-osd "sudo restart ceph-osd-all delay=180"
>
> That might take hours to complete, but if it's just an upgrade that doesn't
> matter. You want as minimal impact on service as possible.
>

I may suggest to measure impact with vmtouch[0], it decreased OSD
startup time greatly on mine tests, but I was stuck with same resource
exhaustion as before after OSD marked itself up (IOPS ceiling
primarily).


0. http://hoytech.com/vmtouch/
