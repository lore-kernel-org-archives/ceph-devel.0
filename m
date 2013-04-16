From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Tue, 16 Apr 2013 13:44:43 -0700
Message-ID: <516DB83B.1010601@inktank.com>
References: <loom.20130412T055215-88@post.gmane.org> <51683184.9010301@inktank.com> <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com> <516C7E55.1050801@inktank.com> <516C8168.40402@inktank.com> <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com> <516D5DB3.4060800@inktank.com> <CAJH6TXiaE-Srrs68JN=mGV2jWh_ofsHVC8zNWaG_BTaaeq0L8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54337 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965275Ab3DPUop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 16:44:45 -0400
Received: by mail-pb0-f49.google.com with SMTP id um15so486021pbc.8
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 13:44:45 -0700 (PDT)
In-Reply-To: <CAJH6TXiaE-Srrs68JN=mGV2jWh_ofsHVC8zNWaG_BTaaeq0L8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The client does a 12MB read, which (because of the striping)
gets broken into 3 separate 4MB reads, each of which is sent,
all in parallel, to 3 distinct OSDs.  The only bottle-neck
in such an operation is the client-NIC.

On 04/16/2013 01:06 PM, Gandalf Corvotempesta wrote:
> 2013/4/16 Mark Kampe <mark.kampe@inktank.com>:
>> RADOS is the underlying storage cluster, but the access methods (block,
>> object, and file) stripe their data across many RADOS objects, which
>> CRUSH very effectively distributes across all of the servers.  A 100MB
>> read or write turns into dozens of parallel operations to servers all
>> over the cluster.
>
> Let me try to explain.
> AFAIK check will split datas into chunks of 4MB each, so, a single
> 12MB file will be stored in 3 different chunks across multiple OSDs
> and then replicated many times (based on value of replica count)
>
> Let's assume a 12MB file and a 3x replica.
> RADOS will create 3x3 chuks for the same file stored on 9 OSDs
>
> When reading AFAIK replicas are not used, so all reads are done to the
> "master copy".
> But these 3 chunks are read in parallel on multiple OSDs or all read
> request are done trough a single OSD? In the first case we will have
> 3x bandwidth for read operations directed to a file with at least 3
> chunks, in the latter we have a big bottleneck.
