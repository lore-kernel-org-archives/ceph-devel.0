From: Wido den Hollander <wido@42on.com>
Subject: Re: Libvirt patch for Ubuntu 14.04 to create image format 2 by default
Date: Tue, 11 Feb 2014 10:43:34 +0100
Message-ID: <52F9F0C6.9010201@42on.com>
References: <52D932A6.90808@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:48955 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbaBKJng (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 04:43:36 -0500
In-Reply-To: <52D932A6.90808@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>

On 01/17/2014 02:39 PM, Wido den Hollander wrote:
> Hi James (CC to devel),
>
> I've been trying to get a patch [0] into libvirt for the last couple of
> months to have libvirt create RBD images format 2 by default.
>
> The response from the RedHat people has been zero until thus far. Since
> this would be great for both OpenStack and CloudStack I'm thinking about
> Ubuntu 14.04.
>

So, I've been trying to poke people at RedHat over and over for the last 
couple of weeks, but no results so far...

I got a response that the patch didn't apply to master anymore, so I 
came up with a new version [0] of the patch, but afterwards there has 
been radio silence again.

I'm working on a couple of extra patches for libvirt, but I want the 
first patch in their asap since that's the most important one.

If there is somebody with contacts inside RedHat who could help, please 
point them to that patch. I would very much appreciate that!

[0]: https://www.redhat.com/archives/libvir-list/2014-January/msg01522.html

> If the patch makes it into Libvirt in let's say 6 weeks it will probably
> not make it into 14.04 since that has been feature frozen.
>
> Is there a way we can get this patch into Libvirt for Ubuntu 14.04? I'm
> confident it will make it into Libvirt upstream, I just need somebody to
> look at it.
>
> [0]:
> https://www.redhat.com/archives/libvir-list/2013-December/msg00645.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
