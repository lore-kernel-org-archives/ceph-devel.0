From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not starting a OSD journal
Date: Sun, 29 Jan 2017 23:55:38 +0100
Message-ID: <2a091289-191a-5c3c-ea13-25f3cf36cebb@digiware.nl>
References: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
 <351131ca-d626-3bba-833b-c3281a5b25e1@suse.cz>
 <611a59a0-3511-079b-e2a3-691342234510@digiware.nl>
 <d250debe-dad0-042c-c9dc-988df7218a0e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:46602 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdA2Wzu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 29 Jan 2017 17:55:50 -0500
In-Reply-To: <d250debe-dad0-042c-c9dc-988df7218a0e@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On 29-1-2017 23:45, Nathan Cutler wrote:
> Hi Willem:
> 
> Sounds like you want to put your journals in a partition, not a file.
> Since the Ceph journal uses the journal partition directly (without any
> underlying filesystem), you will not have ZFS to worry about there.

Hi Nathan,

That is one approach. ;)
Sorry for being so persistent.

I was looking for ways to use ZFS properties to the advantage of the system.
And removing a complete write/read cycle (even if is is on ssd) would be
an interesting option.

This assumes that ZFS with ZIL is rather reliable. (i'd dare to say
very) It has not let me down in the 10 years I'm running it now.

--WjW

> Nathan
> 
> On 01/29/2017 09:09 PM, Willem Jan Withagen wrote:
>> On 29-1-2017 17:21, Nathan Cutler wrote:
>>>> I'm rummaging thru the options, but I do not really see an option to
>>>> fully disable journaling?
>>>>
>>>> One of the reasons for testing that is that ZFS already has very good
>>>> journaling functionality. So I'd like to see what kind of performance
>>>> difference that makes.
>>>>
>>>> Or is this like setting journal-size to 0 or the path to /dev/null?
>>>
>>> All writes go through the journal, so it is required. However, the
>>> journal can be in a file within the OSD data partition. To deploy an OSD
>>> in this configuration, it should be sufficient to *not* supply the
>>> JOURNAL positional parameter to "ceph-disk prepare" [1].
>>>
>>> By doing this, you of course lose the option of putting the journal on a
>>> separate (SSD) disk. If your data partition is on an HDD, journal-on-SSD
>>> is going to give superior performance.
>>>
>>> [1] See "ceph-disk prepare --help" for a description of these arguments.
>>
>> 'mmm,
>>
>> too bad..
>>
>> Now the not so bad part is again that the journal is probablu oke in a
>> file on ZFS if that ZFS-pool is backed with a ZIL (the zfs journal) and
>> L2ARC (the ZFS cache).
>>
>> The disadvantage is that there will be a double write per original write:
>>  (ceph) first write is to the journal-file
>>     (zfs) write is stored in the write queue
>>     (zfs) write to ZIL(ssd) if write is synced write
>>     (zfs) async write to disk when write slot is available
>>  (ceph) read from zfs-store,
>>     (zfs) delivers data either arc(ram) or l2arc(ssd) or HD
>>  (ceph) writes data to filestore.
>>     (zfs) write is stored in the write queue
>>     (zfs) write to ZIL(ssd) if write is synced write
>>     (zfs) async write to disk when write slot is available
>>
>> And I hoped to forgo the Ceph journal write/read cycle.
>>
>> The other way to do this is to not use a ZIL in ZFS and depend on the
>> journal in Ceph. But then sync writes to ZFS without ZIL is not a real
>> sensible thing to do...
>> But then it will burn double SSD space and double write cycles.
>>
>> Another division would be to create a separate ZFS pool that has both
>> ZIL and L2ARC which is only used for the journals...
>> But then it is the question if the actual writes to the store are also
>> done synchronous? Because then that would also again require a ZIL.
>>
>> Now it would not be so bad because all ZILs are like 1Gb in size.
>> But in the end it will impact in the available bandwidth of the SSDs.
>>
>> --WjW
>>
>>     
>>

