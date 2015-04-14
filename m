From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: how to test hammer rbd objectmap feature ?
Date: Tue, 14 Apr 2015 16:12:38 -0700
Message-ID: <552D9EE6.2080003@redhat.com>
References: <2146461277.257952132.1428997703232.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbbDNXMm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Apr 2015 19:12:42 -0400
In-Reply-To: <2146461277.257952132.1428997703232.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/14/2015 12:48 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I would like to known how to enable object map on hammer ?
>
> I found a post hammer commit here:
>
> https://github.com/ceph/ceph/commit/3a7b28d9a2de365d515ea1380ee9e4f867504e10
> "rbd: add feature enable/disable support"
>
> -   Specifies which RBD format 2 features are to be enabled when creating
> -   an image. The numbers from the desired features below should be added
> -   to compute the parameter value:
> +   Specifies which RBD format 2 feature should be enabled when creating
> +   an image. Multiple features can be enabled by repeating this option
> +   multiple times. The following features are supported:
>
> -.. option:: --image-features features
> +.. option:: --image-feature feature
>
> -   +1: layering support
> -   +2: striping v2 support
> -   +4: exclusive locking support
> -   +8: object map support
> +   layering: layering support
> +   striping: striping v2 support
> +   exclusive-lock: exclusive locking support
> +   object-map: object map support (requires exclusive-lock)
>
>
> So, in current hammer release, we can only setup objectmap and other features on rbd volume creation ?

Yes, that's right.

> Do this patch allow to change features on the fly ?

Yup, just for exclusive-lock and object map (since they don't
affect object layout).

> If yes, is it planned to backport it to hammer soon ?

Yeah, once we're confident in it in master. The idea behind this
feature was to allow using object maps with existing images. There
just wasn't time to include it in the base hammer release.

Josh
