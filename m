From: Alex Elder <elder@ieee.org>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Wed, 24 Aug 2016 13:44:42 -0500
Message-ID: <7a3b5e29-5cdb-553f-c10a-ce2f1945f3b1@ieee.org>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
 <4257DB75-0060-4867-A5D5-2AD374722452@Teradata.com>
 <CAOi1vP9mdNYRCD_cTa0=4tN71L1=tA24wXSr2NqhTH9BmUBAuw@mail.gmail.com>
 <82369305-99D9-464E-B14A-D2E91AC7B76F@Teradata.com>
 <847a97cf-04b3-9f29-2884-5c757727b3a2@ieee.org>
 <CAOi1vP-nuRzksfvaCZ1nj6sTmxsH=XS2PdAFj_9j94FtMcpFqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35972 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755812AbcHXSop (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 14:44:45 -0400
Received: by mail-it0-f43.google.com with SMTP id e63so227673751ith.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 11:44:45 -0700 (PDT)
In-Reply-To: <CAOi1vP-nuRzksfvaCZ1nj6sTmxsH=XS2PdAFj_9j94FtMcpFqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, Jason Dillaman <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

On 08/13/2016 02:14 PM, Ilya Dryomov wrote:
> On Sat, Aug 13, 2016 at 5:18 PM, Alex Elder <elder@ieee.org> wrote:
>> On 08/12/2016 01:40 PM, Kamble, Nitin A wrote:
>>>> It would make this a lot easier if we started generating a unique UUID
>>>>>>> for the image and each snapshot at image/snapshot creation time.  Jason?
>>>>>>>
>>>>>
>>>>> Image UUID seems like the right direction.

I'm really sorry I didn't respond to this earlier.  I sent out
my message and promptly went on vacation for a week.

>> Yes.  It's not a snapshot you want, but the basic image, regardless
>> of the state of its content.  It needs to be created at image
> 
> I'm not sure I follow.  We need to have an identifier for each mappable
> entity - that's images (HEADs) and snapshots.

I guess it really boils down to what you intend this
unique identifier to represent.  SCSI has VPD data
pages for device identification.  I *think* these
are intended to allow a physical device or logical
unit to have a persistent, globally unique identifier.
I haven't worked with the SCSI specs in a *long* time
though, and I'm just scanning an SPC draft right now.

Anyway, my earlier response was based on the notion that
you wanted to identify some RBD image equivalent of a
hardware unique identifier, much as you might have for
identifying a single physical disk drive.  In that case,
the identifier should be generated at image creation time.
If a copy of an image were created, it might contain the
same data, but would necessarily have a different UUID
for the duplicate image.

The complication is that we really aren't dealing with
physical entities here.  It is not possible to truly
duplicate a physical disk drive in the same way we
can duplicate an RBD image.  And there is no concept
of a snapshot or clone for a physical disk.

I don't actually know how exactly this identifier is
intended to be used, and I probably just spoke with
an improper understanding.

>> creation time, and no matter how many times the image grows or
>> shrinks, or how the cluster gets reorganized along the way, that
>> UUID uniquely defines the image (and it ought not to be possible,
>> as a rule, to *change* an image's UUID).  Coping an entire image
> 
> Why?  IMO it shouldn't be any different from a filesystem UUID - a user
> should be able to create an image (snapshot) with the specified UUID,
> change it at any time and maybe even clear it (allowing clear makes
> older images a non-issue).  We already have an unchangeable pool-wide
> ID for ourselves, this is aimed at users and they should be in full
> control here.

That may be the better model in this case.  That is, the
UUID you're talking about is a soft label that's unique,
but changeable.  The model I had in my mind was more like
an airplane serial number plate; you can replace every
part on an airplane, but it remains "the same airplane"
as long as it has on it the plate that shows the original
serial number.

>> (or cloning) would require a new UUID (as has been said).
>>
>> I think the UUID should be defined independent of the cluster as
>> well.  In that case, there may be a reason to think about a "move"
>> operation, where it an image is transferred to a new cluster, with
>> the new one retaining the original UUID and the old one going away.
> 
> By default, it would be a randomly-generated UUID.  What I had meant
> when I said "we can couple it with a cluster UUID too" was that we can
> export a cluster UUID along with an image UUID.

Again, sorry for the delay in responding to you.  I don't
claim to know the answer, but I think you need to be very
clear on what the UUID you're talking about really represents.
Mimicking the SCSI inquiry interface is reasonable, but we
are dealing with something that isn't exactly like a SCSI
device, so I think precision on the meaning will be important.

					-Alex


> 
> Thanks,
> 
>                 Ilya
> 

