From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 10:41:51 -0600
Message-ID: <509A8F4F.7090404@inktank.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com> <509A77CA.5030206@inktank.com> <670668A8-4126-4EF8-B27B-7B00C8824F05@ornl.gov> <509A8A32.9020701@inktank.com> <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:47843 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab2KGQlt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 11:41:49 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so1223708iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 08:41:48 -0800 (PST)
In-Reply-To: <8F1EF04A-96C0-402F-9DE2-3891514BD04F@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2012 10:35 AM, Atchley, Scott wrote:
> On Nov 7, 2012, at 11:20 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
>
>>>>   Right now I'm doing 3 journals per SSD, but topping out at about
>>>> 1.2-1.4GB/s from the client perspective for the node with 15+ drives and
>>>> 5 SSDs.  It's possible newer versions of the code and tuning may
>>>> increase that.
>>>
>>> What interconnect is this? 10G Ethernet is 1.25 GB/s line rate and I would expect your Sockets and Ceph overhead to eat into that. Or is it dual 10G Ethernet?
>>
>> This is 8 concurrent instances of rados bench running on localhost.
>> Ceph is configured with 1x replication.  1.2-1.4GB/s is the aggregate
>> throughput of all of the rados bench instances.
>
> Ok, all local with no communication. Given this level of local performance, what does that translate into when talking over the network?
>
> Scott
>

Well, local, but still over tcp.  Right now I'm focusing on pushing the 
osds/filestores as far as I can, and after that I'm going to setup a 
bonded 10GbE network to see what kind of messenger bottlenecks I run 
into.  Sadly the testing is going slower than I would like.

Mark
