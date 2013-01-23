From: Wido den Hollander <wido@widodh.nl>
Subject: Re: MDS placement
Date: Wed, 23 Jan 2013 09:07:59 +0100
Message-ID: <50FF9A5F.4090801@widodh.nl>
References: <CAJH6TXhux_1-LMDrnUVZWFm2eUCkypwrh6_3czauCANE+RaC2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41048 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab3AWIH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 03:07:58 -0500
In-Reply-To: <CAJH6TXhux_1-LMDrnUVZWFm2eUCkypwrh6_3czauCANE+RaC2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/22/2013 10:19 PM, Gandalf Corvotempesta wrote:
> Where should MDS server be placed, in the cluster network or in the
> public network with MONs ?

It should be located in the public network since clients need to be able 
to interact with it.

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

