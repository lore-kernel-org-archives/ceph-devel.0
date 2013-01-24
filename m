From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 09:49:04 +0100
Message-ID: <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57192 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3AXItG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 03:49:06 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so212175wib.5
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 00:49:04 -0800 (PST)
In-Reply-To: <51007C0C.2030107@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/1/24 Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>:
> So I'm stuck at a point way before those guides become relevant: once I
> had one OSD/MDS/MON box up, I got "HEALTH_WARN 384 pgs degraded; 384 pgs
> stuck unclean; recovery 21/42 degraded (50.000%)" (384 appears be the
> number of placement groups created by default).
>
> What does that mean? That I only have one OSD? Or is it genuinely unhealthy?

ceph is building it's cluster. You should wait for it.
In my case, it needed 5-10 minutes.
