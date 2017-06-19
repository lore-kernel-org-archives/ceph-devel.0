From: Alfredo Deza <adeza@redhat.com>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Mon, 19 Jun 2017 13:57:59 -0400
Message-ID: <CAC-Np1y=0wkOHvGDHaxyZ+0jesQ_64TX2fvrMLaRkWOoLC6OsQ@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com> <626e190c-fa2a-71d2-980a-49ddd2770eb9@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38030 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFSR6B (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 13:58:01 -0400
Received: by mail-wm0-f45.google.com with SMTP id u195so366855wmd.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 10:58:01 -0700 (PDT)
In-Reply-To: <626e190c-fa2a-71d2-980a-49ddd2770eb9@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: John Spray <jspray@redhat.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 11:37 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 19-6-2017 16:13, Alfredo Deza wrote:
>> On Mon, Jun 19, 2017 at 9:27 AM, John Spray <jspray@redhat.com> wrote:
>>> On Fri, Jun 16, 2017 at 7:23 PM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> On Fri, Jun 16, 2017 at 2:11 PM, Warren Wang - ISD
>>>> <Warren.Wang@walmart.com> wrote:
>>>>> I would prefer that this is something more generic, to possibly support other backends one day, like ceph-volume. Creating one tool per backend seems silly.
>>>>>
>>>>> Also, ceph-lvm seems to imply that ceph itself has something to do with lvm, which it really doesn’t. This is simply to deal with the underlying disk. If there’s resistance to something more generic like ceph-volume, then it should at least be called something like ceph-disk-lvm.
>>>>
>>>> Sage, you had mentioned the need for "composable" tools for this, and
>>>> I think that if we go with `ceph-volume` we could allow plugins for
>>>> each strategy. We are starting with `lvm` support so that would look
>>>> like: `ceph-volume lvm`
>>>>
>>>> The `lvm` functionality could be implemented as a plugin itself, and
>>>> when we start working with supporting regular disks, then `ceph-volume
>>>> disk` can come along, etc...
>>>>
>>>> It would also open the door for anyone to be able to write a plugin to
>>>> `ceph-volume` to implement their own logic, while at the same time
>>>> re-using most of what we are implementing today: logging, reporting,
>>>> systemd support, OSD metadata, etc...
>>>>
>>>> If we were to separate these into single-purpose tools, all those
>>>> would need to be re-done.
>>>
>>> Couple of thoughts:
>>>  - let's keep this in the Ceph repository unless there's a strong
>>> reason not to -- it'll enable the tool's branching to automatically
>>> happen in line with Ceph's.
>>
>> For initial development this is easier to have as a separate tool from
>> the Ceph source tree. There are some niceties about being in-source,
>> like
>> not being required to deal with what features we are supporting on what version.
>
> Just my observation, need not be true at all, but ...
>
> As long as you do not have it interact with the other tools, that is
> true. But as soon as you start depending on ceph-{disk-new,volume} in
> other parts of the mainstream ceph-code you have created a ty-in with
> the versioning and will require it to be maintained in the same way.
>
>
>> Although there is no code yet, I consider the project in an "unstable"
>> state, it will move incredibly fast (it has to!) and that puts it at
>> odds with the cadence
>> of Ceph. Specifically, these two things are very important right now:
>>
>> * faster release cycles
>> * easier and faster to test
>>
>> I am not ruling out going into Ceph at some point though, ideally when
>> things slow down and become stable.
>>
>> Is your argument only to have parity in Ceph's branching? That was
>> never a problem with out-of-tree tools like ceph-deploy for example.
>
> Some of the external targets move so fast (ceph-asible) that I have
> given up on trying to see what is going on. For this tool I'd like it to
> do the ZFS/FreeBSD stuff as a plugin-module.
> In the expectation that it will supersede the current ceph-disk,
> otherwise there are 2 place to maintain this type of code.

Yes, the idea is that it will be pluggable from the start, and that it
will supersede current ceph-disk (but not immediately)

>
>>>  - I agree with others that a single entrypoint (i.e. executable) will
>>> be more manageable than having conspicuously separate tools, but we
>>> shouldn't worry too much about making things "plugins" as such -- they
>>> can just be distinct code inside one tool, sharing as much or as
>>> little as they need.
>>>
>>> What if we delivered this set of LVM functionality as "ceph-disk lvm
>>> ..." commands to minimise the impression that the tooling is changing,
>>> even if internally it's all new/distinct code?
>>
>> That sounded appealing initially, but because we are introducing a
>> very different API, it would look odd to interact
>> with other subcommands without a normalized interaction. For example,
>> for 'prepare' this would be:
>>
>> ceph-disk prepare [...]
>>
>> And for LVM it would possible be
>>
>> ceph-disk lvm prepare [...]
>>
>> The level at which these similar actions are presented imply that one
>> may be a preferred (or even default) one, while the other one
>> isn't.
>
> Is this about API "cosmetics"? Because there is a lot of examples
> suggestions and other stuff out there that is using the old syntax.
>
> And why not do a hybrid? it will require a bit more commandline parsing,
> but that is not a major dealbreaker.
>
> so the line would look like
>     ceph-disk [lvm,zfs,disk,partition] prepare [...]
> and the first parameter is optional reverting to the current supported
> systems.
>
> You can always start warning users that their API usage is old style,
> and that it is going to go away in a next release.
>
>> At one point we are going to add regular disk worfklows (replacing
>> ceph-disk functionality) and then it would become even more
>> confusing to keep it there (or do you think at that point we could split?)
>
> The more separate you go, the more akward it is going to be when things
> start to melt together.
>
>>> At the risk of being a bit picky about language, I don't like calling
>>> this anything with "volume" in the name, because afaik we've never
>>> ever called OSDs or the drives they occupy "volumes", so we're
>>> introducing a whole new noun, and a widely used (to mean different
>>> things) one at that.
>>>
>>
>> We have never called them 'volumes' because there was never anything
>> to support something other than regular disks, the approach
>> has always been disks and partitions.
>>
>> A "volume" can be a physical volume (e.g. a disk) or a logical one
>> (lvm, dmcache). It is an all-encompassing name to allow different
>> device-like to work with.
>
> ZFS talks about volumes, vdev, partitions, .... and perhaps even more.
> Being picky: ceph-disk now also works on pre-build trees to build filestore.
>

Naming will continue to be the hardest part to get consensus on :) Of
course we could've just gone the other
way and pick something that has a nice ring to it, and nothing that
even hints at what it does :)


> I would just try to glue it into ceph-disk in the most flexible way

We can't "glue it into ceph-disk" because we are proposing a
completely new way of doing things that
go against how ceph-disk works.


> possible.
> --WjW
>
>>
>>
>>> John
>>>
>>>>
>>>>
>>>>>
>>>>> 2 cents from one of the LVM for Ceph users,
>>>>> Warren Wang
>>>>> Walmart ✻
>>>>>
>>>>> On 6/16/17, 10:25 AM, "ceph-users on behalf of Alfredo Deza" <ceph-users-bounces@lists.ceph.com on behalf of adeza@redhat.com> wrote:
>>>>>
>>>>>     Hello,
>>>>>
>>>>>     At the last CDM [0] we talked about `ceph-lvm` and the ability to
>>>>>     deploy OSDs from logical volumes. We have now an initial draft for the
>>>>>     documentation [1] and would like some feedback.
>>>>>
>>>>>     The important features for this new tool are:
>>>>>
>>>>>     * parting ways with udev (new approach will rely on LVM functionality
>>>>>     for discovery)
>>>>>     * compatibility/migration for existing LVM volumes deployed as directories
>>>>>     * dmcache support
>>>>>
>>>>>     By documenting the API and workflows first we are making sure that
>>>>>     those look fine before starting on actual development.
>>>>>
>>>>>     It would be great to get some feedback, specially if you are currently
>>>>>     using LVM with ceph (or planning to!).
>>>>>
>>>>>     Please note that the documentation is not complete and is missing
>>>>>     content on some parts.
>>>>>
>>>>>     [0] http://tracker.ceph.com/projects/ceph/wiki/CDM_06-JUN-2017
>>>>>     [1] http://docs.ceph.com/ceph-lvm/
>>>>>     _______________________________________________
>>>>>     ceph-users mailing list
>>>>>     ceph-users@lists.ceph.com
>>>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
