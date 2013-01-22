From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 14:01:26 -0700
Message-ID: <50FEFE26.2000003@cs.utah.edu>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com> <50FEDE7A.5070307@cs.utah.edu> <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:43748 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab3AVVB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:01:27 -0500
In-Reply-To: <CANygib-XkRn43PSk=ivOp8RVqqxGVGpDcfbbMYEOo-mNYFARsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

I like the current approach. I think it is more convenient to run 
commands once at one host to do all the setup work. When the first time 
I deployed a ceph cluster with 4 hosts, I thought 'service ceph start' 
would start the whole ceph cluster. But as it turns out, it only starts 
local osd, mon processes. So, currently, I am using polysh to run the 
same commands at all hosts (mostly, to restart ceph service before every 
measurement.). Thanks.

Xing

On 01/22/2013 12:35 PM, Neil Levine wrote:
> Out of interest, would people prefer that the Ceph deployment script
> didn't try to handle server-server file copy and just did the local
> setup only, or is it useful that it tries to be a mini-config
> management tool at the same time?
>
> Neil

