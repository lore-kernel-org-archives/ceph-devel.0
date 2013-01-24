From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 12:53:33 -0800
Message-ID: <CAM2gkg6pN2546gBS8J0J=RUtL6RONzBunkF1ovPoRtP_MynzjA@mail.gmail.com>
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
	<CAJH6TXhwBY+gTDDksCfMroDodeN1b8ttM7zjNc2tn5PXzYbcZg@mail.gmail.com>
	<51013D5F.7090105@bmrb.wisc.edu>
	<CAKMAVE9HMo4x3seuG7ppeafSRJmBwjUXrLv0GUA-z5kDXyhoQA@mail.gmail.com>
	<51015318.8000404@bmrb.wisc.edu>
	<CAM2gkg6m2S0DtgapSOg16GTmGQHsj7fz=a3XzH0ZsvcCWHcBtg@mail.gmail.com>
	<510190EF.60306@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:54413 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab3AXU76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 15:59:58 -0500
Received: by mail-ia0-f181.google.com with SMTP id k25so5449609iah.12
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 12:59:57 -0800 (PST)
In-Reply-To: <510190EF.60306@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dima,

I went ahead and updated the quick-start conf with an example. I
appreciate the feedback.

John

On Thu, Jan 24, 2013 at 11:52 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
>
> On 01/24/2013 12:38 PM, John Wilkins wrote:
> > Dima,
> >
> > I'm working on a new monitoring and troubleshooting guide now that will
> > answer most of the questions related to OSD and placement group states. I
> > hope to have it done this week. I have not actually tested the quick starts
> > on centos or rhel distributions, but it's on our radar. The intention of
> > the quick starts is to get you up and running quickly. It doesn't cover
> > deeper issues like how to monitor and troubleshoot. I'm working on adding a
> > lot more substantive content there now.
>
> A couple of things in the quick start:
>
> - there should be no space between "rw," and "noatime" in
> osd mount options {fs-type} = {mount options} # default mount option is
> "rw, noatime"
>
> - for ext4, you need to specify "user_xattr" there or mkcephfs will fail
> (with --mkfs at least).
>
> --
> Dimitri Maziuk
> Programmer/sysadmin
> BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu
>



--
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
