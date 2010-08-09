From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to remove/update a RBD device?
Date: Mon, 09 Aug 2010 12:38:18 +0200
Message-ID: <1281350298.2246.8.camel@wido-desktop>
References: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:33539 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab0HIKiV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 06:38:21 -0400
In-Reply-To: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Xiaoguang,

I don't have a RBD system running at the moment, so i can't check my
commands.

But when you have /dev/rbd0, you can remove this device with:

echo 0 > /sys/class/rbd/remove

There might be a resize option, see:
http://tracker.newdream.net/issues/42

echo 0 > /sys/class/rbd/refresh

Does that work for you?

Wido

On Mon, 2010-08-09 at 14:48 +0800, Xiaoguang Liu wrote:
> the following command will add rbd device on Linux
>          echo "172.16.12.1 name=admin rbd foo" > /sys/class/rbd/add
> 
> but how to remove it or change it (after I resize the image by rbd
> resize foo -size=xxx)? the wiki does not say.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

