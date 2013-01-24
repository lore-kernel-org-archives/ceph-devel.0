From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 09:45:50 -0600
Message-ID: <5101572E.2080207@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:45931 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3AXPpd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 10:45:33 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id 216832C0AF5
	for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 09:45:33 -0600 (CST)
In-Reply-To: <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


One other question I have left (so far) is: I read and tried to follow 
http://ceph.com/docs/master/install/rpm/ and 
http://ceph.com/docs/master/start/quick-start/ on centos 6.3.

mkcephfs step fails without rbd kernel module.

I just tried to find "libvirt", "kernel", "module", and "qemu" on those 
pages: "kernel" occurs in "add ceph packages" section and "module" 
occurs in the header, footer, and the side menu. 0 hits for the others.

So when I read "after learning that qemu uses librbd (and thus doesn't 
rely on the rbd kernel module) I was happy to stick with the stock 
CentOS kernel for my servers (with updated qemu and libvirt builds)" -- 
forgive me for being dense, but I have no context for this. Where in 
ceph.conf do I tell it to use qemu and librbd instead of kernel module? 
Or does it mean I'm to set up my OSDs in virtual machines? Seems I'm 
missing an important piece of information here (possibly because it's 
blatantly obvious and is staring me in the face -- woudn't be the first 
time).

So what is it that I'm missing?

TIA
Dima

