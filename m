From: Alfredo Deza <adeza@redhat.com>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Mon, 19 Jun 2017 13:53:07 -0400
Message-ID: <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com> <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34557 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdFSRxJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 13:53:09 -0400
Received: by mail-wr0-f177.google.com with SMTP id 77so78757923wrb.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 10:53:09 -0700 (PDT)
In-Reply-To: <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 12:55 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Jun 19, 2017 at 3:13 PM, Alfredo Deza <adeza@redhat.com> wrote:
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
>>
>> Although there is no code yet, I consider the project in an "unstable"
>> state, it will move incredibly fast (it has to!) and that puts it at
>> odds with the cadence
>> of Ceph. Specifically, these two things are very important right now:
>>
>> * faster release cycles
>> * easier and faster to test
>
> I think having one part of Ceph on a different release cycle to the
> rest of Ceph is an even more dramatic thing than having it in a
> separate git repository.
>
> It seems like there is some dissatisfaction with how the Ceph project
> as whole is doing things that is driving you to try and do work
> outside of the repo where the rest of the project lives -- if the
> release cycles or test infrastructure within Ceph are not adequate for
> the tool that formats drives for OSDs, what can we do to fix them?

It isn't Ceph the project :)

Not every tool about Ceph has to come from ceph.git, in which case the
argument could be flipped around: why isn't ceph-installer,
ceph-ansible, ceph-deploy, radosgw-agent, etc... all coming from
within ceph.git ?

They don't necessarily need to be tied in. In the case of
ceph-installer: there is nothing ceph-specific it needs from ceph.git
to run, why force it in?

>
>> I am not ruling out going into Ceph at some point though, ideally when
>> things slow down and become stable.
>
> I think that the decision about where this code lives needs to be made
> before it is released -- moving it later is rather awkward.  If you'd
> rather not have the code in Ceph master until you're happy with it,
> then a branch would be the natural way to do that.
>

The decision was made a few weeks ago, and I really don't think we
should be in ceph.git, but I am OK to keep
discussing on the reasoning.

>> Is your argument only to have parity in Ceph's branching? That was
>> never a problem with out-of-tree tools like ceph-deploy for example.
>
> I guess my argument isn't so much an argument as it is an assertion
> that if you want to go your own way then you need to have a really
> strong clear reason.

Many! Like I mentioned: easier testing, faster release cycle, can
publish in any package index, doesn't need anything in ceph.git to
operate, etc..

>
> Put a bit bluntly: if CephFS, RBD, RGW, the mon and the OSD can all
> successfully co-habit in one git repository, what makes the CLI that
> formats drives so special that it needs its own?

Sure. Again, there is nothing some of our tooling needs from ceph.git
so I don't see why the need to have then in-tree. I am sure RGW and
other
components do need to consume Ceph code in some way? I don't even
think ceph-disk should be in tree for the same reason. I believe that
in the very
beginning it was just so easy to have everything be built from ceph.git

Even in some cases like pybind, it has been requested numerous times
to get them on separate package indexes like PyPI, but that has always
been
*tremendously* difficult: http://tracker.ceph.com/issues/5900


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
>>
>> At one point we are going to add regular disk worfklows (replacing
>> ceph-disk functionality) and then it would become even more
>> confusing to keep it there (or do you think at that point we could split?)
>>
>>>
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
> The trouble with "volume" is that it means so many things in so many
> different storage systems -- I haven't often seen it used to mean
> "block device" or "drive".  It's more often used to describe a logical
> entity.  I also think "disk" is fine -- most people get the idea that
> a disk is a hard drive but it could also be any block device.

If your thinking is that a disk can be any block device then yes, we
are at opposite ends here of our naming. We are picking a
"widely used" term because it is not specific. "disk" sounds fairly
specific, and we don't want that.


>
> John
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
