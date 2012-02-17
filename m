From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Problem with inconsistent PG
Date: Fri, 17 Feb 2012 19:13:06 +0100
Message-ID: <2583B67A-471D-41DF-862E-7B1E5EA88520@filoo.de>
References: <4F37A9F5.6030908@filoo.de> <Pine.LNX.4.64.1202130910330.13736@cobra.newdream.net> <44CF33BD-97D2-4532-BA7E-2304CA73F09F@filoo.de> <Pine.LNX.4.64.1202160911300.7873@cobra.newdream.net> <17FB8C39-0D70-4019-8674-D0BB33664FE8@filoo.de> <Pine.LNX.4.64.1202160956020.13790@cobra.newdream.net> <010F0C8C-0338-40A6-9CBE-5840A7B53844@filoo.de> <Pine.LNX.4.64.1202170930330.29318@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:53455 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2BQSNJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 13:13:09 -0500
In-Reply-To: <Pine.LNX.4.64.1202170930330.29318@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Well,

Am 17.02.2012 um 18:54 schrieb Sage Weil:

> On Fri, 17 Feb 2012, Oliver Francke wrote:
>> Well then,
>> 
>> found it via the "ceph osd dump" via the pool-id, thanks. The according customer
>> opened a ticket this morning for not being able to boot his VM after shutdown.
>> So I had to do some testdisk/fsck and tar the content into a new image.
>> 
>> I hope, there are no other "bad blocks" not being visible as "inconsistencies".
>> 
>> As these faulty images were easy detected as the boot-block was affected, how
>> big is the chance, that there are more rb..-fragments being corrupted within a image
>> in reference to what you mentioned below:
>> 
>> "...transactions to leak across checkpoint/snapshot boundaries."
>> 
>> Do we have a chance to detect it? I fear not, cause it will perhaps only be visible while
>> doing a "fsck" inside the VM?!
> 
> It is hard to say.  There is a small chance that it will trigger any time 
> ceph-osd is restarted.  The bug is fixed in the next release (which should 
> be out today), but of course upgrading involves shutting down :(.  
> Alternatively, you can cherry-pick the fixes, 
> 1009d1a016f049e19ad729a0c00a354a3956caf7 and 
> 93d7ef96316f30d3d7caefe07a5a747ce883ca2d.  v0.42 includes some encoding 
> changes that means you can upgrade but you can't downgrade again.  (These 
> encoding changes are being made so that in the future, you _can_ 
> downgrade.)
> 
> Here's what I suggest:
> 
> - don't restart any ceph-osds if you can help it
> - wait for v0.42 to come out, and wait until Monday at least
> - pause read/write traffic to the cluster with
> 
> ceph osd pause
> 
> - wait at least 30 seconds for osds to do a commit without any load.  
>   this makes it extremely unlikely you'd trigger the bug.
> - upgrade to v0.42, or restart with a patched ceph-osd.
> - unpause io with
> 
> ceph osd unpause
> 

that sounds reasonable, cool stuff ;-)

Thnx again,

Oliver.

> sage
> 
> 
> 
>> 
>> Anyway, thanks for your help and best regards,
>> 
>> Oliver.
>> 
>> Am 16.02.2012 um 19:02 schrieb Sage Weil:
>> 
>>> On Thu, 16 Feb 2012, Oliver Francke wrote:
>>>> Hi Sage,
>>>> 
>>>> thnx for the quick response,
>>>> 
>>>> Am 16.02.2012 um 18:17 schrieb Sage Weil:
>>>> 
>>>>> On Thu, 16 Feb 2012, Oliver Francke wrote:
>>>>>> Hi Sage, *,
>>>>>> 
>>>>>> your tip with truncating from below did not solve the problem. Just to recap:
>>>>>> 
>>>>>> we had two inconsistencies, which we could break down to something like:
>>>>>> 
>>>>>> rb.0.0.000000000000__head_DA680EE2
>>>>>> 
>>>>>> according to the ceph dump from below. Walking to the node with the OSD mounted on /data/osd3
>>>>>> for example, and a stupid "find ?" brings up a couple of them, so the pg number is relevant too -
>>>>>> makes sense - we went into lets say "/data/osd3/current/84.2_head/" and did a hex dump from the file, looked really
>>>>>> like the "head", in means of signs from an installed grub-loader. But a corrupted partition-table.
>>>>>> From other of these files one could do a "fdisk -l <file>" and at least a partition-table could have been
>>>>>> found.
>>>>>> Two days later we got a customers big complaint about not being able to boot his VM anymore. The point now is,
>>>>>> from such a file with name and pg, how can we identify the real file being associated with, cause there is another
>>>>>> customer with a potential problem with next reboot ( second inconsistency).
>>>>>> 
>>>>>> We also had some VM's in a big test-phase with similar problems? grub going into rescue-prompt, invalid/corrupted
>>>>>> partition tables, so all in the first "head-file"?
>>>>>> Would be cool to get some more infos? and sched some light into the structures ( myself not really being a good code-reader
>>>>>> anymore ;) ).
>>>>> 
>>>>> 'head' in this case means the object hasn't been COWed (snapshotted and 
>>>>> then overwritten), and 000000000000 means its the first 4MB block of the 
>>>>> rbd image/disk.
>>>>> 
>>>> 
>>>> yes, true,
>>>> 
>>>>> We you able to use the 'rbd info' in the previous email to identify which 
>>>>> image it is?  Is that what you mean by 'identify the real file'?
>>>>> 
>>>> 
>>>> that's the point, from the object I would like to identify the complete image location ala:
>>>> 
>>>> <pool>/<image>
>>>> 
>>>> from there I'd know, which customer's rbd disk-image is affected.
>>> 
>>> For pool, look at the pgid, in this case '109.6'.  109 is the pool id.  
>>> Look at the pool list from 'ceph osd dump' output to see which pool name 
>>> that is.
>>> 
>>> For the image, rb.0.0 is the image prefix.  Look at each rbd image in that 
>>> pool, and check for the image whose prefix matches.  e.g.,
>>> 
>>> for img in `rbd -p poolname list` ; do rbd info $img -p poolname | grep 
>>> -q rb.0.0 && echo found $img ; done
>>> 
>>> BTW, are you creating a pool per customer here?  You need to be a little 
>>> bit careful about creating large numbers of pools; the system isn't really 
>>> designed to be used that way.  You should use a pool if you have a 
>>> distinct data placement requirement (e.g., put these objects on this set 
>>> of ceph-osds).  But because of the way things work internally creating 
>>> hundreds/thousands of them won't be very efficient.
>>> 
>>> sage
>>> 
>>> 
>>>> 
>>>> Thnx for your patience,
>>>> 
>>>> Oliver.
>>>> 
>>>>> I'm not sure I understand exactly what your question is.  I would have 
>>>>> expected modifying the file with fdisk -l to work (if fdisk sees a valid 
>>>>> partition table, it should be able to write it too).
>>>>> 
>>>>> sage
>>>>> 
>>>>> 
>>>>>> 
>>>>>> Thanks in@vance and kind regards,
>>>>>> 
>>>>>> Oliver.
>>>>>> 
>>>>>> Am 13.02.2012 um 18:13 schrieb Sage Weil:
>>>>>> 
>>>>>>> On Sun, 12 Feb 2012, Jens Rehpoehler wrote:
>>>>>>> 
>>>>>>>>>> Hi Liste,
>>>>>>>>>> 
>>>>>>>>>> today i've got another problem.
>>>>>>>>>> 
>>>>>>>>>> ceph -w shows up with an inconsistent PG over night:
>>>>>>>>>> 
>>>>>>>>>> 2012-02-10 08:38:48.701775    pg v441251: 1982 pgs: 1981 active+clean, 1
>>>>>>>>>> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>>>>>>>>> GB avail
>>>>>>>>>> 2012-02-10 08:38:49.702789    pg v441252: 1982 pgs: 1981 active+clean, 1
>>>>>>>>>> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>>>>>>>>> GB avail
>>>>>>>>>> 
>>>>>>>>>> I've identified it with "ceph pg dump - | grep inconsistent
>>>>>>>>>> ...
>>>>>>>>>> 
>>>>>>>>>> Now I've tried to repair it with: ceph pg repair 109.6
>>>>>>>>>> 
>>>>>>>>>> 2012-02-10 08:35:52.276325 mon<- [pg,repair,109.6]
>>>>>>>>>> 2012-02-10 08:35:52.276776 mon.1 ->  'instructing pg 109.6 on osd.3 to
>>>>>>>>>> repair' (0)
>>>>>>>>>> 
>>>>>>>>>> but i only get the following result:
>>>>>>>>>> 
>>>>>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455420 osd.3
>>>>>>>>>> 10.10.10.8:6801/25980 6913 : [ERR] 109.6 osd.4: soid
>>>>>>>>>> 1ef398ce/rb.0.0.0000000000bd/headsize 2736128 != known size 3145728
>>>>>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455426 osd.3
>>>>>>>>>> 10.10.10.8:6801/25980 6914 : [ERR] 109.6 scrub 0 missing, 1 inconsistent
>>>>>>>>>> objects
>>>>>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455799 osd.3
>>>>>>>>>> 10.10.10.8:6801/25980 6915 : [ERR] 109.6 scrub 1 errors
>>>>>>>>>> 
>>>>>>>>>> Can someone please explain me what to do in this case and how to recover
>>>>>>>>>> the pg ?
>>>>>>>>> 
>>>>>>>>> So the "fix" is just to truncate the file to the expected size, 3145728,
>>>>>>>>> by finding it in the current/ directory.  The name/path will be slightly
>>>>>>>>> weird; look for 'rb.0.0.0000000000bd'.
>>>>>>>>> 
>>>>>>>>> The data is still suspect, though.  Did the ceph-osd restart or crash
>>>>>>>>> recently?  I would do that, repair (it should succeed), and then fsck the
>>>>>>>>> file system in that rbd image.
>>>>>>>>> 
>>>>>>>>> We just fixed a bug that was causing transactions to leak across
>>>>>>>>> checkpoint/snapshot boundaries.  That could be responsible for causing all
>>>>>>>>> sorts of subtle corruptions, including this one.  It'll be included in
>>>>>>>>> v0.42 (out next week).
>>>>>>>>> 
>>>>>>>>> sage
>>>>>>>> 
>>>>>>>> Hi Sarge,
>>>>>>>> 
>>>>>>>> no ... the osd didn't crash. I had to do some hardware maintainance and push
>>>>>>>> it
>>>>>>>> out of distribution with "ceph osd out 3". After a short while i used
>>>>>>>> "/etc/init.d/ceph stop" on that osd.
>>>>>>>> Then, after my work i've started ceph and push it in the distribution with
>>>>>>>> "ceph osd in 3".
>>>>>>> 
>>>>>>> For the bug I'm worried about, stopping the daemon and crashing are 
>>>>>>> equivalent.  In both cases, a transaction may have been only partially 
>>>>>>> included in the checkpoint.
>>>>>>> 
>>>>>>>> Could you please tell me if this is the right way to get an osd out for
>>>>>>>> maintainance ? Is there
>>>>>>>> any other thing i should do to keep data consistent ?
>>>>>>> 
>>>>>>> You followed the right procedure.  There is (hopefully, was!) just a bug.
>>>>>>> 
>>>>>>> sage
>>>>>>> 
>>>>>>> 
>>>>>>>> My structure is ->  3 MDS/MON Server on seperate Hardware Nodes an 3 OSD Nodes
>>>>>>>> with a each a total capacity
>>>>>>>> of 8 TB. Journaling is done on a separate SSD per node. The whole thing is a
>>>>>>>> data store for a kvm virtualisation
>>>>>>>> farm. The farm is accessing the data directly per rbd.
>>>>>>>> 
>>>>>>>> Thank you
>>>>>>>> 
>>>>>>>> Jens
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>> 
>>>>>>>> 
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> 
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> 
>>>>>> 
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> 
>>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

