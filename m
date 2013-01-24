From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 14:52:34 -0800
Message-ID: <5101BB32.1070306@inktank.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com> <51013D5F.7090105@bmrb.wisc.edu> <CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com> <51015318.8000404@bmrb.wisc.edu> <CAM2gkg6
 m2S0DtgapSOg16GTmGQHsj7fz=a3XzH0ZsvcCWHcBtg@mail.gmail.com> <510190EF.60306@bmrb.wisc.edu> <CAM2gkg6pN2546gBS8J0J=RUtL6RONzBunkF1ovPoRtP_MynzjA@mail.gmail.com> <5101B281.6050206@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:64987 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab3AXWwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 17:52:40 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so4475861dae.35
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 14:52:40 -0800 (PST)
In-Reply-To: <5101B281.6050206@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: John Wilkins <john.wilkins@inktank.com>, Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/24/2013 02:15 PM, Dimitri Maziuk wrote:
> John,
>
> in block device quick start (http://ceph.com/docs/master/start/quick-rbd/)
>
> "sudo rbd map foo --pool rbd --name client.admin"
>
> maps the image to /dev/rbd0 here (centos 6.3/bobtail) so the subsequent
>
> "4. Use the block device. In the following example, create a file system.
>
> sudo mkfs.ext4 -m0 /dev/rbd/rbd/foo"
>
> should end with "/dev/rbd0" instead of "/dev/rbd/rbd/foo".
>

That's what happens when the udev rule for rbd isn't installed.

The rpm should include it, but it doesn't seem to be mentioned in the
spec file. I filed http://www.tracker.newdream.net/issues/3930 to track
that.

Josh
