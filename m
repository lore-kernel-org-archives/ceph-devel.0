From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 14:16:09 -0700
Message-ID: <50FF0199.9030504@cs.utah.edu>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com> <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com> <50FEFE26.2000003@cs.utah.edu> <50FF0082.6020400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:44188 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3AVVQK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:16:10 -0500
In-Reply-To: <50FF0082.6020400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

I did not notice that there exists such a parameter. Thanks, Dan!

Xing

On 01/22/2013 02:11 PM, Dan Mick wrote:
> The '-a/--allhosts' parameter is to spread the command across the 
> cluster...that is, service ceph -a start will start across the cluster.
>

