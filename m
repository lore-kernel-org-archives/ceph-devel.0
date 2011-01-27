From: Wido den Hollander <wido@widodh.nl>
Subject: Re: QEMU RBD failed!
Date: Thu, 27 Jan 2011 16:23:06 +0100
Message-ID: <1296141786.2281.8.camel@wido-desktop>
References: <FB06A065-2077-41B8-9C55-74C5234DDFAC@cs.ucsc.edu>
	 <AANLkTikq8reF0zk_47LW1Q6nM3pPfv+JG-Hk7P_fi4+K@mail.gmail.com>
	 <1296121736.25746.90.camel@node1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56611 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1A0PXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jan 2011 10:23:08 -0500
In-Reply-To: <1296121736.25746.90.camel@node1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wchen <wchen@tnsoft.com.cn>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Kevin,

On Thu, 2011-01-27 at 17:48 +0800, wchen wrote:
> Hi Farnum,
> 
> I follow the instructions on wiki to create a qemu image using qemu rbd,
> but failed.
> 
> According to wiki, after compiled qemu and input the following command:
> $ qemu-img create -f rbd rbd:data/foo 10G
> 
> But system tell me that "unknown format 'rbd'".

Seems you are missing RBD support in Qemu.

> which step did I miss? how to register a 'rbd' format?
> BTW, I run these commands on ceph cluster.

Did you compile Qemu-RBD with --enable-rbd ?

And are you sure you are running the correct binary and that there is no
old Qemu installation on your system.

Wido

