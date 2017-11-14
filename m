From: John Spray <jspray@redhat.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 11:36:25 +0000
Message-ID: <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
 <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com>
 <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com> <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com>
 <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com> <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:54089 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbdKNLgr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 06:36:47 -0500
Received: by mail-wr0-f179.google.com with SMTP id u40so17198582wrf.10
        for <ceph-devel@vger.kernel.org>; Tue, 14 Nov 2017 03:36:46 -0800 (PST)
In-Reply-To: <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, Mark Nelson <mnelson@redhat.com>, Christian Wuerdig <christian.wuerdig@gmail.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 14, 2017 at 10:18 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> On 17-11-13 07:40 PM, John Spray wrote:
>>
>> On Mon, Nov 13, 2017 at 6:20 PM, Kyle Bader <kyle.bader@gmail.com> wrote:
>>>
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
>>
>> That is an extremely good idea.
>>
>> As a minimal thing, it should be pretty straightforward to implement a
>> snapshot/rollback.
>
>
> https://thedailywtf.com/articles/The_Complicator_0x27_s_Gloves
>
>> I imagine many users today are not so disciplined as to version
>> control their configs, but this is a good opportunity to push that as
>> the norm by building it in.
>
>
> Using Ceph on any decent scale actually requires one to use at least Puppet
> or similar tool, I wouldn't add any unnecessary complexity to already
> complex code just because of novice users that are going to have hard time
> using Ceph anyway once a disk breaks and needs to be replaced, or when
> performance goes to hell because users are free to create and remove
> snapshots every 5 minutes.

All of the experienced users were novice users once -- making Ceph
work well for those people is worthwhile.  It's not easy to build
things that are easy enough for a newcomer but also powerful enough
for the general case, but it is worth doing.

When we have to trade internal complexity vs. complexity at
interfaces, it's generally better to keep the interfaces simple.
Currently a Ceph cluster with 1000 OSDs has 1000 places to input the
configuration, and no one place that a person can ask "what is setting
X on my OSDs?".  Even when they look at a ceph.conf file, they can't
be sure that those are really the values in use (has the service
restarted since the file was updated?) or that they will ever be (are
they invalid values that Ceph will reject on load?).

The "dump a text file in /etc" interface looks simple on the face of
it, but is actually quite complex when you look to automate a Ceph
cluster from a central user interface, or build more intelligence into
Ceph for avoiding dangerous configurations.  It's also painful for
non-expert users who are required to type precisely correct syntax
into that text file.

> And I can already imagine clusters breaking down once config
> database/history breaks for whatever reason, including early implementation
> bugs.
>
> Distributing configs through mon isn't bad idea by itself, I can imagine
> having changes to runtime-changeable settings propagated to OSDs without the
> need for extra step (actually injecting them) and without the need for
> restart, but for anything else, there are already good tools and I see no
> value in trying to mimic them.

Remember that the goal here is not to just invent an alternative way
of distributing ceph.conf.  Even Puppet is overkill for that!  The
goal is to change the way configuration is defined in Ceph, so that
there is a central point of truth for how the cluster is configured,
which will enable us to create a user experience that is more robust,
and an interface that enables building better interactive tooling on
top of Ceph.

When it comes to using something like Puppet as that central point of
truth, there are two major problems with that:
 - If someone wants to write a GUI, they would need to integrate with
your Puppet, someone else's Chef, someone else's Ansible, etc -- a lot
of work, and in many cases the interfaces for doing it don't even
exist (believe me, I've tried writing dashboards that drove Puppet in
the past).
 - If Ceph wants to validate configuration options, and say "No, that
setting is no good" when someone tries to change something, we can't,
because we're not hooked in to Puppet at the point that the user is
changing the setting.

The ultimate benefit to you is that by making Ceph easier to use, we
grow our community, and we grow the population of people who want to
invest in Ceph (all of it, not just the new user friendly bits).

John
