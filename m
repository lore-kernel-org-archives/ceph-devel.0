From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: librbd: error finding header
Date: Mon, 09 Jul 2012 19:59:07 +0930
Message-ID: <4FFAB273.6030605@bashkirtsev.com>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:35529 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab2GIK3s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 06:29:48 -0400
In-Reply-To: <4FFA9E6D.7030207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/12 18:33, Dan Mick wrote:
> Vladimir: you can do some investigation with the rados command.  What 
> does
> rados -p rbd ls show you?
Rather long list of:
rb.0.11.000000002786
rb.0.d.0000000054a2
rb.0.6.000000002eb5
rb.0.d.000000008294
rb.0.13.000000000377
rb.0.e.000000000629
rb.0.6.000000002756
rb.0.d.000000006156
rb.0.d.000000009b82
rb.0.5.000000000c9e
rb.0.d.0000000080ba
rb.0.f.000000000e75
rb.0.6.00000000ab4f
rb.0.d.0000000048e4
rb.0.d.000000005f67
rb.0.13.0000000014ad
rb.0.d.00000000e074
rb.0.f.000000001a4b
rb.0.13.0000000004a3
...

How to find out to which image these objects belong?

>
> On 07/08/2012 10:42 PM, Vladimir Bashkirtsev wrote:
>> Hello,
>>
>> I just hit this error:
>>
>> error opening image sip.logics.net.au: (2) No such file or directory
>> 2012-07-09 15:03:59.935835 7ffbe0673780 -1 librbd: error finding 
>> header: (2) No such file or directory
>>
>> Googled around and found that Oliver Francke had similar issue back 
>> in March. Read your responses but still unclear where to start to 
>> dig. Just upgraded from 0.47.3 to 0.48, done rolling upgrade and all 
>> RBD images are OK with exception of this one. Notably as upgrade was 
>> done while VM was up it continued to run unaffected (ie all data 
>> inside of VM was written and read as nothing happened). It makes me 
>> think that there no data loss but mere broken header.
>>
>> Of course I have a backup of VM and can pull it back in no time but I 
>> am really interested (and I am sure other ceph users) how to recover 
>> from such failures?
>>
>> Regards,
>> Vladimir
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>


