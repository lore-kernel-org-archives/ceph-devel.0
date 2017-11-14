From: Mark Nelson <mnelson@redhat.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 07:48:06 -0600
Message-ID: <7ce43ca4-88ae-7611-6fd3-78b0670f69d7@redhat.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
 <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com>
 <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com>
 <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com>
 <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com>
 <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbdKNNsH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Nov 2017 08:48:07 -0500
In-Reply-To: <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>, John Spray <jspray@redhat.com>, Kyle Bader <kyle.bader@gmail.com>
Cc: Christian Wuerdig <christian.wuerdig@gmail.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 11/14/2017 04:18 AM, Piotr Dałek wrote:
> On 17-11-13 07:40 PM, John Spray wrote:
>> On Mon, Nov 13, 2017 at 6:20 PM, Kyle Bader <kyle.bader@gmail.com> wrote:
>>> Configuration files are often driven by configuration management, with
>>> previous versions stored in some kind of version control systems. We
>>> should make sure that if configuration moves to the monitors that you
>>> have some form of history and rollback capabilities. It might be worth
>>> modeling it similar to network switch configuration shells, a la
>>> Junos.
>>>
>>> * change configuration
>>> * require commit configuration change
>>> * ability to rollback N configuration changes
>>> * ability to diff to configuration versions
>>>
>>> That way an admin can figure out when the last configuration change
>>> was, what changed, and rollback if necessary.
>>
>> That is an extremely good idea.
>>
>> As a minimal thing, it should be pretty straightforward to implement a
>> snapshot/rollback.
>
> https://thedailywtf.com/articles/The_Complicator_0x27_s_Gloves
>
>> I imagine many users today are not so disciplined as to version
>> control their configs, but this is a good opportunity to push that as
>> the norm by building it in.
>
> Using Ceph on any decent scale actually requires one to use at least
> Puppet or similar tool, I wouldn't add any unnecessary complexity to
> already complex code just because of novice users that are going to have
> hard time using Ceph anyway once a disk breaks and needs to be replaced,
> or when performance goes to hell because users are free to create and
> remove snapshots every 5 minutes.
> And I can already imagine clusters breaking down once config
> database/history breaks for whatever reason, including early
> implementation bugs.
>
> Distributing configs through mon isn't bad idea by itself, I can imagine
> having changes to runtime-changeable settings propagated to OSDs without
> the need for extra step (actually injecting them) and without the need
> for restart, but for anything else, there are already good tools and I
> see no value in trying to mimic them.
>

Those were more or less my thoughts as well.

Mark
