From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Missing kernel client install instructions on wiki?
Date: Mon, 04 Jul 2011 10:06:47 +0200
Message-ID: <1309766807.14552.4.camel@wido-desktop>
References: <CAG_bnfzsj6o6DOgfg9fryu7x4nDJ5ajmaER7_=k30ZdiVxrjLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40166 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab1GDIGc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 04:06:32 -0400
In-Reply-To: <CAG_bnfzsj6o6DOgfg9fryu7x4nDJ5ajmaER7_=k30ZdiVxrjLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vineet Jain <vinjvinj@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Sun, 2011-07-03 at 13:33 -0400, Vineet Jain wrote:
> I'm following the steps on the wiki on ubuntu 11.04 (natty).
> 
> I added the package:
> 
> deb http://ceph.newdream.net/debian-snapshot-amd64/master/ natty main
> 
> and was able to install the ceph module but I'm stuck on how to
> install the kernel client module. The wiki says that the kernel module
> install instructions are outdated and should not be used. I tried them
> and they failed. Can someone point me to the steps I need to do
> install the latest ceph kernel client.

Since you are running Ubuntu I'd take the easy way and grab a kernel
from Ubuntu with Ceph in it:
http://kernel.ubuntu.com/~kernel-ppa/mainline/v2.6.39.2-oneiric/

That will give you 2.6.39.2, that has recent enough code to run the
kernel client.

Wido

> 
> Also, I have several servers in my cluster. Is it ok to have the ceph
> kernel client and ceph store nodes running on the same machine. Since
> I have 4 cores on each box?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


