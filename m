From: Alfredo Deza <adeza@redhat.com>
Subject: Re: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Tue, 20 Jun 2017 10:09:43 -0400
Message-ID: <CAC-Np1wb9hdNcCP+iC-ookv3E-mGz0pDsCuBPsCgGQ5Eyu2UTg@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
 <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
 <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com>
 <CAC-Np1xe3M9WdNGTZrMhf1inhQBWzT5OLc7BexKCa8ngeUJhRw@mail.gmail.com> <alpine.DEB.2.11.1706192145151.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34810 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdFTOJq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 10:09:46 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so92664951wrb.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 07:09:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706192145151.32269@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 5:58 PM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 19 Jun 2017, Alfredo Deza wrote:
>> On Mon, Jun 19, 2017 at 4:24 PM, John Spray <jspray@redhat.com> wrote:
>> > On Mon, Jun 19, 2017 at 6:53 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> >>>> * faster release cycles
>> >>>> * easier and faster to test
>> >>>
>> >>> I think having one part of Ceph on a different release cycle to the
>> >>> rest of Ceph is an even more dramatic thing than having it in a
>> >>> separate git repository.
>> >>>
>> >>> It seems like there is some dissatisfaction with how the Ceph project
>> >>> as whole is doing things that is driving you to try and do work
>> >>> outside of the repo where the rest of the project lives -- if the
>> >>> release cycles or test infrastructure within Ceph are not adequate for
>> >>> the tool that formats drives for OSDs, what can we do to fix them?
>> >>
>> >> It isn't Ceph the project :)
>> >>
>> >> Not every tool about Ceph has to come from ceph.git, in which case the
>> >> argument could be flipped around: why isn't ceph-installer,
>> >> ceph-ansible, ceph-deploy, radosgw-agent, etc... all coming from
>> >> within ceph.git ?
>> >
>> > ceph-installer, ceph-deploy and ceph-ansible are special cases because
>> > they are installers, that operate before a particular version of Ceph
>> > has been selected for installation, and might operate on two
>> > differently versioned clusters at the same time.
>>
>> This is a perfect use case for ceph-volume, the OSD doesn't (and in
>> most cases this is true) care what is beneath it, as long
>> as it is mounted and has what it needs to function. The rest is
>> *almost like installation*.
>
> This isn't really true.  ceph-volume (or ceph-disk lvm, or whatever we
> call it) is going to have specific knowledge about how to provision the
> OSD.  When we change the bootstrap-osd caps and change hte semantics of
> 'osd new' (take, for example, teh change we just made from 'osd create' to
> 'osd new'), then ceph-mon, the cephx caps, and ceph-disk all have to
> change in unison.  More concretely, with bluestore we have all kinds of
> choices of how we provision the volumes (what sizes, what options for
> rocksdb, whatever), those opinions will be enshrine in ceph-volume, and
> they will change from version to version... likely in unison with
> bluestore itself (as the code changes the best practice and
> recommendations change with it).

I don't see this any different from provisioning. As Ceph changes, so
does provisioning in installers, provisioning an OSD may change
as Ceph adds more options, just like we've seen on installers.

You mention the bootstrap caps, and we've had logic to deal with those
types of changes before out of tree.

>
> In contrast, I can't think of a reason why ceph-volume without change
> independently of ceph-osd.  There is no bootstrap issue like with
> installation.  And no reason why you would want to run different between
> different versions.
>
>
>
>> > radosgw-agent, presumably (I haven't worked on it) is separate because
>> > it sits between two clusters but is logically part of neither, and
>> > those clusters could potentially be different-versioned too.
>> >
>> > ceph-disk, on the other hand, rides alongside ceph-osd, writes a
>> > format that ceph-osd needs to understand, the two go together
>> > everywhere.  You use whatever version of ceph-disk corresponds to the
>> > ceph-osd package you have.  You run whatever ceph-osd corresponds to
>> > the version of ceph-disk you just used.  The two things are not
>> > separate, any more than ceph-objectstore-tool would be.
>>
>> The OSD needs a mounted volume that has pieces that the OSD itself
>> puts in there. It is a bit convoluted because
>> there are other steps, but the tool itself isn't crucial for the OSD
>> to function, it is borderline an orchestrator to get the volume
>> where the OSD runs ready.
>>
>> >
>> > It would be more intuitive if we had called ceph-disk
>> > "ceph-osd-format" or similar.  The utility that prepares drives for
>> > use by the OSD naturally belongs in the same package (or at the very
>> > least the same release!) as the OSD code that reads that on-disk
>> > format.
>> >
>> > There is a very clear distinction in my mind between things that
>> > install Ceph (i.e. they operate before the ceph packages are on the
>> > system), and things that prepare the system (a particular Ceph version
>> > is already installed, we're just getting ready to run it).
>> > ceph-objectstore-tool would be another example of something that
>> > operates on the drives, but is intimately coupled to the OSDs and
>> > would not make sense as a separately released thing.
>>
>> And ceph-disk isn't really coupled (maybe a tiny corner of it is). Or
>> maybe you can exemplify how those are tied? I've gone through every
>> single step to get an OSD, and although in some cases it is a bit more
>> complex, it isn't more than a few steps (6 in total from our own docs):
>>
>> http://docs.ceph.com/docs/master/rados/operations/add-or-rm-osds/#adding-an-osd-manual
>>
>> ceph-ansible *does* prepare a system for running Ceph, so does
>> ceph-docker. ceph-disk has had some pitfalls that ceph-ansible has to
>> workaround, and has to implement other things as well to be able to
>> deploy OSDs.
>
> Again, I think the 'osd create' -> 'osd new' is a perfect example of
> coupling.  And I anticipate others with bluestore.  For example, when we
> start supporting SPDK for NVMe (kernel bypass) the interface for setting
> that up will likely evolve and will need to match the behavior in
> ceph-volume.
>
> [...]
>
> Perhaps we can look at this from the other angle, though?  Why *should*
> this particular tool be separate?
>

The push back for getting pulled into ceph.git was unexpected, and I
think that is partly because there is no clear guidelines
into what should (or shouldn't) go in. To me, a tool doesn't need to
be in tree if:

* it doesn't consume bindings (e.g. pybind)
* other parts of the project do not depend on it directly (for
example: ceph-osd calling ceph-volume)

This is similar to why I argued against including JS and CSS files for
the dashboard.

>
>> >>>> Is your argument only to have parity in Ceph's branching? That was
>> >>>> never a problem with out-of-tree tools like ceph-deploy for example.
>> >>>
>> >>> I guess my argument isn't so much an argument as it is an assertion
>> >>> that if you want to go your own way then you need to have a really
>> >>> strong clear reason.
>> >>
>> >> Many! Like I mentioned: easier testing, faster release cycle, can
>> >> publish in any package index, doesn't need anything in ceph.git to
>> >> operate, etc..
>> >
>> > Testing: being separate is only easier if you're only doing python
>> > unit testing.  If you're testing that ceph-disk/ceph-volume really
>> > does its job, then you absolutely do want to be in the ceph tree, so
>> > that you can fire up an OSD that checks that ceph-disk really did it's
>> > job.
>> >
>> > Faster release cycle: we release pretty often.
>>
>> Uh, it depends on what "fast" means for you. 4 months waiting on a
>> ceph-disk issue that was fixed/merged to have ceph-ansible not have that
>> bug is not really fast.
>
> Can you be tell us more about this incident?  We are regular backport
> changes to the stable branches, and have a pretty regular cadence for
> stable release.

ceph-disk reported issue on November 2016
https://bugzilla.redhat.com/show_bug.cgi?id=1391920
Fix was merged on February: https://github.com/ceph/ceph/pull/13573
Backport ticket was created in February http://tracker.ceph.com/issues/18972
And was closed/merged in May

That is: after having a fix in February, it was finally backported in May.

With a decoupled project this could've been released in February. This
is exactly the same behavior we had in ceph-deploy,
when it had so many issues being fixed that it wasn't odd to see up to
two releases per week.

>
>> >  We release often
>> > enough to deal with critical OSD and mon bugs.  The tool that formats
>> > OSDs doesn't need to be released more often than the OSD itself.
>>
>> It does need to be released often when the tool is new!
>
> For development, we are doing builds on a continuous basis, with new
> 'master' or branch packages every few hours in most cases.  And all of our
> deployment tools can deploy those test branches...
>
>
>> > I know how backwards that must sound, when you're looking at the
>> > possibility of having a nice self contained git repo, that contains a
>> > pypi-eligible python module, which has unit tests that run fast in
>> > jenkins on every commit.  I get the appeal!  But for the sake of the
>> > overall simplicity of Ceph, please think again, or if you really want
>> > to convert us to a multi-repo model, then make that case for the
>> > project as a whole rather than doing it individually on a bit-by-bit
>> > basis.
>>
>> We can't make the world of Ceph repos to abide today by a multi-repo
>> model. I would need to counter argue you for a few more months :)
>>
>> The examples you give for ceph-disk, and how ceph-disk is today, is why
>> we want to change things.
>>
>> It is not only faster unit tests, or a "nice self contained git repo"
>> just because we want to release to PyPI, we are facing a situation where
>> we need faster development and increased release cycles that we can't
>> get being in an already big repository.
>
> If I'm reading this right, the core reason is "faster development and
> increased release cycles".  Can you explain what that means at a
> practical level?  We build packages all day every day, and don't generally
> need packages at all for development testing.  And any release that
> uses ceph-volume is weeks away, and will be followed up by a regular
> cadence of point releases.  Where is the limitation?

Anyone that is using LVM today with Ceph will be able to use
`ceph-volume lvm` to provision an OSD using filestore.

If the tool went into Ceph, it would mean it would not be possible to
use, up until they upgrade to that version of Ceph. There is no
reason to have to wait in this case, ceph-volume does not depend on
functionality in Ceph that is not yet released. If the tool was ready
today, any
LVM user could migrate right away.

The practical reasons for development (and again, given that this tool
doesn't depend on any internal APIs or bindings) are:

* submitting a PR doesn't need to wait for `make check` (about 1 hour
vs. just a couple of minutes) - there is no way to decouple, say,
ceph-disk tests from `make check`
  so that a PR that has code for ceph-disk can run only ceph-disk
tests. Our tooling, branch triggers, Github integration, and Jenkins
all look at the repository, they can't really
  determine what piece of code changed so it runs a subset of that.
* functional testing can be leveraged using ceph-ansible tests, that
can run anywhere, usually under 30 minutes
* building a binary (rpm/deb) means a few minutes, not 1 hour because
we need to wait for every other Ceph binary

None of these are meant to criticize Ceph release cycles, or
development workflows (I would know better since I implemented some of
them!)

Going back to the reasoning, I can see how John thinks in some cases
is best to have everything in one repository with the exception of
deployment tools, but that
is an assumption. There are things in the tree that just don't need to
be there (ceph-detect-init is a good example) but without a clear
guideline (is it a deployment tool?
a library? does it consume an internal API/binding?) or expectation
(wait for other ceph tests, can't run only tests for the tool on PRs)
we can't really make a point
about either way, and we are now mainly discussing a preference:

- As an LVM user today, I would prefer to not have to wait (without a
good reason) to upgrade to make use of LVM for an OSD.
- As a developer of the tool, I prefer faster tests, faster build
times, frequent release times

Whenever there is a ceph-deploy release, this is very transparent to
the end user: it gets included in every Ceph repository. So
installation/availability is the same as if it came
from Ceph itself.

That is why I believe that if we are so insisting in having it
in-tree, lets wait until it stabilizes, when we don't need to release
often, when the excuse of "I use LVM today and I don't want to upgrade
just to be
able to deploy an OSD with LVM" is no longer valid because the tool
has been around long enough.

No user is going to have to go through the exercise of having to
understand "where do I install $version of ceph-volume to work with
$version of ceph". The package is going to live in the same place in
the end.

The "overall simplicity of Ceph" will not change because this tool
lives in a separate git repository.

>
> Thanks!
> sage
>
>
>>
>>
>> >
>> > John
>> >
>> >> Even in some cases like pybind, it has been requested numerous times
>> >> to get them on separate package indexes like PyPI, but that has always
>> >> been
>> >> *tremendously* difficult: http://tracker.ceph.com/issues/5900
>> >>>>>  - I agree with others that a single entrypoint (i.e. executable) will
>> >>>>> be more manageable than having conspicuously separate tools, but we
>> >>>>> shouldn't worry too much about making things "plugins" as such -- they
>> >>>>> can just be distinct code inside one tool, sharing as much or as
>> >>>>> little as they need.
>> >>>>>
>> >>>>> What if we delivered this set of LVM functionality as "ceph-disk lvm
>> >>>>> ..." commands to minimise the impression that the tooling is changing,
>> >>>>> even if internally it's all new/distinct code?
>> >>>>
>> >>>> That sounded appealing initially, but because we are introducing a
>> >>>> very different API, it would look odd to interact
>> >>>> with other subcommands without a normalized interaction. For example,
>> >>>> for 'prepare' this would be:
>> >>>>
>> >>>> ceph-disk prepare [...]
>> >>>>
>> >>>> And for LVM it would possible be
>> >>>>
>> >>>> ceph-disk lvm prepare [...]
>> >>>>
>> >>>> The level at which these similar actions are presented imply that one
>> >>>> may be a preferred (or even default) one, while the other one
>> >>>> isn't.
>> >>>>
>> >>>> At one point we are going to add regular disk worfklows (replacing
>> >>>> ceph-disk functionality) and then it would become even more
>> >>>> confusing to keep it there (or do you think at that point we could split?)
>> >>>>
>> >>>>>
>> >>>>> At the risk of being a bit picky about language, I don't like calling
>> >>>>> this anything with "volume" in the name, because afaik we've never
>> >>>>> ever called OSDs or the drives they occupy "volumes", so we're
>> >>>>> introducing a whole new noun, and a widely used (to mean different
>> >>>>> things) one at that.
>> >>>>>
>> >>>>
>> >>>> We have never called them 'volumes' because there was never anything
>> >>>> to support something other than regular disks, the approach
>> >>>> has always been disks and partitions.
>> >>>>
>> >>>> A "volume" can be a physical volume (e.g. a disk) or a logical one
>> >>>> (lvm, dmcache). It is an all-encompassing name to allow different
>> >>>> device-like to work with.
>> >>>
>> >>> The trouble with "volume" is that it means so many things in so many
>> >>> different storage systems -- I haven't often seen it used to mean
>> >>> "block device" or "drive".  It's more often used to describe a logical
>> >>> entity.  I also think "disk" is fine -- most people get the idea that
>> >>> a disk is a hard drive but it could also be any block device.
>> >>
>> >> If your thinking is that a disk can be any block device then yes, we
>> >> are at opposite ends here of our naming. We are picking a
>> >> "widely used" term because it is not specific. "disk" sounds fairly
>> >> specific, and we don't want that.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
