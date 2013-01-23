From: Patrick McGarry <patrick@inktank.com>
Subject: Re: Understanding Ceph
Date: Wed, 23 Jan 2013 11:19:49 -0500
Message-ID: <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
	<50FAC92C.8030709@bmrb.wisc.edu>
	<alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
	<CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
	<alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
	<50FAE116.2010504@gmail.com>
	<alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
	<50FC1DCF.8010304@bmrb.wisc.edu>
	<CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:40847 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384Ab3AWQTt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 11:19:49 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so3856075dak.20
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 08:19:49 -0800 (PST)
In-Reply-To: <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: dmaziuk@bmrb.wisc.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dimitri,

For what it's worth I also stepped through the process of spinning up
Ceph and OpenStack on a single EC2 node in a recent blog entry:

http://ceph.com/howto/building-a-public-ami-with-ceph-and-openstack/

It has some shortcuts (read: not meant to be production) but it may
help give you a quicker quickstart.  Feel free to shout if you have
questions, either here or poke scuttlemonkey on #ceph or twitter.
Good luck.  Thanks.


Best Regards,

Patrick

On Wed, Jan 23, 2013 at 10:13 AM, Sam Lang <sam.lang@inktank.com> wrote:
> On Sun, Jan 20, 2013 at 10:39 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
>> On 1/19/2013 12:16 PM, Sage Weil wrote:
>>
>>> We generally recommend the KVM+librbd route, as it is easier to manage the
>>> dependencies, and is well integrated with libvirt.  FWIW this is what
>>> OpenStack and CloudStack normally use.
>>
>>
>> OK, so is there a quick stat document for that configuration?
>
> http://ceph.com/docs/master/rbd/rbd-openstack/
> -sam
>
>>
>> (Oh, and "form" in my other message is supposed to be "from": tyop)
>>
>> Dima
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Patrick McGarry
Director, Community
Inktank

@scuttlemonkey @inktank @ceph
