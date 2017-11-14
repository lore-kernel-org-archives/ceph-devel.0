From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 14:58:39 +0100
Message-ID: <116bccee-f119-7782-0c4b-f10c5dd60e35@corp.ovh.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
 <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com>
 <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com>
 <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com>
 <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com>
 <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com>
 <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com>
 <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo301.mail-out.ovh.net ([137.74.110.64]:49260 "EHLO
        1.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754742AbdKNN6m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 08:58:42 -0500
In-Reply-To: <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, Mark Nelson <mnelson@redhat.com>, Christian Wuerdig <christian.wuerdig@gmail.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 17-11-14 12:36 PM, John Spray wrote:
> On Tue, Nov 14, 2017 at 10:18 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
>> On 17-11-13 07:40 PM, John Spray wrote:
>>> I imagine many users today are not so disciplined as to version
>>> control their configs, but this is a good opportunity to push that as
>>> the norm by building it in.
>>
>> Using Ceph on any decent scale actually requires one to use at least Puppet
>> or similar tool, I wouldn't add any unnecessary complexity to already
>> complex code just because of novice users that are going to have hard time
>> using Ceph anyway once a disk breaks and needs to be replaced, or when
>> performance goes to hell because users are free to create and remove
>> snapshots every 5 minutes.
> 
> All of the experienced users were novice users once -- making Ceph
> work well for those people is worthwhile.  It's not easy to build
> things that are easy enough for a newcomer but also powerful enough
> for the general case, but it is worth doing.
> 
> When we have to trade internal complexity vs. complexity at
> interfaces, it's generally better to keep the interfaces simple.
> Currently a Ceph cluster with 1000 OSDs has 1000 places to input the
> configuration, and no one place that a person can ask "what is setting
> X on my OSDs?".  Even when they look at a ceph.conf file, they can't
> be sure that those are really the values in use (has the service
> restarted since the file was updated?) or that they will ever be (are
> they invalid values that Ceph will reject on load?).

Well, at least I understand now why my config diff patch 
(https://github.com/ceph/ceph/pull/18586) is not interesting to reviewers. ;)

> The "dump a text file in /etc" interface looks simple on the face of
> it, but is actually quite complex when you look to automate a Ceph
> cluster from a central user interface, or build more intelligence into
> Ceph for avoiding dangerous configurations.  It's also painful for
> non-expert users who are required to type precisely correct syntax
> into that text file.

Anybody who is overwhelmed by ini-style config file should be kept 100km 
away from any datacentre and have their shell access rights revoked ASAP.
Using Ceph (or any kind of SDN-like software) in production requires a few 
years as admin under their belt and trying to change that will only cause 
more grief and frustration from future new users. Ceph already has a feature 
designed with network switch configuration newbies in mind -- it shouldn't.

>> And I can already imagine clusters breaking down once config
>> database/history breaks for whatever reason, including early implementation
>> bugs.
>>
>> Distributing configs through mon isn't bad idea by itself, I can imagine
>> having changes to runtime-changeable settings propagated to OSDs without the
>> need for extra step (actually injecting them) and without the need for
>> restart, but for anything else, there are already good tools and I see no
>> value in trying to mimic them.
> 
> Remember that the goal here is not to just invent an alternative way
> of distributing ceph.conf.  Even Puppet is overkill for that!  The

Of course! This bash oneliner:

for i in {1..4}; do scp ~/cluster_dev/ceph.conf ceph@node$i:/etc/ceph/; done;

is more than enough to distribute config from some central place to 4 nodes. 
But nobody sane does this because anything that's not automated is prone to 
human error. So no, using Puppet is not an overkill, because that does its 
job and is familiar way of doing this for much more users than just users of 
Ceph. Still, I'm not opposing distributing Ceph configs through mons, 
because that's actually useful.

> goal is to change the way configuration is defined in Ceph, so that
> there is a central point of truth for how the cluster is configured,
> which will enable us to create a user experience that is more robust,
> and an interface that enables building better interactive tooling on
> top of Ceph.
> 
> When it comes to using something like Puppet as that central point of
> truth, there are two major problems with that:
>   - If someone wants to write a GUI, they would need to integrate with
> your Puppet, someone else's Chef, someone else's Ansible, etc -- a lot
> of work, and in many cases the interfaces for doing it don't even
> exist (believe me, I've tried writing dashboards that drove Puppet in
> the past).

Usually when someone needs a GUI to deploy Ceph cluster, they need to deploy 
much more than just Ceph. They need to configure network interfaces, 
storage, kernel, monitoring, etc. etc., so they need to deal with Puppet or 
Chef (or anything) anyway.

>   - If Ceph wants to validate configuration options, and say "No, that
> setting is no good" when someone tries to change something, we can't,
> because we're not hooked in to Puppet at the point that the user is
> changing the setting.

One can use ceph-conf tool to validate config syntax, because it shares the 
config code with daemons. And with recent config code changes, it's even 
possible to validate values. But that's true, validating configuration 
before pushing it to production is tricky at the moment.

> The ultimate benefit to you is that by making Ceph easier to use, we
> grow our community, and we grow the population of people who want to
> invest in Ceph (all of it, not just the new user friendly bits).

True, more users mean tighter bug sieve. But attracting users with ease of 
use is one thing and reinventing wheels AND asking existing users to use 
these reinvented wheels at the same time is another thing. Remember that I 
was relating to the idea of built-in mini-git/mini-svn.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
