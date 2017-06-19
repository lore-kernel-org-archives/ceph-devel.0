From: Alfredo Deza <adeza@redhat.com>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Mon, 19 Jun 2017 17:14:09 -0400
Message-ID: <CAC-Np1xe3M9WdNGTZrMhf1inhQBWzT5OLc7BexKCa8ngeUJhRw@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
 <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com> <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32901 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdFSVOM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jun 2017 17:14:12 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so81356094wrb.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 14:14:11 -0700 (PDT)
In-Reply-To: <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 4:24 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Jun 19, 2017 at 6:53 PM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> * faster release cycles
>>>> * easier and faster to test
>>>
>>> I think having one part of Ceph on a different release cycle to the
>>> rest of Ceph is an even more dramatic thing than having it in a
>>> separate git repository.
>>>
>>> It seems like there is some dissatisfaction with how the Ceph project
>>> as whole is doing things that is driving you to try and do work
>>> outside of the repo where the rest of the project lives -- if the
>>> release cycles or test infrastructure within Ceph are not adequate for
>>> the tool that formats drives for OSDs, what can we do to fix them?
>>
>> It isn't Ceph the project :)
>>
>> Not every tool about Ceph has to come from ceph.git, in which case the
>> argument could be flipped around: why isn't ceph-installer,
>> ceph-ansible, ceph-deploy, radosgw-agent, etc... all coming from
>> within ceph.git ?
>
> ceph-installer, ceph-deploy and ceph-ansible are special cases because
> they are installers, that operate before a particular version of Ceph
> has been selected for installation, and might operate on two
> differently versioned clusters at the same time.

This is a perfect use case for ceph-volume, the OSD doesn't (and in
most cases this is true) care what is beneath it, as long
as it is mounted and has what it needs to function. The rest is
*almost like installation*.

>
> radosgw-agent, presumably (I haven't worked on it) is separate because
> it sits between two clusters but is logically part of neither, and
> those clusters could potentially be different-versioned too.
>
> ceph-disk, on the other hand, rides alongside ceph-osd, writes a
> format that ceph-osd needs to understand, the two go together
> everywhere.  You use whatever version of ceph-disk corresponds to the
> ceph-osd package you have.  You run whatever ceph-osd corresponds to
> the version of ceph-disk you just used.  The two things are not
> separate, any more than ceph-objectstore-tool would be.

The OSD needs a mounted volume that has pieces that the OSD itself
puts in there. It is a bit convoluted because
there are other steps, but the tool itself isn't crucial for the OSD
to function, it is borderline an orchestrator to get the volume
where the OSD runs ready.

>
> It would be more intuitive if we had called ceph-disk
> "ceph-osd-format" or similar.  The utility that prepares drives for
> use by the OSD naturally belongs in the same package (or at the very
> least the same release!) as the OSD code that reads that on-disk
> format.
>
> There is a very clear distinction in my mind between things that
> install Ceph (i.e. they operate before the ceph packages are on the
> system), and things that prepare the system (a particular Ceph version
> is already installed, we're just getting ready to run it).
> ceph-objectstore-tool would be another example of something that
> operates on the drives, but is intimately coupled to the OSDs and
> would not make sense as a separately released thing.

And ceph-disk isn't really coupled (maybe a tiny corner of it is). Or
maybe you can exemplify how those are tied? I've gone through every
single
step to get an OSD, and although in some cases it is a bit more
complex, it isn't more than a few steps (6 in total from our own
docs):

http://docs.ceph.com/docs/master/rados/operations/add-or-rm-osds/#adding-an-osd-manual

ceph-ansible *does* prepare a system for running Ceph, so does
ceph-docker. ceph-disk has had some pitfalls that ceph-ansible has to
workaround,
and has to implement other things as well to be able to deploy OSDs.


>
>> They don't necessarily need to be tied in. In the case of
>> ceph-installer: there is nothing ceph-specific it needs from ceph.git
>> to run, why force it in?
>
> Because Ceph is already a huge, complex codebase, and we already have
> lots of things to keep track of.  Sometimes breaking things up makes
> life easier, sometimes commonality makes live easier -- the trick is
> knowing when to do which.
>
> The binaries, the libraries, the APIs, these things benefit from being
> broken down into manageable bitesize pieces.  The version control, the
> releases, the build management, these things do not (with the
> exception of optimizing jenkins by doing fewer builds in some cases).
>
> I don't ever want to have to ask or answer the question "What version
> of ceph-disk to I need for ceph x.y.z?", or "Can I run ceph-osd x.y.z
> on a drive formatted with ceph-disk a.b.c?".
>

That is the same question users of ceph-ansible need to look for. I
think this is fine as long as it is well defined. Now, the
ceph-ansible implementation
is far more complex because it needs to support old features and new
ones for every single aspect. I haven't seen much API changes in
ceph-disk that are completely
backwards incompatible with older releases.

And even if that is the case, we have been able to implement tooling
that is perfectly capable of managing that use case.

I would be more concerned if the "Adding an OSD (manual)" section
would keep changing on every Ceph release (it has almost stayed the
same for quite a few releases).

> Being able to give a short, simple answer to "what version of Ceph is
> this?" has HUGE value, and that goes out the window when you start
> splitting bits off on their own release schedules.
>

We are planning on being fully compatible, unless there is a major
change in how Ceph is exposing the bits for creating an OSD. Just like
we've done with ceph-deploy in the past.


>>>> I am not ruling out going into Ceph at some point though, ideally when
>>>> things slow down and become stable.
>>>
>>> I think that the decision about where this code lives needs to be made
>>> before it is released -- moving it later is rather awkward.  If you'd
>>> rather not have the code in Ceph master until you're happy with it,
>>> then a branch would be the natural way to do that.
>>>
>>
>> The decision was made a few weeks ago, and I really don't think we
>> should be in ceph.git, but I am OK to keep
>> discussing on the reasoning.
>>
>>
>>>> Is your argument only to have parity in Ceph's branching? That was
>>>> never a problem with out-of-tree tools like ceph-deploy for example.
>>>
>>> I guess my argument isn't so much an argument as it is an assertion
>>> that if you want to go your own way then you need to have a really
>>> strong clear reason.
>>
>> Many! Like I mentioned: easier testing, faster release cycle, can
>> publish in any package index, doesn't need anything in ceph.git to
>> operate, etc..
>
> Testing: being separate is only easier if you're only doing python
> unit testing.  If you're testing that ceph-disk/ceph-volume really
> does its job, then you absolutely do want to be in the ceph tree, so
> that you can fire up an OSD that checks that ceph-disk really did it's
> job.
>
> Faster release cycle: we release pretty often.

Uh, it depends on what "fast" means for you. 4 months waiting on a
ceph-disk issue that was fixed/merged to have ceph-ansible not have
that bug
is not really fast.

>  We release often
> enough to deal with critical OSD and mon bugs.  The tool that formats
> OSDs doesn't need to be released more often than the OSD itself.
>

It does need to be released often when the tool is new!

> Package indices: putting any of the Ceph code in pypi is of limited
> value, even if we do periodically run into people with a passion for
> it.  If someone did a "pip install librados", the very next thing they
> would have to do would be to go find some packages of the C librados
> bindings, and hope like hell that those packages matched whatever they
> just downloaded from pypi, and they probably wouldn't, because what
> are the chances that pip is fetching python bindings that match the
> Ceph version I have on my system?  I don't want to have to deal with
> users who get themselves into that situation.

So in this case you are using bindings to explicit internal Ceph APIs,
we aren't doing that, this is not a use case we are contemplating.

>
>>> Put a bit bluntly: if CephFS, RBD, RGW, the mon and the OSD can all
>>> successfully co-habit in one git repository, what makes the CLI that
>>> formats drives so special that it needs its own?
>>
>> Sure. Again, there is nothing some of our tooling needs from ceph.git
>> so I don't see why the need to have then in-tree. I am sure RGW and
>> other
>> components do need to consume Ceph code in some way? I don't even
>> think ceph-disk should be in tree for the same reason. I believe that
>> in the very
>> beginning it was just so easy to have everything be built from ceph.git
>
> We are, for better or worse, currently in a "one big repo" model (with
> the exception of installers and inter-cluster rgw bits).
>
> One could legitimately argue that more modularity is better, and
> separate out RBD and RGW into separate projects, because hey, they're
> standalone, right?  Or, one can go the other way and argue that more
> modularity creates versioning headaches that just don't need to exist.
>
> Both are valid worldviews, but the WORST outcome is to have almost
> everything in one repo, and then splinter off individual command line
> tools based on ad hoc decisions when someone is doing a particular
> feature.

RBD and RGW are unfair to use as an example to a (hopefully) small CLI
tool that wants to "prepare" a device for an OSD to start, that
doesn't consume any Python bindings, or Ceph APIs (aside from the ceph CLI).

>
> I know how backwards that must sound, when you're looking at the
> possibility of having a nice self contained git repo, that contains a
> pypi-eligible python module, which has unit tests that run fast in
> jenkins on every commit.  I get the appeal!  But for the sake of the
> overall simplicity of Ceph, please think again, or if you really want
> to convert us to a multi-repo model, then make that case for the
> project as a whole rather than doing it individually on a bit-by-bit
> basis.

We can't make the world of Ceph repos to abide today by a multi-repo
model. I would need to counter argue you for a few more months :)

The examples you give for ceph-disk, and how ceph-disk is today, is
why we want to change things.

It is not only faster unit tests, or a "nice self contained git repo"
just because we want to release to PyPI, we are facing a situation
where
we need faster development and increased release cycles that we can't
get being in an already big repository.


>
> John
>
>> Even in some cases like pybind, it has been requested numerous times
>> to get them on separate package indexes like PyPI, but that has always
>> been
>> *tremendously* difficult: http://tracker.ceph.com/issues/5900
>>>>>  - I agree with others that a single entrypoint (i.e. executable) will
>>>>> be more manageable than having conspicuously separate tools, but we
>>>>> shouldn't worry too much about making things "plugins" as such -- they
>>>>> can just be distinct code inside one tool, sharing as much or as
>>>>> little as they need.
>>>>>
>>>>> What if we delivered this set of LVM functionality as "ceph-disk lvm
>>>>> ..." commands to minimise the impression that the tooling is changing,
>>>>> even if internally it's all new/distinct code?
>>>>
>>>> That sounded appealing initially, but because we are introducing a
>>>> very different API, it would look odd to interact
>>>> with other subcommands without a normalized interaction. For example,
>>>> for 'prepare' this would be:
>>>>
>>>> ceph-disk prepare [...]
>>>>
>>>> And for LVM it would possible be
>>>>
>>>> ceph-disk lvm prepare [...]
>>>>
>>>> The level at which these similar actions are presented imply that one
>>>> may be a preferred (or even default) one, while the other one
>>>> isn't.
>>>>
>>>> At one point we are going to add regular disk worfklows (replacing
>>>> ceph-disk functionality) and then it would become even more
>>>> confusing to keep it there (or do you think at that point we could split?)
>>>>
>>>>>
>>>>> At the risk of being a bit picky about language, I don't like calling
>>>>> this anything with "volume" in the name, because afaik we've never
>>>>> ever called OSDs or the drives they occupy "volumes", so we're
>>>>> introducing a whole new noun, and a widely used (to mean different
>>>>> things) one at that.
>>>>>
>>>>
>>>> We have never called them 'volumes' because there was never anything
>>>> to support something other than regular disks, the approach
>>>> has always been disks and partitions.
>>>>
>>>> A "volume" can be a physical volume (e.g. a disk) or a logical one
>>>> (lvm, dmcache). It is an all-encompassing name to allow different
>>>> device-like to work with.
>>>
>>> The trouble with "volume" is that it means so many things in so many
>>> different storage systems -- I haven't often seen it used to mean
>>> "block device" or "drive".  It's more often used to describe a logical
>>> entity.  I also think "disk" is fine -- most people get the idea that
>>> a disk is a hard drive but it could also be any block device.
>>
>> If your thinking is that a disk can be any block device then yes, we
>> are at opposite ends here of our naming. We are picking a
>> "widely used" term because it is not specific. "disk" sounds fairly
>> specific, and we don't want that.
