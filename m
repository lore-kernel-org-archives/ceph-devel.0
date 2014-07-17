From: Alphe Salas <asalas@kepler.cl>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 14:53:08 -0400
Message-ID: <53C81B94.3010004@kepler.cl>
References: <53C7D97D.3010607@kepler.cl> <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net> <53C81266.6080306@kepler.cl> <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:63205 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaGQSxN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 14:53:13 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so2225381qad.31
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 11:53:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


On 07/17/2014 02:27 PM, Sage Weil wrote:
> On Thu, 17 Jul 2014, Alphe Salas wrote:
>> On 07/17/2014 12:35 PM, Sage Weil wrote:
>>> On Thu, 17 Jul 2014, Alphe Salas wrote:
>>>> Hello,
>>>> I would like to know if there is something planned to correct the "forever
>>>> growing" effet when using rbd image.
>>>> My experience shows that the replicas of a rbd images are never discarded
>>>> and
>>>> never overwriten. Lets say my physical share is about 30 TB I make an
>>>> image of
>>>> 13TB (half the real space - 25% of disfunction osd support). My experience
>>>> shows that the rbd image is overwriten so if I top the 13TB once i get a
>>>> 26TB
>>>> of real space used (replicas set to 2) if I delete 8TB from those 13TB I
>>>> see
>>>> the real space used unchanged.
>>>> If I write back 4TB then ceph collapse it is nearfull and I have to go buy
>>>> another 30TB integrate it to my cluster to hold the problem. But still
>>>> soon I
>>>> have in my ceph more useless replicas of "delete" datas than usefull data
>>>> with
>>>> they replicas.
>>>>
>>>> Usually when I talk to dev team about this problem they tell me that the
>>>> real problem is the lack of trim in XFS, but my own analysis shows that
>>>> the real problem is ceph internal way to handle data. It is ceph that
>>>> never discard any replicas and never "clean" itself to only keep records
>>>> of the data in use.
>>
>>>
>>> You are correct that if XFS (or whatever FS you are using) does not issue
>>> discard/trim, then deleting data inside the fs on top of RBD won't free
>>> any space.  Note that you usually have to explicitly enable this via a
>>> mount option; most (all?) kernels still leave this off by default.
>>>
>>> Are you taking RBD snapshots?  If not, then there will never be more than
>>> the rbd image size * num_replicas space used (ignoring the few % of file
>>> system overhead for the moment).
>>>
>>> If you are taking snapshots, then yes.. you will see more space used until
>>> the snapshot is deleted because we will keep old copies of objects around.
>>
>> I am not using snapshot. I dont have enought space to write to the disk after
>> some round of write / delete /write / delete so I can t affort to use fancy
>> features like snapshots. I use regular image rbd type 1  not even able to be
>> snapshoot.
>>
>> I tryed to activate XFS trim system but that shown no change at all. (discard
>> mount option just have no real effect try in ubuntu 14.04)
>
> I believe you have to have mounted with -o discard at the time the data is
> deleted; simply enabling the option later won't help.  This is what
> the fstrim utility is for; see
>
> 	http://man7.org/linux/man-pages/man8/fstrim.8.html
>
>> Like I said what seems to grow in fact are the replica side of the data.
>> There is no overwriting of the replicas when real data are overwriten so
>> slowly I see the real disk weight of my datas in the ceph cluster grow, grow,
>> grow and never come to a stable size.
>
> This is simply not true.  RADOS object are overwritten in place.  If you
> create a 10 TB image and write it 100x with dd, you will still only
> consume 10 TB * num_replicas.  If you are seeing something other
> than this, ignore everything else in this email and go figure out what
> else is writing files to the underlying volumes.
>
Well I know it is dificult to beleive that the data are forever growing
in ceph I was thinking like you that data will overwrite on themselves 
for ever and ever after and that was not the case the rbd image part 
with or without triming was overwriten properly.
For example in my rbd image of 13TB i write 13TB then have the 
corresponding 13TB of replicas I delete 3TB of data normally I would see 
not data groth since rbd image is overwriten and replicas too. By in 
fact ceph -s show me then an overall use of 29TB which means 3TB of data 
have been added to the pull at this point ceph state is on warning too 
full and some osd just stop to receive anymore data.

  I have a mini ceph cluster where i will reproduce that behavior and 
bring you with the full log of it (step by step commands list and results).

>> There is the trick which layer of XFS are we talking about the layer inside
>> the rbd image ? or the one below the RBD image ?
>>
>> I already see a bug ticket from 2009 in ceph bug track that state that
>> XFS trim is not taken in consideration by ceph. That ticket doesn t seem to
>> have got a solution.
>>
>> and if I have XFS as format on the low end Ceph cluster and ext4 in the rbd
>> image how will trim works?
>
> I assume you are using kvm/qemu?  It may be that older versions aren't
> passing through trims; Josh would know more.  Or maybe the trim sizes are
> too small to let rados effectively deallocate entire objects.  Logs might
> help there.
>
> But, as I said, if you see more data written than the size of your image
> then stop worrying about trim and sort that out first...
>
>> Low level XFS (of the osd disks ) have mount options that are not managed by
>> the user it is auto process of mount when the osd is activated in that
>> consideration how do I activate the trim ? Do I have to put the hands on udev
>> level scripts ?
>
> Trim on the underlying XFS volumes isn't necessary or important.  When RBD
> gets a discard, it will either delete, truncate, or punch holes in the
> underlying XFS object files the image maps too.
>
> sage
>
>

As usual thank you for dedicating time to interact with me I know you 
have a billion things doing but this is bothering me and I need to sort 
it out.


Alphe Salas
I.T ingeneer
