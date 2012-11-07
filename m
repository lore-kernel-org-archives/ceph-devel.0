From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 10:20:02 -0600
Message-ID: <509A8A32.9020701@inktank.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56160 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab2KGQUE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 11:20:04 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2608106iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 08:20:03 -0800 (PST)
In-Reply-To: <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2012 10:12 AM, Atchley, Scott wrote:
> On Nov 7, 2012, at 10:01 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
>
>> On 11/07/2012 06:28 AM, Gandalf Corvotempesta wrote:
>>> 2012/11/7 Sage Weil <sage@inktank.com>:
>>>> On Wed, 7 Nov 2012, Gandalf Corvotempesta wrote:
>>>>> I'm evaluating some SSD drives as journal.
>>>>> Samsung 840 Pro seems to be the fastest in sequential reads and write.
>>>
>>> The 840 Pro seems to reach 485MB/s in sequential write:
>>> http://www.storagereview.com/samsung_ssd_840_pro_review
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> I'm using Intel 510s in a test node and can do about 450MB/s per drive.
>
> Is that sequential read or write? Intel lists them at 210-315 MB/s for sequential write. The 520s are rated at 475-520 MB/s seq. write.

Doh, wrote that too early in the morning after staying all night 
watching the elections. :)  You are correct, it's the 520, not the 510.

>
>>   Right now I'm doing 3 journals per SSD, but topping out at about
>> 1.2-1.4GB/s from the client perspective for the node with 15+ drives and
>> 5 SSDs.  It's possible newer versions of the code and tuning may
>> increase that.
>
> What interconnect is this? 10G Ethernet is 1.25 GB/s line rate and I would expect your Sockets and Ceph overhead to eat into that. Or is it dual 10G Ethernet?
>
> Scott
>

This is 8 concurrent instances of rados bench running on localhost. 
Ceph is configured with 1x replication.  1.2-1.4GB/s is the aggregate 
throughput of all of the rados bench instances.

>> TV pointed me at the new Intel DC S3700 which looks like a very
>> interesting option (the 100GB model for $240).
>>
>> http://www.anandtech.com/show/6432/the-intel-ssd-dc-s3700-intels-3rd-generation-controller-analyzed
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

