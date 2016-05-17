From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: TCP_NODELAY patch
Date: Tue, 17 May 2016 22:25:42 +0200
Message-ID: <CAOi1vP_EL5P5XzK5quhd-io7-x3j=G+P8g-=OLu_13dFufEsLA@mail.gmail.com>
References: <BL2PR02MB2115F428EB5C19C7F0173868F4480@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33845 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcEQUZo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 16:25:44 -0400
Received: by mail-vk0-f51.google.com with SMTP id c189so35382647vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2016 13:25:43 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115F428EB5C19C7F0173868F4480@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 17, 2016 at 8:05 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Ilya,
> Could you please let us know at what upstream kernel version the TCP_NODELAY krbd patch went in ?
> Is it there in RHEL 7.2 and Ubuntu 16.04 LTS ?

It went into 4.0.  IIRC 16.04 LTS is based on 4.4, so yes to both.

You can check it yourself with rbd map -o tcp_nodelay <imagename>.
If it doesn't fail with "libceph: bad option ..." in the dmesg, it's
there.

Thanks,

                Ilya
