From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: RBD boot from volume weirdness in OpenStack
Date: Thu, 25 Oct 2012 13:46:31 -0400
Message-ID: <CACkq2mp1Mo-Q2gKTXfHL4mskjPj-6DUgHf9mmcY+SR+4q_goug@mail.gmail.com>
References: <CACkq2mryT7Nsqs3W5HJ-pTDHqyuDjn4_dqiDp3+zv9=Wd3TJZA@mail.gmail.com>
 <bdf1660d88c03cd19087407dd63ef973@hq.newdream.net> <CACkq2mqwBmkgBoddP6=7oUq1_eL0O4E6MswRn6kzOLxjsXMpCg@mail.gmail.com>
 <CACkq2monRqHPvXBw3bL35P142s2q98qiC+MpEE5qTnNaaLaYZw@mail.gmail.com> <5089761F.1010204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43430 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab2JYRqw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 13:46:52 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so3664713qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 10:46:51 -0700 (PDT)
In-Reply-To: <5089761F.1010204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the pointers Josh.

Stupidly, I had not looked at those docs.  I forgot all about them
since they didn't used to be there.  I was only using OpenStack docs
and not the Ceph ones.  Looks like they are filled with great
information.  You answered all my questions!  Thanks again.

 - Travis

On Thu, Oct 25, 2012 at 1:25 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 10/25/2012 09:27 AM, Travis Rhoden wrote:
>>
>> Josh,
>>
>> Do you mind if I ask you a few follow-up questions?  I can ask on the
>> OpenStack ML if needed, but I think you are the most knowledgeable
>> person for these...
>
>
> I don't mind. ceph-devel is fine for these ceph-related questions.
>
>
>> 1. To get "efficient volumes from images" (i.e. volumes that are a COW
>> copy of the image), do the images and volumes need to live in the same
>> pool?  I have glance configured to use a pool called "glanceimages",
>> and nova-volume/Cinder uses a second pool called "nova-volume".  Is
>> this always going to prevent the COW process from working?  If I check
>> out my volume, I see this:
>>
>> # rbd -p nova-volume info volume-8c30ee47-5ec3-4600-b332-1bdc2a650837
>> rbd image 'volume-8c30ee47-5ec3-4600-b332-1bdc2a650837':
>>         size 220 MB in 55 objects
>>         order 22 (4096 KB objects)
>>         block_name_prefix: rb.0.1f04.4ba87ea2
>>         parent:  (pool -1)
>>
>> If the COW process is actually working, I think I'll see a parent
>> other than (pool -1), correct?
>
>
> They can be in different pools. With a COW clone you would see a parent
> there. Did you set show_image_direct_url=True for Glance (i.e.
> http://ceph.com/docs/master/rbd/rbd-openstack/#configuring-glance)?
>
>
>> I had split glance/cinder into different RADOS pools because I figured
>> it would give me more flexibility (could set different rep size/crush
>> rules) and potentially more security (use different cephx
>> clients/keys.  Glance keys aren't on nova-compute nodes, only glance
>> node).  But this isn't a strict requirement.
>
>
> Yeah, that's how it's designed to work. The Glance pool can
> be read-only from nova-compute, and Glance doesn't need access
> to the pool used for volumes.
>
>
>> 2. Do you know if "raw" is the only disk format accepted for
>> boot-from-volume?  I did the whole "create volume from image" step,
>> and my source image was a qcow2.  But when I do the boot-from-volume,
>> the -disk line contains format=raw.  Not sure how to control that
>> anymore -- there is no metadata attached to the volume that indicates
>> if it is qcow2 vs raw.  I'll have to dig into the code and see if
>> looks for anything.  Thought you might know...
>
>
> Raw is the only thing that works by default. Although it's possible
> to layer other formats on top of rbd, it's not well tested or
> recommended. Now that rbd supports cloning natively, there's not much
> benefit to e.g. qcow2 on top of it. The interfaces for QEMU and
> libvirt generally don't handle such layered formats well in any case.
>
>
>> 3.  I edited my libvirt XML to saw raw instead of qcow2, and the VM
>> started to boot!  Hooray!  boot-from-volume over RBD.  But then
>> console.log shows stuff like:
>>
>> Begin: Mounting root file system ... Begin: Running /scripts/local-top ...
>> done.
>> Begin: Running /scripts/local-premount ... done.
>> [    1.044112] EXT4-fs (vda1): mounted filesystem with ordered data
>> mode. Opts: (null)
>> Begin: Running /scripts/local-bottom ... [    1.052379] FDC 0 is a S82078B
>> done.
>> done.
>> Begin: Running /scripts/init-bottom ... done.
>> [    1.156951] Refined TSC clocksource calibration: 2266.803 MHz.
>> [    1.796114] end_request: I/O error, dev vda, sector 16065
>> [    1.800018] Buffer I/O error on device vda1, logical block 0
>> [    1.800018] lost page write due to I/O error on vda1
>> [    1.805294] EXT4-fs (vda1): re-mounted. Opts: (null)
>> cloud-init start-local running: Thu, 25 Oct 2012 16:06:34 +0000. up
>> 2.86 seconds^M
>> no instance data found in start-local^M
>> [    3.802465] end_request: I/O error, dev vda, sector 1257161
>> [    3.803629] Buffer I/O error on device vda1, logical block 155137
>> [    3.804020] Buffer I/O error on device vda1, logical block 155138
>> ....
>>
>>
>> And that just continues on and obviously the VM is unusable.  Any
>> thoughts on why that might happen.  You ever run into this during your
>> testing?
>
>
> I haven't seen such errors. It may be due to using qcow2 on top of rbd.
>
>
>> I'm thinking that I probably need to not use UEC images for this -- It
>> tries to go in and resize the file system and stuff like that.  I
>> should probably just make a bunch of fixed images (10G, 20G, etc.) and
>> make volumes from those.  Right now, I'm not even positive that the
>> RBD has even been formatted with a filesystem.
>
>
> UEC images work, but you have to convert them to raw first, as shown here:
>
> http://ceph.com/docs/master/rbd/rbd-openstack/#booting-from-a-block-device
>
>
>> Regards,
>>
>>   - Travis
>>
>> On Thu, Oct 25, 2012 at 11:51 AM, Travis Rhoden <trhoden@gmail.com> wrote:
>>>
>>> Awesome, thanks Josh.  I mispoke -- my client was 0.48.1.  glad
>>> upgrading to 0.48.2 will do the trick!  thanks again.
>>>
>>> On Thu, Oct 25, 2012 at 11:42 AM, Josh Durgin <josh.durgin@inktank.com>
>>> wrote:
>>>>
>>>> On 2012-10-25 08:22, Travis Rhoden wrote:
>>>>>
>>>>>
>>>>> I've been trying to take advantage of the code additions made by Josh
>>>>> Durgin to OpenStack Folsom for combining  boot-from-volume and Ceph
>>>>> RBD.  First off, nice work Josh!  I'm hoping you folks can help me out
>>>>> with something strange I am seeing.  The question may be more
>>>>> OpenStack related than Ceph, though, but hear me out first.
>>>>>
>>>>> I created a new volume (to use for boot-from-volume) from an existing
>>>>> image like so:
>>>>>
>>>>> #cinder create --display-name uec-test-vol --image-id
>>>>> 699137a2-a864-4a87-98fa-1684d7677044 5
>>>>>
>>>>> This completes just fine.
>>>>>
>>>>> Later I try to boot from it, that fails.  Cutting to the chase, here is
>>>>> why:
>>>>>
>>>>> kvm: -drive
>>>>>
>>>>>
>>>>>
>>>>> file=rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b,if=none,id=drive-virtio-disk0,format=raw,cache=none:
>>>>> error reading header from volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>>>>> kvm: -drive
>>>>>
>>>>>
>>>>>
>>>>> file=rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b,if=none,id=drive-virtio-disk0,format=raw,cache=none:
>>>>> could not open disk image
>>>>> rbd:nova-volume/volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b: No such
>>>>> file or directory
>>>>>
>>>>> It's weird that creating the volume was successful, but that KVM can't
>>>>> read it.  Poking around a bit more, it was clear why:
>>>>>
>>>>> # rbd -n client.novavolume --pool nova-volume ls
>>>>> <returns nothing>
>>>>>
>>>>> # rbd -n client.novavolume ls
>>>>> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>>>>>
>>>>> Okay, the volume is the "rbd" pool!  That's really weird, though.
>>>>> Here is the my nova.conf entries:
>>>>> volume_driver=nova.volume.driver.RBDDriver
>>>>> rbd_pool=nova-volume
>>>>> rbd_user=novavolume
>>>>>
>>>>>
>>>>> AND, here are the log entries from nova-volume.log (cleaned up a
>>>>> little):
>>>>>
>>>>> rbd create --pool nova-volume --size 5120
>>>>> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>>>>> rbd rm --pool nova-volume volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>>>>> rbd import --pool nova-volume /tmp/tmplQUwzt
>>>>> volume-9f4e4b70-7fbb-4d81-b912-b1c6fcf86c8b
>>>>>
>>>>> I'm not sure why it goes create/delete/import, but regardless all of
>>>>> that worked.  More importantly, all these commands used --pool
>>>>> nova-volume.  So how the heck did that RBD end up in the "rbd" pool
>>>>> instead of the "nova-volume" pool?  Any ideas?
>>>>>
>>>>> Before I hit "send", I figured I should at least test this myself.
>>>>> Watch
>>>>> this:
>>>>>
>>>>> #rbd create -n client.novavolume --pool nova-volume --size 1024 test
>>>>> # rbd ls -n client.novavolume --pool nova-volume
>>>>> test
>>>>> # rbd export -n client.novavolume --pool nova-volume test /tmp/test
>>>>> Exporting image: 100% complete...done.
>>>>> # rbd rm -n client.novavolume --pool nova-volume test
>>>>> Removing image: 100% complete...done.
>>>>> # rbd import -n client.novavolume --pool nova-volume /tmp/test test
>>>>> Importing image: 100% complete...done.
>>>>> # rbd ls -n client.novavolume --pool nova-volume
>>>>>
>>>>> # rbd ls -n client.novavolume --pool rbd
>>>>> test
>>>>>
>>>>>
>>>>> So it seems that "rbd import" doesn't honor the --pool argument?
>>>>
>>>>
>>>>
>>>> This was true in 0.48, but it should have been fixed in 0.48.2 (and
>>>> 0.52).
>>>> I'll add a note about this to the docs.
>>>>
>>>>
>>>>> I am using 0.53 on the backend, but my client is 0.48.2.  I'll upgrade
>>>>> that and see if that makes a different.
>>>>
>>>>
>>>>
>>>> The ceph-common package in particular should be 0.48.2 or >=0.52.
>>>>
>>>>>   - Travis
>>>>
>>>>
>>>>
>
