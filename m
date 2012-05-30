From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd command : is it possible to pass authkey in argument ?
Date: Wed, 30 May 2012 13:26:24 +0200
Message-ID: <4FC603E0.1080307@widodh.nl>
References: <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:44316 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab2E3L0Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 07:26:25 -0400
In-Reply-To: <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 05/30/2012 11:15 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I'm writing rbd module for proxmox kvm distribution,
>
> Is it possible to pass authkey as argument in rbd command line ? (I can do in with qemu-rbd drive option)

I'm not sure yet, have you tried with they argument "--key" ?

I tried and that failed and looking through the source-code it seems 
that it isn't possible yet.

Adding it seems rather simple however, so it could be added.

Wido

>
> Or does it need to use a keyring file ?
>
> Regards,
>
> Alexandre
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
