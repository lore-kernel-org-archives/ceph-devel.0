From: John Spray <jspray@redhat.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Thu, 12 May 2016 14:21:03 +0100
Message-ID: <CALe9h7fbdA5zPyva4CUSv0Mp+oG8AvCyd4bQeB2Nf4mnEfZ_jA@mail.gmail.com>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org>
 <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com> <loom.20160512T112356-917@post.gmane.org>
 <alpine.DEB.2.11.1605120832420.23446@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36400 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbcELNV3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 09:21:29 -0400
Received: by mail-oi0-f45.google.com with SMTP id x201so118963493oif.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 06:21:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605120832420.23446@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Naveen <Naveen.Chandrasekaran@radisys.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 12, 2016 at 1:37 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 12 May 2016, Naveen wrote:
>> Sage Weil <sage <at> newdream.net> writes:
>>
>>
>> > > > My question is:
>> > > > The SCSI LLD would support both read /write entry points for I/O
>> > > > requests issued by the filesystem/block I/O but they also support
>> some
>> > > > custom requests using IOCTLs. So how can ceph support issuing of
>> such
>> > > > IOCTL requests to the device if user issues such request. Say for
>> > > > example power cycling the drive etc. It can also be a passthro
>> request
>> > > > down to the device.
>> >
>> > Can you give an example of such an operation?
>> >
>> > In general, any operation is generalized at the librados level.
>> > For example, in order to get write same and cmpxchg block operations,
>> we
>> > added librados operations with similar semantics and implement them
>> there.
>> > It is unlikely that passing a complex operation down to the SCSI layer
>> > will work in unison with the other steps involved in committing
>> > an operation (e.g., updating metadata indicating the object
>> > version has changed).
>> >
>> > sage
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> > the body of a message to majordomo <at> vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
>>
>> Thanks for the response Sage. Example IOCTL operations would be like
>> downloading a new FW to the drive/HBA, task management requests like
>> Hard reset, power cycling the drive, issue a SAS/SMP/STP pass thro
>> command to the drive for querying etc. All these would have to be
>> initiated and go through ceph (if supported) and not bypassing it.
>
> Ah.  I think these kind of management functions should be performed while
> the ceph-osd daemon for that drive is offline.  We would probably want
> some hardware management layer that coexists with ceph or that perhaps has
> some minimal integration with the ceph osds to do this sort of thing.
> It's not something that a client (user) would initiate, though.

This is all pretty relevant to Joe Handzik's stuff:
https://github.com/joehandzik/ceph/commits/wip-hw-mgmt-cli
http://www.spinics.net/lists/ceph-devel/msg30126.html

The idea there though is to enable passing libstoragemgmt calls
through the OSD, as opposed to arbitrary SCSI operations.

Although libstoragemgmt is fairly young, I'm a fan of the idea that we
could use it internally within Ceph, and then have the same tools/libs
used by out-of-ceph management platforms when they want to do
equivalent stuff while the OSD is offline.

John


>> I asked a related question in another post too: Can a physical disk
>> (/dev/sda1) assigned to a ceph OSD object be continued to used by other
>> apps in the system to issue I/O directly via (/dev/sda1) interface? Does
>> ceph prevent it, as such operations may corrupt data?
>
> It depends on what privileges the other app has.  If it's root or user
> ceph, it can step all over the disk (and the rest of the system) and wreak
> havoc.  With the current backend, we are storing data as files, so you
> could have other apps using other directories on the file system--this is
> generally a bad idea for real deployments, though, as performance and disk
> utilization will be unpredictable.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
