From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph RBD performance - random writes
Date: Fri, 10 Aug 2012 11:31:47 +1200
Message-ID: <50244863.3030907@catalyst.net.nz>
References: <5021F6D1.7000004@catalyst.net.nz> <5022B3F4.5050109@inktank.com> <5022E121.4070004@inktank.com> <5022F7EF.2020007@catalyst.net.nz> <50230797.8040008@catalyst.net.nz> <5023347B.6060806@catalyst.net.nz> <5023A22C.10100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:46429 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab2HIXbu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 19:31:50 -0400
In-Reply-To: <5023A22C.10100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 09/08/12 23:42, Mark Nelson wrote:
> On 8/8/12 10:54 PM, Mark Kirkwood wrote:
>> On 09/08/12 12:43, Mark Kirkwood wrote:
>>>
>>>>
>>>
>>>
>>> I tried out a raft of xfs config changes and also made the Ceph
>>> journal really big (10G):
>>>
>>> $ mkfs.xfs -f -l internal,size=1024m -d agcount=4 /dev/sd[b,c]2
>>>
>>> + mount options with nobarrier,logbufs=8
>>>
>>> The results improved a little, but still very slow for small request
>>> sizes...
>>
>> Some more careful analysis showed that all the benefit derived from the
>> ceph storage reinit after the filesystem was remade, so going back
>> gradually to the default filesystem options (mkfs.xfs, default mount
>> with noatime, discard) and 2G journal results in the same numbers as I
>> posted with the tweaked settings.
>>
>> So sorry, appears to be nothing gained (on this system anyway) from said
>> tweaking.
>>
>> Regards
>>
>> Mark
>
> Hi Mark,
>
> Would you mind installing and running collectl during your test? I 
> think it's in the apt repositories now in 12.04.
>
> Try "collectl -sD -oT --dskfilt sd<N>,sd<M>" where the dskfilt options 
> are the devices for your OSD(s).  I'd like to see what the device wait 
> and svc times are like on your setup in both cases.


Ok, yeah it is in the 12.04 repo - will do.

There could well be an additional factor connected with xfs and lots of 
files on these Intel 520s - I have just had a conversation with a 
workmate who switched xfs to ext4 due to this. I will see if ext4 or 
btrfs (scary) do any better on these drives...

Cheers

Mark
