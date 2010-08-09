From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: how to remove/update a RBD device?
Date: Mon, 9 Aug 2010 10:01:54 -0700
Message-ID: <AANLkTiniVGoWBLMFaKbrNcni6Q=5nE7WV0Xb=GhrEBx-@mail.gmail.com>
References: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
	<1281350298.2246.8.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34088 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab0HIRBz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 13:01:55 -0400
Received: by pzk26 with SMTP id 26so3712727pzk.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Aug 2010 10:01:55 -0700 (PDT)
In-Reply-To: <1281350298.2246.8.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Xiaoguang Liu <syslxg@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Aug 9, 2010 at 3:38 AM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi Xiaoguang,
>
> I don't have a RBD system running at the moment, so i can't check my
> commands.
>
> But when you have /dev/rbd0, you can remove this device with:
>
> echo 0 > /sys/class/rbd/remove
>
> There might be a resize option, see:
> http://tracker.newdream.net/issues/42
>
> echo 0 > /sys/class/rbd/refresh
>

This will update the list of snapshots, but will not resize a mapped
device. For doing that you'll need to remove/add the device.
Also, it is highly unrecommended to alter the image while it is
mapped, as there is no proper locking and notification mechanism.

Yehuda
