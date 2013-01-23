From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Understanding Ceph
Date: Wed, 23 Jan 2013 09:13:55 -0600
Message-ID: <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
	<50FAC92C.8030709@bmrb.wisc.edu>
	<alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
	<CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
	<alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
	<50FAE116.2010504@gmail.com>
	<alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
	<50FC1DCF.8010304@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50995 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3AWPN4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 10:13:56 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so357114obb.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 07:13:55 -0800 (PST)
In-Reply-To: <50FC1DCF.8010304@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dmaziuk@bmrb.wisc.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jan 20, 2013 at 10:39 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
> On 1/19/2013 12:16 PM, Sage Weil wrote:
>
>> We generally recommend the KVM+librbd route, as it is easier to manage the
>> dependencies, and is well integrated with libvirt.  FWIW this is what
>> OpenStack and CloudStack normally use.
>
>
> OK, so is there a quick stat document for that configuration?

http://ceph.com/docs/master/rbd/rbd-openstack/
-sam

>
> (Oh, and "form" in my other message is supposed to be "from": tyop)
>
> Dima
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
