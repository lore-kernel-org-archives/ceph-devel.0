From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: SSD journal suggestion
Date: Wed, 7 Nov 2012 11:12:05 -0500
Message-ID: <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com>
 <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net>
 <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com>
 <509A77CA.5030206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:62489 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2KGQVt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 11:21:49 -0500
In-Reply-To: <509A77CA.5030206@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Nov 7, 2012, at 10:01 AM, Mark Nelson <mark.nelson@inktank.com> wrote:

> On 11/07/2012 06:28 AM, Gandalf Corvotempesta wrote:
>> 2012/11/7 Sage Weil <sage@inktank.com>:
>>> On Wed, 7 Nov 2012, Gandalf Corvotempesta wrote:
>>>> I'm evaluating some SSD drives as journal.
>>>> Samsung 840 Pro seems to be the fastest in sequential reads and write.
>> 
>> The 840 Pro seems to reach 485MB/s in sequential write:
>> http://www.storagereview.com/samsung_ssd_840_pro_review
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 
> I'm using Intel 510s in a test node and can do about 450MB/s per drive. 

Is that sequential read or write? Intel lists them at 210-315 MB/s for sequential write. The 520s are rated at 475-520 MB/s seq. write.

>  Right now I'm doing 3 journals per SSD, but topping out at about 
> 1.2-1.4GB/s from the client perspective for the node with 15+ drives and 
> 5 SSDs.  It's possible newer versions of the code and tuning may 
> increase that.

What interconnect is this? 10G Ethernet is 1.25 GB/s line rate and I would expect your Sockets and Ceph overhead to eat into that. Or is it dual 10G Ethernet?

Scott

> TV pointed me at the new Intel DC S3700 which looks like a very 
> interesting option (the 100GB model for $240).
> 
> http://www.anandtech.com/show/6432/the-intel-ssd-dc-s3700-intels-3rd-generation-controller-analyzed
> 
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

