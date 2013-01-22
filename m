From: Gregory Farnum <greg@inktank.com>
Subject: Re: ssh passwords
Date: Tue, 22 Jan 2013 10:45:45 -0800
Message-ID: <87FF75E30B3F4DCABD5DCE389CCE5A0A@inktank.com>
References: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64244 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3AVSpv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 13:45:51 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so4125376pbc.22
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 10:45:50 -0800 (PST)
In-Reply-To: <CAJH6TXgFSLBAypG-wgJQ3=AjDk80ZhU1Yd94SBVyxSo4s3BW6A@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, January 22, 2013 at 10:24 AM, Gandalf Corvotempesta wrote:
> Hi all,
> i'm trying my very first ceph installation following the 5-minutes quickstart:
> http://ceph.com/docs/master/start/quick-start/#install-debian-ubuntu
> 
> just a question: why ceph is asking me for SSH password? Is ceph
> trying to connect to itself via SSH?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html

If you're using mkcephfs to set it up, or asking etc/init.d/ceph to start up daemons on each node, it uses ssh to go in and do that. I believe the Quick-start guide is using both of those. :) 
-Greg

