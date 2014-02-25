From: Ricardo Rocha <rocha.porto@gmail.com>
Subject: Re: ceph-standalone
Date: Tue, 25 Feb 2014 16:34:20 +1300
Message-ID: <CA+xPSVC63jiZe5RY+Sq_HE4=vBCNR0Hn09ZXwz6_1GW3FBZsNQ@mail.gmail.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
	<22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
	<F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
	<187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>
	<CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>
	<CAGRK8cxE10daLT8EwWr-_s_NjaWj-D_COPKy3HvwVgO=4qWj9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:35294 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaBYDeV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 22:34:21 -0500
Received: by mail-ve0-f180.google.com with SMTP id cz12so5447594veb.11
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 19:34:20 -0800 (PST)
In-Reply-To: <CAGRK8cxE10daLT8EwWr-_s_NjaWj-D_COPKy3HvwVgO=4qWj9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hunter Nield <hunter@acale.ph>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I did it mostly to learn about docker (and because i wanted a 'cluster
in the office' like Loic had :-)). Not incredibly pretty though.

Usually i go with vagrant to deploy ceph in a box (1 mon, 2 osds) in
an lxc container, with file loopback mounts and using the puppet
module to deploy/config (which has good vagrant integration, and
mimics our production env). We use a similar setup for the openstack
bits, and it's also the basis of our continuous integration.

On Tue, Feb 25, 2014 at 3:11 PM, Hunter Nield <hunter@acale.ph> wrote:
> The packer solution sounds sensible to me as it also would allow the
> creation of Docker images.
>
> A basic Docker image has already been started
> (https://index.docker.io/u/rochaporto/cephbox/) but it would be quite
> useful to have a version that comes from an official maintained
> source.
>
> On Tue, Feb 25, 2014 at 7:06 AM, Kyle Bader <kyle.bader@gmail.com> wrote:
>>> so that's great. It's already almost done. Let us know when you have managed updating it.
>>>
>>> I suppose it would be best if we could offer one image each of the last 3 Ceph versions (dumpling, emperor and firefly) so people can then play with the expected level they are looking for in either test environment or production environment.
>>>
>>> Each of the images would be maintained up to date for the last stable code base of each version only to reduce time consuming.
>>
>> This is screaming for us to use packer [1], that way we can easily
>> create vbox/kvm/ec2 images from a file that we can stash in git
>>
>> [1] http://www.packer.io/
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
