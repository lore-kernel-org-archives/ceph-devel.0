From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 10:15:41 -0800
Message-ID: <51017A4D.2000901@inktank.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:45638 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3AXSPp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 13:15:45 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so4405799dak.28
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 10:15:44 -0800 (PST)
In-Reply-To: <51015318.8000404@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dmaziuk@bmrb.wisc.edu
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/24/2013 07:28 AM, Dimitri Maziuk wrote:
> On 1/24/2013 8:20 AM, Sam Lang wrote:
>
>> Yep it means that you only have one OSD with replication level of 2.
>> If you had a rep level of 3, you would see degraded (66.667%). If you
>> just want to make the message go away (for testing purposes), you can
>> set the rep level to 1
>> (http://ceph.com/w/index.php?title=Adjusting_replication_level&redirect=no). 
>>
>
> OK, thanks Sam and Dino -- I kinda suspected that but didn't find any 
> docs.
>
> This looks like it's not adjustable via ceph.conf, I can only do it at 
> runtime, correct?

or you could just add another OSD.


