From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Understanding Ceph
Date: Thu, 24 Jan 2013 10:14:41 -0600
Message-ID: <51015DF1.7050708@bmrb.wisc.edu>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu> <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net> <5101572E.2080207@bmrb.wisc.edu> <5101590B.4040002@mermaidconsulting.dk> <51015A09.50702@widodh.nl>
Reply-To: dmaziuk@bmrb.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:46020 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab3AXQO2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:14:28 -0500
Received: from [192.168.1.2] (71-90-100-249.dhcp.ftbg.wi.charter.com [71.90.100.249])
	(Authenticated sender: dmaziuk)
	by mail.bmrb.wisc.edu (Postfix) with ESMTPSA id A8CCF2C03FE
	for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 10:14:27 -0600 (CST)
In-Reply-To: <51015A09.50702@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 1/24/2013 9:58 AM, Wido den Hollander wrote:
> On 01/24/2013 04:53 PM, Jens Kristian S=F8gaard wrote:
>> Hi Dimitri,
>>
>>> Where in ceph.conf do I tell it to use qemu and librbd instead of
>>> kernel module?
>>
>> You do not need to specify that in ceph.conf.
>>
>> When you run qemu then specify the disk for example like this:
>>
>>   -drive format=3Drbd,file=3Drbd:/pool/imagename,if=3Dvirtio,index=3D=
0,boot=3Don
>>
>
> Small typo :) It has to be:
>
>   -drive format=3Drbd,file=3Drbd:pool/imagename,if=3Dvirtio,index=3D0=
,boot=3Don

Thanks but I'm still missing the context. I'm following this document:
  http://ceph.com/docs/master/start/quick-start/
to set up an osd/mds/mon *server*.

The step that's failing without the kernel module is "Deploy the=20
configuration #2":
  mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring

Are you saying I'm to run "qemu -drive ..." instead of mkcephfs?

Dima (I'm assuming either you aren't or qemu has changed a lot since I=20
last looked)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
