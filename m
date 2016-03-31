From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 19:27:24 +0300
Message-ID: <56FD4FEC.4060000@mirantis.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33040 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcCaQ11 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 12:27:27 -0400
Received: by mail-lb0-f172.google.com with SMTP id u8so55947045lbk.0
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 09:27:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 31.03.2016 1:15, Sage Weil wrote:
> On Wed, 30 Mar 2016, Allen Samuels wrote:
>> [snip]
>>
>> Time to talk about checksums.
>>
>> First let's divide the world into checksums for data and checksums for
>> metadata -- and defer the discussion about checksums for metadata
>> (important, but one at a time...)
>>
>> I believe it's a requirement that when checksums are enabled that 100%
>> of data reads must be validated against their corresponding checksum.
>> This leads you to conclude that you must store a checksum for each
>> independently readable piece of data.
> I'm just worried about the size of metadata if we have 4k checksums but
> have to read big extents anyway; cheaper to store a 4 byte checksum for
> each compressed blob.

But do we really need to store checksums as metadata?
What's about pre(post)fixing 4K-4(?) blob with the checksum and store 
this pair to the disk.
IMO we always need checksum values along with blob data thus let's store 
and read them together.
This immediately eliminates the question about the granularity and 
corresponding overhead...

Have I missed something?


