From: Gregory Farnum <greg@inktank.com>
Subject: Re: Grid data placement
Date: Tue, 15 Jan 2013 10:36:06 -0800
Message-ID: <CAPYLRzgP8iKxD69+D_S7TtWUsre=y5JF51yWJDoMFHSUufJNQg@mail.gmail.com>
References: <50F59431.3000401@bmrb.wisc.edu>
	<CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com>
	<50F5A116.4090607@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:60066 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab3AOSgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 13:36:07 -0500
Received: by mail-qa0-f52.google.com with SMTP id d13so472812qak.4
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 10:36:06 -0800 (PST)
In-Reply-To: <50F5A116.4090607@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 15, 2013 at 10:33 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
> On 01/15/2013 12:16 PM, Gregory Farnum wrote:
>
>> There's a "read from replicas" operation flag that allows reading data
>> off the local node, although I don't think there's a way to turn it on
>> in the standard filesystem clients right now. It wouldn't be hard for
>> somebody to add. I'm not sure you actually need it though; Ceph unlike
>> NFS distributes the data over all the OSDs in the cluster so you could
>> scale the number of suppliers as you scale the number of consumers.
>> You would definitely not need to run an MDS on each node; just one
>> should be fine.
>
> At the start of the batch #cores-in-the-cluster processes try to mmap
> the same 2GB and start reading it from SEEK_SET at the same time. I
> won't know until I try but I suspect it won't like that.

Well, it'll be #servers-in-cluster serving up 4MB chunks out of cache.
It's possible you could overwhelm their networking but my bet is
they'll just get spread out slightly on the first block and then not
contend in the future.

>> Rather more importantly however, Inktank still doesn't consider the
>> CephFS filesystem to be production-ready, so you will want to tread
>> with care in checking it out.
>
> I'm assuming Inktank will consider it production-ready at some point;
> wouldn't it be great if I had a tested working setup by then. ;-)

Just as long as you're thinking of it as a test system that would make
us very happy. :)
-Greg
