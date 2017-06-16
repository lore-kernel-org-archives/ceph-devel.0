From: Z Will <zhao6305@gmail.com>
Subject: Re: [ceph-users] Help build a drive reliability service!
Date: Fri, 16 Jun 2017 11:48:16 +0800
Message-ID: <CAGOEmcPZy9uXoD99yaH1xK-VWbgiutduc-CQqy8XXsJzfwo6pg@mail.gmail.com>
References: <CAAZbbf3kS+KQ06KFe=p=Gn1Qmb8xen35U5CLgpcq3BaTT+e5Vg@mail.gmail.com>
 <CABZ+qqmiKrca=AsoAYS3CaW+TTOieoSn1T_Z=gWzaxzmeA1stQ@mail.gmail.com> <CAN-GepKfC5iJuVTioizXm=aDAXuuXFyHBGEaos2eG91bfZM-yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34014 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdFPDsS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jun 2017 23:48:18 -0400
Received: by mail-io0-f171.google.com with SMTP id i7so23019694ioe.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 20:48:17 -0700 (PDT)
In-Reply-To: <CAN-GepKfC5iJuVTioizXm=aDAXuuXFyHBGEaos2eG91bfZM-yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: Dan van der Ster <dan@vanderster.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>, David Turner <drakonstein@gmail.com>

Hi Patrick:
    I want to ask a  very tiny question. How much 9s do you claim your
storage durability? And how is it calculated ? Based on the data you
provided , have you find some failure model to refine the storage
durability ?

On Thu, Jun 15, 2017 at 12:09 AM, David Turner <drakonstein@gmail.com> wrote:
> I understand concern over annoying drive manufacturers, but if you have data
> to back it up you aren't slandering a drive manufacturer.  If they don't
> like the numbers that are found, then they should up their game or at least
> request that you put in how your tests negatively affected their drive
> endurance.  For instance, WD Red drives are out of warranty just by being
> placed in a chassis with more than 4 disks because they aren't rated for the
> increased vibration from that many disks in a chassis.
>
> OTOH, if you are testing the drives within the bounds of the drives
> warranty, and not doing anything against the recommendation of the
> manufacturer in the test use case (both physical and software), then there
> is no slander when you say that drive A outperformed drive B.  I know that
> the drives I run at home are not nearly as resilient as the drives that I
> use at the office, but I don't put my home cluster through a fraction of the
> strain that I do at the office.  The manufacturer knows that their cheaper
> drive isn't as resilient as the more robust enterprise drives.  Anyway, I'm
> sure you guys have thought about all of that and are _generally_ pretty
> smart. ;)
>
> In an early warning system that detects a drive that is close to failing,
> you could implement a command to migrate off of the disk and then run
> non-stop IO on it to finish off the disk to satisfy warranties.  Potentially
> this could be implemented with the osd daemon via a burn-in start-up option.
> Where it can be an OSD in the cluster that does not check in as up, but with
> a different status so you can still monitor the health of the failing drive
> from a ceph status.  This could also be useful for people that would like to
> burn-in their drives, but don't want to dedicate infrastructure to
> burning-in new disks before deploying them.  Making this as easy as possible
> on the end user/ceph admin, there could even be a ceph.conf option for OSDs
> that are added to the cluster and have never been been marked in to run
> through a burn-in of X seconds (changeable in the config and defaults to 0
> as to not change the default behavior).  I don't know if this is
> over-thinking it or adding complexity where it shouldn't be, but it could be
> used to get a drive to fail to use for an RMA.  OTOH, for large deployments
> we would RMA drives in batches and were never asked to prove that the drive
> failed.  We would RMA drives off of medium errors for HDDs and smart info
> for SSDs and of course for full failures.
>
> On Wed, Jun 14, 2017 at 11:38 AM Dan van der Ster <dan@vanderster.com>
> wrote:
>>
>> Hi Patrick,
>>
>> We've just discussed this internally and I wanted to share some notes.
>>
>> First, there are at least three separate efforts in our IT dept to
>> collect and analyse SMART data -- its clearly a popular idea and
>> simple to implement, but this leads to repetition and begs for a
>> common, good solution.
>>
>> One (perhaps trivial) issue is that it is hard to define exactly when
>> a drive has failed -- it varies depending on the storage system. For
>> Ceph I would define failure as EIO, which normally correlates with a
>> drive medium error, but there were other ideas here. So if this should
>> be a general purpose service, the sensor should have a pluggable
>> failure indicator.
>>
>> There was also debate about what exactly we could do with a failure
>> prediction model. Suppose the predictor told us a drive should fail in
>> one week. We could proactively drain that disk, but then would it
>> still fail? Will the vendor replace that drive under warranty only if
>> it was *about to fail*?
>>
>> Lastly, and more importantly, there is a general hesitation to publish
>> this kind of data openly, given how negatively it could impact a
>> manufacturer. Our lab certainly couldn't publish a report saying "here
>> are the most and least reliable drives". I don't know if anonymising
>> the data sources would help here, but anyway I'm curious what are your
>> thoughts on that point. Maybe what can come out of this are the
>> _components_ of a drive reliability service, which could then be
>> deployed privately or publicly as appropriate.
>>
>> Thanks!
>>
>> Dan
>>
>>
>>
>>
>> On Wed, May 24, 2017 at 8:57 PM, Patrick McGarry <pmcgarry@redhat.com>
>> wrote:
>> > Hey cephers,
>> >
>> > Just wanted to share the genesis of a new community project that could
>> > use a few helping hands (and any amount of feedback/discussion that
>> > you might like to offer).
>> >
>> > As a bit of backstory, around 2013 the Backblaze folks started
>> > publishing statistics about hard drive reliability from within their
>> > data center for the world to consume. This included things like model,
>> > make, failure state, and SMART data. If you would like to view the
>> > Backblaze data set, you can find it at:
>> >
>> > https://www.backblaze.com/b2/hard-drive-test-data.html
>> >
>> > While most major cloud providers are doing this for themselves
>> > internally, we would like to replicate/enhance this effort across a
>> > much wider segment of the population as a free service.  I think we
>> > have a pretty good handle on the server/platform side of things, and a
>> > couple of people who have expressed interest in building the
>> > reliability model (although we could always use more!), what we really
>> > need is a passionate volunteer who would like to come forward to write
>> > the agent that sits on the drives, aggregates data, and submits daily
>> > stats reports via an API (and potentially receives information back as
>> > results are calculated about MTTF or potential to fail in the next
>> > 24-48 hrs).
>> >
>> > Currently my thinking is to build our collection method based on the
>> > Backblaze data set so that we can use it to train our model and build
>> > from going forward. If this sounds like a project you would like to be
>> > involved in (especially if you're from Backblaze!) please let me know.
>> > I think a first pass of the agent should be something we can build in
>> > a couple of afternoons to start testing with a small pilot group that
>> > we already have available.
>> >
>> > Happy to entertain any thoughts or feedback that people might have.
>> > Thanks!
>> >
>> > --
>> >
>> > Best Regards,
>> >
>> > Patrick McGarry
>> > Director Ceph Community || Red Hat
>> > http://ceph.com  ||  http://community.redhat.com
>> > @scuttlemonkey || @ceph
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
