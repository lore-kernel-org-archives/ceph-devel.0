From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 07:55:43 -0600
Message-ID: <51013D5F.7090105@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:45623 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3AXNze (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 08:55:34 -0500
In-Reply-To: <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 1/24/2013 2:49 AM, Gandalf Corvotempesta wrote:
> 2013/1/24 Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>:
>> So I'm stuck at a point way before those guides become relevant: once I
>> had one OSD/MDS/MON box up, I got "HEALTH_WARN 384 pgs degraded; 384 pgs
>> stuck unclean; recovery 21/42 degraded (50.000%)" (384 appears be the
>> number of placement groups created by default).
>>
>> What does that mean? That I only have one OSD? Or is it genuinely unhealthy?
>
> ceph is building it's cluster. You should wait for it.
> In my case, it needed 5-10 minutes.

No, that's not it: it was stuck in that state for 40 minutes or so.

Dima

