From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 10:22:59 -0600
Message-ID: <CAKMAVE8_DaRs4=SXjsJeseK5JrT389pfat96upzw=hEsxBaA5Q@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
	<50FAC92C.8030709@bmrb.wisc.edu>
	<alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
	<CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
	<alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
	<50FAE116.2010504@gmail.com>
	<alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
	<50FC1DCF.8010304@bmrb.wisc.edu>
	<CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com>
	<CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com>
	<51007C0C.2030107@bmrb.wisc.edu>
	<96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
	<5101572E.2080207@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53184 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab3AXQXA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:23:00 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so3965645obc.33
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:22:59 -0800 (PST)
In-Reply-To: <5101572E.2080207@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 24, 2013 at 9:45 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
>
> One other question I have left (so far) is: I read and tried to follow
> http://ceph.com/docs/master/install/rpm/ and
> http://ceph.com/docs/master/start/quick-start/ on centos 6.3.
>
> mkcephfs step fails without rbd kernel module.
>
> I just tried to find "libvirt", "kernel", "module", and "qemu" on those
> pages: "kernel" occurs in "add ceph packages" section and "module" occurs in
> the header, footer, and the side menu. 0 hits for the others.
>
> So when I read "after learning that qemu uses librbd (and thus doesn't rely
> on the rbd kernel module) I was happy to stick with the stock CentOS kernel
> for my servers (with updated qemu and libvirt builds)" -- forgive me for
> being dense, but I have no context for this. Where in ceph.conf do I tell it
> to use qemu and librbd instead of kernel module? Or does it mean I'm to set
> up my OSDs in virtual machines? Seems I'm missing an important piece of
> information here (possibly because it's blatantly obvious and is staring me
> in the face -- woudn't be the first time).
>
> So what is it that I'm missing?

Setting up ceph is separate from setting up qemu to use librbd.
That's why the instructions at
http://ceph.com/docs/master/rbd/rbd-openstack/ say you need to have
your ceph cluster already running.  You can just setup ceph without
any specific config parameters for qemu or librbd, and then follow the
instructions there to get librbd working with openstack.  Because
librbd runs in userspace, you don't need the rbd kernel module, or a
modified kernel, so the stock centos kernel (or another distro's
kernel) should work for you.  Does that make sense?

-sam

>
> TIA
> Dima
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
