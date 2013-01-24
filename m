From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 11:09:41 -0600
Message-ID: <51016AD5.4080701@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net> <5101572E.2080207@bmrb.wisc.edu> <CAKMAVE8_DaRs4=SXjsJeseK5JrT389pfat96upzw=hEsxBaA5Q@mail.gmail.com>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:46224 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3AXRJd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 12:09:33 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id 6A3C82C0361
	for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 11:09:32 -0600 (CST)
In-Reply-To: <CAKMAVE8_DaRs4=SXjsJeseK5JrT389pfat96upzw=hEsxBaA5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 1/24/2013 10:22 AM, Sam Lang wrote:

...  Does that make sense?

Yes, but when I'm trying to set up a ceph server using the quick start 
guide, mkcephfs is failing with an error message I didn't write down, 
but the complaint was along the lines of missing rbd.ko. Booting a 3.7 
kernel made it go away.

This is the part where everyone says "server stuff should run on the 
stock centos kernel" but in my reality it doesn't. (So I'm trying to 
figure out why my reality is different from everyone else's ;)

I'll see if I can reproduce it and post the exact error message.

Dima

