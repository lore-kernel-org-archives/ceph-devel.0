From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 20:18:24 +0300
Message-ID: <56FD5BE0.4040801@mirantis.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <56FD4FEC.4060000@mirantis.com>
 <CY1PR0201MB1897E7C6A58679883F375F60E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35566 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcCaRS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 13:18:26 -0400
Received: by mail-lf0-f43.google.com with SMTP id k79so64254921lfb.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 10:18:26 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1897E7C6A58679883F375F60E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 31.03.2016 19:32, Allen Samuels wrote:
>> But do we really need to store checksums as metadata? What's about 
>> pre(post)fixing 4K-4(?) blob with the checksum and store this pair to 
>> the disk. IMO we always need checksum values along with blob data 
>> thus let's store and read them together. This immediately eliminates 
>> the question about the granularity and corresponding overhead... Have 
>> I missed something? 
> If you store them inline with the data then nothing lines up on boundaries that the HW designers expect and you end up doing things like extra-copying of every data buffer. This will kill performance.

Perhaps you are right.

But not sure I fully understand what HW designers you mean here. Are you 
considering the case when Ceph is embedded into some hardware and 
incoming RW requests  always operate aligned data and supposed to have 
the same alignment for data saved to disk?

IMHO proper data alignment in the incoming requests is a particular 
case. Generally we don't have such a trait. Moreover compression 
completely destroys it if any. Thus in many cases we can easily append 
an additional data portion containing a checksum.

>
> If you store them in a separate place (not in metadata, not contiguous to data) then you'll have a full extra I/O that might even move the head (yikes!). Plus you'll have to deal with the RMW of these tiny things.
Agree - that's not an option.
> Putting them in the metadata is really the only viable option.

