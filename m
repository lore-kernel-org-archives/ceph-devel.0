From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: how long client will take when recover to ok,after ceph down.
Date: Mon, 14 Feb 2011 02:00:46 -0800
Message-ID: <AANLkTi=2eOzxo17HiOpAJ0aLj06oRcJHGVZ_+S7uHL2_@mail.gmail.com>
References: <4D57DFFB.5080703@nadir-seen-fire.com>
	<Pine.LNX.4.64.1102131028450.27567@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E915@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38535 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab1BNKAs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Feb 2011 05:00:48 -0500
Received: by fxm20 with SMTP id 20so4972950fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 02:00:47 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E915@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Longguang,

Basically, if *all* remote servers become inaccessible, you have two
bad choices:

1) Wait for the remote servers to become accessible.
This is Ceph's current behavior. This is also NFS' behavior in its
default "hard mount" mode.

2) Throw away data and metadata, but keep running
This is NFS' behavior if you have done a "soft mount."

Neither one of these choices is really good. That's why Ceph's focus
is on keeping the filesystem running even if a few nodes go down. We
have talked about implementing "soft mount" semantics for Ceph, but I
don't think it's been done yet (Sage, correct me if I'm wrong here?)
Also, you could get soft mount semantics by using libceph to access
the filesystem rather than the kernel client. Userspace programs usnig
libceph can always be killed in mid-write or read.

A lot of system administrators don't like soft mount semantics though.
Think carefully if that's really what you want.

cheers,
Colin


On Sun, Feb 13, 2011 at 5:21 PM, Longguang Yue
<longguang_yue@tcloudcomputing.com> wrote:
> When client lose its connection with ceph, then ls /mnt/ceph, it will
> hang all the time
> Remount does not work.
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
