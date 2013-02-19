From: Samuel Just <sam.just@inktank.com>
Subject: Re: 0.56 scrub OSD memleaks, WAS Re: [0.48.3] OSD memory leak when scrubbing
Date: Tue, 19 Feb 2013 11:23:06 -0800
Message-ID: <CA+4uBUY1KaDcHFn_BTQ0TZJcokSh8MRUd25VQ_PBJ5EXNnPEEw@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
	<CAF6-1L61H28xXDPZBC5Um0tyJLs2uGX8S7G2UjpL64fnt7oRcA@mail.gmail.com>
	<alpine.DEB.2.00.1301301139490.18801@cobra.newdream.net>
	<CAF6-1L5z39ZsPwBz5yJWDvQoX7UaUZ5PVpUwfVhoBne56Z018Q@mail.gmail.com>
	<alpine.DEB.2.00.1301311141240.807@cobra.newdream.net>
	<510EA9A1.6070505@dachary.org>
	<CAOLwVUkUFvLihb6KbxG9Et7R_-ZTZpLQJYTjXm9TEe40V_ZRHg@mail.gmail.com>
	<CAOLwVUmYm0shGzdxfyg6LXSDgxa1hxF_Kh1oRDZXKtupvGB3VQ@mail.gmail.com>
	<CAOLwVUmNc_kZgbuKO4VY2mTBAV4FkwrLT=YdK1qJZhsK=sjbMQ@mail.gmail.com>
	<alpine.DEB.2.00.1302040930540.27333@cobra.newdream.net>
	<51102210.2040300@inktank.com>
	<CAOLwVUknsZnGeT8dT8KcjNy4OQ2V5j9sg0Ry_SCq+YDb8ctSdw@mail.gmail.com>
	<CAPYLRziYOHRVeT5ZbDWjn2K3q=pVc8=fTQqcfGMnmVd9UOLnyA@mail.gmail.com>
	<CAOLwVUn3o=RKci50jVEPvNmkGrzpi_43M=Cp_HGNYL6ye_68VA@mail.gmail.com>
	<CABYiri8C9pSCW0a+ZZhLHGWL3+Eh1=8Y6brsPc2S1fvB1G1dYQ@mail.gmail.com>
	<511F4CAC.6020405@42on.com>
	<51225AD7.8080606@de-punkt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:33981 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897Ab3BSTXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 14:23:08 -0500
Received: by mail-vc0-f170.google.com with SMTP id p16so4527017vcq.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 11:23:08 -0800 (PST)
In-Reply-To: <51225AD7.8080606@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can you confirm that the memory size reported is res?
-Sam

On Mon, Feb 18, 2013 at 8:46 AM, Christopher Kunz <chrislist@de-punkt.de> wrote:
> Am 16.02.13 10:09, schrieb Wido den Hollander:
>> On 02/16/2013 08:09 AM, Andrey Korolyov wrote:
>>> Can anyone who hit this bug please confirm that your system contains
>>> libc 2.15+?
>>>
>>
> Hello,
>
> when we started a deep scrub on our 0.56.2 cluster today, we saw a
> massive memleak about 1 hour into the scrub. One OSD claimed over
> 53GByte within 10 minutes. We had to restart the OSD to keep the cluster
> stable.
>
> Another OSD is currently claiming about 27GByte and will be restarted
> soon. All circumstantial evidence points to the deep scrub as the source
> of the leak.
>
> One affected node is running libc 2.15 (Ubuntu 12.04 LTS), the other one
> is using libc 2.11.3 (Debian Squeeze). So it seems this is not a
> libc-dependant issue.
>
> We have disabled scrub completely.
>
> Regards,
>
> --ck
>
> PS: Do we have any idea when this will be fixed?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
