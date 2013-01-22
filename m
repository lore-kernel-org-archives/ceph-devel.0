From: Dan Mick <dan.mick@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 13:11:30 -0800
Message-ID: <50FF0082.6020400@inktank.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com> <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com> <50FEFE26.2000003@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47683 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3AVVLe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:11:34 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so4277366pad.13
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:11:34 -0800 (PST)
In-Reply-To: <50FEFE26.2000003@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: Neil Levine <neil.levine@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

The '-a/--allhosts' parameter is to spread the command across the 
cluster...that is, service ceph -a start will start across the cluster.

On 01/22/2013 01:01 PM, Xing Lin wrote:
> I like the current approach. I think it is more convenient to run
> commands once at one host to do all the setup work. When the first time
> I deployed a ceph cluster with 4 hosts, I thought 'service ceph start'
> would start the whole ceph cluster. But as it turns out, it only starts
> local osd, mon processes. So, currently, I am using polysh to run the
> same commands at all hosts (mostly, to restart ceph service before every
> measurement.). Thanks.
>
> Xing
>
> On 01/22/2013 12:35 PM, Neil Levine wrote:
>> Out of interest, would people prefer that the Ceph deployment script
>> didn't try to handle server-server file copy and just did the local
>> setup only, or is it useful that it tries to be a mini-config
>> management tool at the same time?
>>
>> Neil
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
