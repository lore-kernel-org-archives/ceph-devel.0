From: "Handzik, Joseph" <joseph.t.handzik@hpe.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Thu, 12 May 2016 13:38:22 +0000
Message-ID: <98A1E741-0CAC-49CB-9701-18932EA6381B@hpe.com>
References: <loom.20160509T111456-471@post.gmane.org>
 <loom.20160511T061343-334@post.gmane.org>
 <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com>
 <loom.20160512T112356-917@post.gmane.org>
 <alpine.DEB.2.11.1605120832420.23446@cpach.fuggernut.com>,<CALe9h7fbdA5zPyva4CUSv0Mp+oG8AvCyd4bQeB2Nf4mnEfZ_jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0137.outbound.protection.outlook.com ([65.55.169.137]:26599
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751491AbcELPL0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 11:11:26 -0400
In-Reply-To: <CALe9h7fbdA5zPyva4CUSv0Mp+oG8AvCyd4bQeB2Nf4mnEfZ_jA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Naveen <Naveen.Chandrasekaran@radisys.com>, Ceph Development <ceph-devel@vger.kernel.org>

I was intentionally staying quiet to hear other opinions, but I agree that the same mechanisms I'm building for LED operations could extend here (within Ceph of we want it to, but at the very least in libstoragemgmt).

Naveen, if you have interest in helping push this along I'd encourage you to voice your interest over on the libstoragemgmt GitHub: https://github.com/libstorage/libstoragemgmt

Joe

> On May 12, 2016, at 8:22 AM, John Spray <jspray@redhat.com> wrote:
> 
>> On Thu, May 12, 2016 at 1:37 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Thu, 12 May 2016, Naveen wrote:
>>> Sage Weil <sage <at> newdream.net> writes:
>>> 
>>> 
>>>>>> My question is:
>>>>>> The SCSI LLD would support both read /write entry points for I/O
>>>>>> requests issued by the filesystem/block I/O but they also support
>>> some
>>>>>> custom requests using IOCTLs. So how can ceph support issuing of
>>> such
>>>>>> IOCTL requests to the device if user issues such request. Say for
>>>>>> example power cycling the drive etc. It can also be a passthro
>>> request
>>>>>> down to the device.
>>>> 
>>>> Can you give an example of such an operation?
>>>> 
>>>> In general, any operation is generalized at the librados level.
>>>> For example, in order to get write same and cmpxchg block operations,
>>> we
>>>> added librados operations with similar semantics and implement them
>>> there.
>>>> It is unlikely that passing a complex operation down to the SCSI layer
>>>> will work in unison with the other steps involved in committing
>>>> an operation (e.g., updating metadata indicating the object
>>>> version has changed).
>>>> 
>>>> sage
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in
>>>> the body of a message to majordomo <at> vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
>>> Thanks for the response Sage. Example IOCTL operations would be like
>>> downloading a new FW to the drive/HBA, task management requests like
>>> Hard reset, power cycling the drive, issue a SAS/SMP/STP pass thro
>>> command to the drive for querying etc. All these would have to be
>>> initiated and go through ceph (if supported) and not bypassing it.
>> 
>> Ah.  I think these kind of management functions should be performed while
>> the ceph-osd daemon for that drive is offline.  We would probably want
>> some hardware management layer that coexists with ceph or that perhaps has
>> some minimal integration with the ceph osds to do this sort of thing.
>> It's not something that a client (user) would initiate, though.
> 
> This is all pretty relevant to Joe Handzik's stuff:
> https://github.com/joehandzik/ceph/commits/wip-hw-mgmt-cli
> http://www.spinics.net/lists/ceph-devel/msg30126.html
> 
> The idea there though is to enable passing libstoragemgmt calls
> through the OSD, as opposed to arbitrary SCSI operations.
> 
> Although libstoragemgmt is fairly young, I'm a fan of the idea that we
> could use it internally within Ceph, and then have the same tools/libs
> used by out-of-ceph management platforms when they want to do
> equivalent stuff while the OSD is offline.
> 
> John
> 
> 
>>> I asked a related question in another post too: Can a physical disk
>>> (/dev/sda1) assigned to a ceph OSD object be continued to used by other
>>> apps in the system to issue I/O directly via (/dev/sda1) interface? Does
>>> ceph prevent it, as such operations may corrupt data?
>> 
>> It depends on what privileges the other app has.  If it's root or user
>> ceph, it can step all over the disk (and the rest of the system) and wreak
>> havoc.  With the current backend, we are storing data as files, so you
>> could have other apps using other directories on the file system--this is
>> generally a bad idea for real deployments, though, as performance and disk
>> utilization will be unpredictable.
>> 
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
