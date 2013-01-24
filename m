From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 16:58:01 +0100
Message-ID: <51015A09.50702@widodh.nl>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net> <5101572E.2080207@bmrb.wisc.edu> <5101590B.4040002@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37959 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3AXP6B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 10:58:01 -0500
In-Reply-To: <5101590B.4040002@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: dmaziuk@bmrb.wisc.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/24/2013 04:53 PM, Jens Kristian S=F8gaard wrote:
> Hi Dimitri,
>
>> Where in ceph.conf do I tell it to use qemu and librbd instead of
>> kernel module?
>
> You do not need to specify that in ceph.conf.
>
> When you run qemu then specify the disk for example like this:
>
>   -drive format=3Drbd,file=3Drbd:/pool/imagename,if=3Dvirtio,index=3D=
0,boot=3Don
>

Small typo :) It has to be:

  -drive format=3Drbd,file=3Drbd:pool/imagename,if=3Dvirtio,index=3D0,b=
oot=3Don

Wido

> Where you replace "pool" and "imagename" with whatever you have calle=
d
> them.
>
> You can create new images with the qemu-img utility.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
