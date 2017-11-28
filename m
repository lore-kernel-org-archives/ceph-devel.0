From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 07:00:38 -0500
Message-ID: <CAC-Np1wF8Xu=Npy5j_mCL0fDwF9QnRSuwczGq=PFBK=zsxr41w@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <f6e851fd-b4d8-8f79-c017-267dc0e30199@suse.cz> <20171128082401.wumj4qo5pi4hawtg@nora.maurer-it.com>
 <CALWuvY9mX0Pdr4aMwPi=Dqw0qng959Z5bg5hs5dOxTfSZ+QH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:40493 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754454AbdK1MAj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 07:00:39 -0500
Received: by mail-qt0-f179.google.com with SMTP id u42so112321qte.7
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 04:00:39 -0800 (PST)
In-Reply-To: <CALWuvY9mX0Pdr4aMwPi=Dqw0qng959Z5bg5hs5dOxTfSZ+QH4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nokia ceph <nokiacephusers@gmail.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 28, 2017 at 3:42 AM, nokia ceph <nokiacephusers@gmail.com> wrote:
> Hello,
>
> Can you share repo url (https://shaman.ceph.com/repos/ceph/) to download
> these rpms to test this behavior.Currenly I'm testing with 12.2.1 version.

You might want to take a look at: https://shaman.ceph.com/repos/ceph/luminous/

And see what SHA1 (or latest build) you want to try.

>
>  Also please let us know when can we expect the official 12.2.2 release ?
>
> While is more recommended for bluestore , lvm or simple ? in terms of
> performance / stability ?

The `simple` command would just be for taking over existing OSDs, in
however manner you've deployed them (even if the OSDs were created
manually)

For bluestore (the default objectstore in 12.2.2) it will be
`ceph-volume lvm` what you want.

>
> As per
> http://docs.ceph.com/docs/master/ceph-volume/simple/#ceph-volume-simple I
> beleive for existing OSD's created with ceph-disk to convert to simple, I
> need to trigger below procedure.
>
> http://docs.ceph.com/docs/master/ceph-volume/simple/activate/#ceph-volume-simple-activate
>
> So by making this, do we need to disable system-ceph\x2ddisk.slice service ?

ceph-volume will disable all ceph-disk systemd units for you, so that
UDEV triggers will no longer be a problem.

>
> Thanks
>
>
>
> On Tue, Nov 28, 2017 at 1:54 PM, Fabian Grünbichler
> <f.gruenbichler@proxmox.com> wrote:
>>
>> On Mon, Nov 27, 2017 at 09:07:02PM +0100, Nathan Cutler wrote:
>> > > A few items to consider:
>> > >
>> > > * ceph-disk is expected to be fully removed by the Mimic release
>> >
>> > It's pretty standard in the software world to deprecate in one release
>> > and
>> > remove in the next. Maybe I'm blind, but I didn't see anything in the
>> > announcement explaining why deprecation *and* removal in a single
>> > release
>> > cycle is warranted in this case?
>>
>> Especially since ceph-volume has been undergoing lots of changes in the
>> recent weeks and months, so I highly doubt it has seen enough testing to
>> support such an abrupt change[1].
>>
>> Maybe removing the deprecation warning for now, highlighting ceph-volume
>> in the release notes for 12.2.2 and then re-adding the deprecation
>> warning later on in the Luminous cycle (or even just the Mimic RCs) is
>> more advisable?
>>
>> 1: 90 commits touching src/ceph-volume since v12.2.1, not counting those
>> having "test" in the commit subject - that's about 12% of all non-"test"
>> commits currently slated for v12.2.2!
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
