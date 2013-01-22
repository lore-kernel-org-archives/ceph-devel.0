From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 11:46:18 -0700
Message-ID: <50FEDE7A.5070307@cs.utah.edu>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:38686 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3AVSqT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 13:46:19 -0500
In-Reply-To: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

If it is the command 'mkcephfs' that asked you for ssh password, then 
that is probably because that script needs to push some files 
(ceph.conf, e.g) to other hosts. If we open that script, we can see that 
it uses 'scp' to send some files. If I remember correctly, for every osd 
at other hosts, it will ask us ssh password seven times. So, we'd better 
set up public key first. :)

Xing

On 01/22/2013 11:24 AM, Gandalf Corvotempesta wrote:
> Hi all,
> i'm trying my very first ceph installation following the 5-minutes quickstart:
> http://ceph.com/docs/master/start/quick-start/#install-debian-ubuntu
>
> just a question: why ceph is asking me  for SSH password? Is ceph
> trying to connect to itself via SSH?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

