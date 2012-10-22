From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd export to stdout ?
Date: Mon, 22 Oct 2012 13:58:40 +0200
Message-ID: <508534F0.5080107@widodh.nl>
References: <55e4fa31-f365-47ae-a846-d80036981124@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40566 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2JVL6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 07:58:44 -0400
In-Reply-To: <55e4fa31-f365-47ae-a846-d80036981124@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 10/22/2012 12:41 PM, Alexandre DERUMIER wrote:
> Hi,
>
> I'm looking for use "rbd export " to stdout and not a file.
>
> Is it possible ? any hint ?
>

No, not at this moment. I tried a fifo, but that won't work due to 
O_EXCL and O_CREATE the rbd command uses.

I think it should be possible to export to stdout, but it will require 
some code changes.

I created a feature request for it: http://tracker.newdream.net/issues/3380

Wido

> Regards,
>
> Alexandre Derumier
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

