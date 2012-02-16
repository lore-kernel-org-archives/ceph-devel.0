From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Problem with inconsistent PG
Date: Thu, 16 Feb 2012 18:53:00 +0100
Message-ID: <17FB8C39-0D70-4019-8674-D0BB33664FE8@filoo.de>
References: <4F37A9F5.6030908@filoo.de> <Pine.LNX.4.64.1202130910330.13736@cobra.newdream.net> <44CF33BD-97D2-4532-BA7E-2304CA73F09F@filoo.de> <Pine.LNX.4.64.1202160911300.7873@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:51448 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab2BPRxC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 12:53:02 -0500
In-Reply-To: <Pine.LNX.4.64.1202160911300.7873@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jens Rehpoehler <jens.rehpoehler@filoo.de>, ceph-devel@vger.kernel.org

Hi Sage,

thnx for the quick response,

Am 16.02.2012 um 18:17 schrieb Sage Weil:

> On Thu, 16 Feb 2012, Oliver Francke wrote:
>> Hi Sage, *,
>> 
>> your tip with truncating from below did not solve the problem. Just to recap:
>> 
>> we had two inconsistencies, which we could break down to something like:
>> 
>> rb.0.0.000000000000__head_DA680EE2
>> 
>> according to the ceph dump from below. Walking to the node with the OSD mounted on /data/osd3
>> for example, and a stupid "find ?" brings up a couple of them, so the pg number is relevant too -
>> makes sense - we went into lets say "/data/osd3/current/84.2_head/" and did a hex dump from the file, looked really
>> like the "head", in means of signs from an installed grub-loader. But a corrupted partition-table.
>> From other of these files one could do a "fdisk -l <file>" and at least a partition-table could have been
>> found.
>> Two days later we got a customers big complaint about not being able to boot his VM anymore. The point now is,
>> from such a file with name and pg, how can we identify the real file being associated with, cause there is another
>> customer with a potential problem with next reboot ( second inconsistency).
>> 
>> We also had some VM's in a big test-phase with similar problems? grub going into rescue-prompt, invalid/corrupted
>> partition tables, so all in the first "head-file"?
>> Would be cool to get some more infos? and sched some light into the structures ( myself not really being a good code-reader
>> anymore ;) ).
> 
> 'head' in this case means the object hasn't been COWed (snapshotted and 
> then overwritten), and 000000000000 means its the first 4MB block of the 
> rbd image/disk.
> 

yes, true,

> We you able to use the 'rbd info' in the previous email to identify which 
> image it is?  Is that what you mean by 'identify the real file'?
> 

that's the point, from the object I would like to identify the complete image location ala:

<pool>/<image>

from there I'd know, which customer's rbd disk-image is affected.

Thnx for your patience,

Oliver.

> I'm not sure I understand exactly what your question is.  I would have 
> expected modifying the file with fdisk -l to work (if fdisk sees a valid 
> partition table, it should be able to write it too).
> 
> sage
> 
> 
>> 
>> Thanks in@vance and kind regards,
>> 
>> Oliver.
>> 
>> Am 13.02.2012 um 18:13 schrieb Sage Weil:
>> 
>>> On Sun, 12 Feb 2012, Jens Rehpoehler wrote:
>>> 
>>>>>> Hi Liste,
>>>>>> 
>>>>>> today i've got another problem.
>>>>>> 
>>>>>> ceph -w shows up with an inconsistent PG over night:
>>>>>> 
>>>>>> 2012-02-10 08:38:48.701775    pg v441251: 1982 pgs: 1981 active+clean, 1
>>>>>> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>>>>> GB avail
>>>>>> 2012-02-10 08:38:49.702789    pg v441252: 1982 pgs: 1981 active+clean, 1
>>>>>> active+clean+inconsistent; 1790 GB data, 3368 GB used, 18977 GB / 22345
>>>>>> GB avail
>>>>>> 
>>>>>> I've identified it with "ceph pg dump - | grep inconsistent
>>>>>> 
>>>>>> 109.6    141    0    0    0    463820288    111780    111780
>>>>>> active+clean+inconsistent    485'7115    480'7301    [3
>>>>>> <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#3>,4
>>>>>> <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#4>]    [3
>>>>>> <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#3>,4
>>>>>> <http://marc.info/?l=ceph-devel&m=132891306919981&w=2#4>]
>>>>>> 485'7061    2012-02-10 08:02:12.043986
>>>>>> 
>>>>>> Now I've tried to repair it with: ceph pg repair 109.6
>>>>>> 
>>>>>> 2012-02-10 08:35:52.276325 mon<- [pg,repair,109.6]
>>>>>> 2012-02-10 08:35:52.276776 mon.1 ->  'instructing pg 109.6 on osd.3 to
>>>>>> repair' (0)
>>>>>> 
>>>>>> but i only get the following result:
>>>>>> 
>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455420 osd.3
>>>>>> 10.10.10.8:6801/25980 6913 : [ERR] 109.6 osd.4: soid
>>>>>> 1ef398ce/rb.0.0.0000000000bd/headsize 2736128 != known size 3145728
>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455426 osd.3
>>>>>> 10.10.10.8:6801/25980 6914 : [ERR] 109.6 scrub 0 missing, 1 inconsistent
>>>>>> objects
>>>>>> 2012-02-10 08:36:18.447553   log 2012-02-10 08:36:08.455799 osd.3
>>>>>> 10.10.10.8:6801/25980 6915 : [ERR] 109.6 scrub 1 errors
>>>>>> 
>>>>>> Can someone please explain me what to do in this case and how to recover
>>>>>> the pg ?
>>>>> 
>>>>> So the "fix" is just to truncate the file to the expected size, 3145728,
>>>>> by finding it in the current/ directory.  The name/path will be slightly
>>>>> weird; look for 'rb.0.0.0000000000bd'.
>>>>> 
>>>>> The data is still suspect, though.  Did the ceph-osd restart or crash
>>>>> recently?  I would do that, repair (it should succeed), and then fsck the
>>>>> file system in that rbd image.
>>>>> 
>>>>> We just fixed a bug that was causing transactions to leak across
>>>>> checkpoint/snapshot boundaries.  That could be responsible for causing all
>>>>> sorts of subtle corruptions, including this one.  It'll be included in
>>>>> v0.42 (out next week).
>>>>> 
>>>>> sage
>>>> 
>>>> Hi Sarge,
>>>> 
>>>> no ... the osd didn't crash. I had to do some hardware maintainance and push
>>>> it
>>>> out of distribution with "ceph osd out 3". After a short while i used
>>>> "/etc/init.d/ceph stop" on that osd.
>>>> Then, after my work i've started ceph and push it in the distribution with
>>>> "ceph osd in 3".
>>> 
>>> For the bug I'm worried about, stopping the daemon and crashing are 
>>> equivalent.  In both cases, a transaction may have been only partially 
>>> included in the checkpoint.
>>> 
>>>> Could you please tell me if this is the right way to get an osd out for
>>>> maintainance ? Is there
>>>> any other thing i should do to keep data consistent ?
>>> 
>>> You followed the right procedure.  There is (hopefully, was!) just a bug.
>>> 
>>> sage
>>> 
>>> 
>>>> My structure is ->  3 MDS/MON Server on seperate Hardware Nodes an 3 OSD Nodes
>>>> with a each a total capacity
>>>> of 8 TB. Journaling is done on a separate SSD per node. The whole thing is a
>>>> data store for a kvm virtualisation
>>>> farm. The farm is accessing the data directly per rbd.
>>>> 
>>>> Thank you
>>>> 
>>>> Jens
>>>> 
>>>> 
>>>> 
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

