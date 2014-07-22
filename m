From: Wido den Hollander <wido@42on.com>
Subject: Re: Adding a delay when restarting all OSDs on a host
Date: Tue, 22 Jul 2014 16:28:19 +0200
Message-ID: <53CE7503.8030901@42on.com>
References: <53CE64D0.5050308@42on.com> <CABYiri8hsZahorNYeeFZBO-bE6u8BZULcnNfs8eBSyYOJL+9jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:58792 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbaGVO2W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jul 2014 10:28:22 -0400
In-Reply-To: <CABYiri8hsZahorNYeeFZBO-bE6u8BZULcnNfs8eBSyYOJL+9jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/22/2014 03:48 PM, Andrey Korolyov wrote:
> On Tue, Jul 22, 2014 at 5:19 PM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> Currently on Ubuntu with Upstart when you invoke a restart like this:
>>
>> $ sudo restart ceph-osd-all
>>
>> It will restart all OSDs at once, which can increase the load on the system
>> a quite a bit.
>>
>> It's better to restart all OSDs by restarting them one by one:
>>
>> $ sudo ceph restart ceph-osd id=X
>>
>> But you then have to figure out all the IDs by doing a find in
>> /var/lib/ceph/osd and that's more manual work.
>>
>> I'm thinking of patching the init scripts which allows something like this:
>>
>> $ sudo restart ceph-osd-all delay=180
>>
>> It then waits 180 seconds between each OSD restart making the proces even
>> smoother.
>>
>> I know there are currently sysvinit, upstart and systemd scripts, so it has
>> to be implemented on various places, but how does the general idea sound?
>>
>> --
>> Wido den Hollander
>> Ceph consultant and trainer
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>
>
> Hi,
>
> this behaviour obviously have a negative side of increased overall
> peering time and larger integral value of out-of-SLA delays. I`d vote
> for warming up necessary files, most likely collections, just before
> restart. If there are no enough room to hold all of them at once, we
> can probably combine both methods to achieve lower impact value on
> restart, although adding a simple delay sounds much more straight than
> putting file cache to ram.
>

In the case I'm talking about there are 23 OSDs running on a single 
machine and restarting all the OSDs causes a lot of peering and reading 
PG logs.

A warm-up mechanism might work, but that would be a lot of work.

When upgrading your cluster you simply want to do this:

$ dsh -g ceph-osd "sudo restart ceph-osd-all delay=180"

That might take hours to complete, but if it's just an upgrade that 
doesn't matter. You want as minimal impact on service as possible.

-- 
Wido den Hollander
Ceph consultant and trainer
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
