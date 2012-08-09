From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph RBD performance - random writes
Date: Thu, 09 Aug 2012 06:42:36 -0500
Message-ID: <5023A22C.10100@inktank.com>
References: <5021F6D1.7000004@catalyst.net.nz> <5022B3F4.5050109@inktank.com> <5022E121.4070004@inktank.com> <5022F7EF.2020007@catalyst.net.nz> <50230797.8040008@catalyst.net.nz> <5023347B.6060806@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54891 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2HILmq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 07:42:46 -0400
Received: by ggdk6 with SMTP id k6so293393ggd.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 04:42:46 -0700 (PDT)
In-Reply-To: <5023347B.6060806@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 8/8/12 10:54 PM, Mark Kirkwood wrote:
> On 09/08/12 12:43, Mark Kirkwood wrote:
>>
>>>
>>
>>
>> I tried out a raft of xfs config changes and also made the Ceph
>> journal really big (10G):
>>
>> $ mkfs.xfs -f -l internal,size=1024m -d agcount=4 /dev/sd[b,c]2
>>
>> + mount options with nobarrier,logbufs=8
>>
>> The results improved a little, but still very slow for small request
>> sizes...
>
> Some more careful analysis showed that all the benefit derived from the
> ceph storage reinit after the filesystem was remade, so going back
> gradually to the default filesystem options (mkfs.xfs, default mount
> with noatime, discard) and 2G journal results in the same numbers as I
> posted with the tweaked settings.
>
> So sorry, appears to be nothing gained (on this system anyway) from said
> tweaking.
>
> Regards
>
> Mark

Hi Mark,

Would you mind installing and running collectl during your test?  I 
think it's in the apt repositories now in 12.04.

Try "collectl -sD -oT --dskfilt sd<N>,sd<M>" where the dskfilt options 
are the devices for your OSD(s).  I'd like to see what the device wait 
and svc times are like on your setup in both cases.

Thanks,
Mark
