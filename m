From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD storage pool support in libvirt
Date: Mon, 16 Apr 2012 21:01:19 +0200
Message-ID: <4F8C6C7F.5030001@widodh.nl>
References: <4F04A8C1.1090205@widodh.nl> <4F04EFA1.5050704@dreamhost.com> <4F05B8F0.10003@widodh.nl> <4F50E7A6.10100@widodh.nl> <4F8C6B91.6060809@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:39020 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2DPTBT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 15:01:19 -0400
Received: from [IPv6:2a00:f10:11c:ab:52e5:49ff:fec2:c976] (unknown [IPv6:2a00:f10:11c:ab:52e5:49ff:fec2:c976])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 3AC304047A
	for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 21:01:18 +0200 (CEST)
In-Reply-To: <4F8C6B91.6060809@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

On 04/16/2012 08:57 PM, Wido den Hollander wrote:
> Hi,
>
> About two weeks ago I submitted my patch to the libvirt mailinglist:
> https://www.redhat.com/archives/libvir-list/2012-March/msg01320.html
>
> I've placed the code on github: https://github.com/wido/libvirt
>
> This storage drivers lets you managed RBD images through libvirt which
> could make it easier to manage your RBD storage pools.
>
> I'm also working on CloudStack integration for RBD (Can also be found on
> Github), that required RBD support in libvirt since CS relies on libvirt
> for managing it's storage pools.
>
> Since the patch hasn't been accepted in libvirt yet I'll keep rebasing
> the code against the master branch regularly.
>
> Josh from the Ceph team helped me to improve the code, thanks for that!
>
> I encourage everybody to test it and play around with it, since there
> probably will be some corner cases I haven't found.
>
> Example XML's can be found in "tests/storagepoolxml2xmlin"

What I forgot to add:

The "virsh vol-download|vol-upload" commands won't work, this is due 
some internal workings of libvirt: 
https://www.redhat.com/archives/libvir-list/2012-February/msg00503.html

Wido

>
> Wido
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
