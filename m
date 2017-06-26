From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Remote execution in ceph-medic
Date: Mon, 26 Jun 2017 13:21:15 -0400
Message-ID: <CAC-Np1wiSUTtc4qudf9e5FQYnLJ6OypYU1-XgAuuOmfbJqhhgA@mail.gmail.com>
References: <CALe9h7f7TtnFmc68xr2ayjEA8vyvnN7FPUoys=ea4HW_5JOKXA@mail.gmail.com>
 <CAC-Np1yuWP3+=8Ay=w41geuc7dkNgCv1FN3zDQqvaU9sv6B6ng@mail.gmail.com> <CALe9h7c3TT=qFS7TSJx3gpf2=3jznEmBnFZfXX+mDwyMA-NoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34901 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdFZRVS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 13:21:18 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so147317266wrc.2
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jun 2017 10:21:17 -0700 (PDT)
In-Reply-To: <CALe9h7c3TT=qFS7TSJx3gpf2=3jznEmBnFZfXX+mDwyMA-NoRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 26, 2017 at 12:56 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Jun 26, 2017 at 5:34 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Mon, Jun 26, 2017 at 11:52 AM, John Spray <jspray@redhat.com> wrote:
>>> Hi guys,
>>>
>>> I was pondering this and wondered if you had any existing plans...
>>>
>>> For doing network testing between two remote nodes, we'll need to be
>>> able to spin up some sort of listener on one end, presumably via SSH
>>> from a third party node.
>>
>> What kind of testing warrants this type of setup?
>
> I'm talking about opening a TCP connection between two remote nodes to
> verify that the network connectivity is working, and probably doing
> this across a large set of pairs e.g. doing an all-to-all ping pong
> between OSD nodes.  Obviously, there is just the standard `ping`, but
> I'm expecting that we'll want to test using actual TCP traffic in the
> port ranges that the OSDs would use.

If we are checking connectivity between OSD nodes, wouldn't it be
sufficient to test
if the port where the OSD is listening can be reached? Again, we can
use plain Python to send actual TCP traffic here.

I think that what you are proposing was going to be checked as part of
the 'network' collection. Managing processes to listen to each
other and report if they do/don't, sounds like it can be avoided.

I have created a ticket to make sure that we collect the inter-node connectivity

    https://github.com/ceph/ceph-medic/issues/18

>
> John
>
>>>
>>> I guess the choice here is whether to depend on having ceph-medic
>>> already installed on all the nodes (and invoke it with a special
>>> --receiver type argument) or whether the tool should inject its code
>>> over SSH (e.g. run a big fat python command line with a script in it
>>> over SSH).
>>>
>>
>> That is kind of how this works already, borrowing from ceph-deploy: it
>> uses SSH to connect
>> to remote nodes and execute either system commands or Python code.
>>
>> In what scenario using a system call or Python code will not gather
>> enough information that a server/client
>> setup would?
>>
>>> I lean towards the latter in the interests of making the deployment
>>> simple, but I'm not sure what the story is with e.g. selinux in
>>> situations like this, whether a server is going to get unhappy about
>>> an SSH session that tries to open ports.
>>
>> Having two processes running to check connectivity sounds a bit
>> complicated to handle. One of the things the tool does
>> is to cross-check against other nodes in the system, so this would
>> potentially mean running an exponential amount of
>> processes: for every node to each node in the cluster.
>>
>> It will be cheaper to perform those checks with either plain Python or
>> a system call.
>>
>> Or maybe you mean some other type of check? What are your ideas on
>> "network testing" ?
>>>
>>> John
