From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 11:36:15 -0600
Message-ID: <CAANLjFqLAHV2NEpc0-p3Ft4kqd3S+L_EpQTAFGa7vd4gT8fS_w@mail.gmail.com>
References: <56018A05.6090100@mirantis.com>
	<alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
	<56029F66.3070503@mirantis.com>
	<alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
	<CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
	<5602C48C.4010009@mirantis.com>
	<CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
	<5604131E.2030408@mirantis.com>
	<alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
	<56041D16.6060805@mirantis.com>
	<alpine.DEB.2.00.1509240900540.13265@cobra.newdream.net>
	<560423DD.3080701@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34468 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbbIXRgQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 13:36:16 -0400
Received: by vkhf67 with SMTP id f67so41400947vkh.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 10:36:15 -0700 (PDT)
In-Reply-To: <560423DD.3080701@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm probably missing something, but since we are talking about data at
rest, can't we just have the OSD compress the object as it goes to
disk? Instead of
rbd\udata.1ba49c10d9b00c.0000000000006859__head_2AD1002B__11 it would
be rbd\udata.1ba49c10d9b00c.0000000000006859__head_2AD1002B__11.{gz,xz,bz2,lzo,etc}.
Then it seems that you don't have to muck with stripe sizes or
anything. For compressible objects they would be less than 4MB, some
of theses algorithms already say if it is not compressible enough,
just store it.

Something like zlib Z_FULL_FLUSH may help provide some seek points
within an archive to prevent decompressing the whole object for reads?

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Sep 24, 2015 at 10:25 AM, Igor Fedotov  wrote:
>
>
> On 24.09.2015 19:03, Sage Weil wrote:
>>
>> On Thu, 24 Sep 2015, Igor Fedotov wrote:
>>
>> Dynamic stripe sizes are possible but it's a significant change from the
>> way the EC pool currently works. I would make that a separate project (as
>> its useful in its own right) and not complicate the compression situation.
>> Or, if it simplifies the compression approach, then I'd make that change
>> first. sage
>
> Just to clarify a bit. What I saw when played with Ceph. Please correct me
> if I'm wrong..
>
> For low-level RADOS access client data written to EC pool has to be aligned
> with stripe size . The last block can be unaligned though but no more
> appends are permitted in this case.
> Data copied from cache goes in blocks up to 8Mb size. In general case  the
> last block seems to have unaligned size too.
>
> EC pool additionally performs alignment of the incoming blocks to stripe
> bound internally. This way blocks going to EC lib are always aligned.
> We should probably perform compression prior to this alignment.
> Thus some dependency on stripe size is present in EC pools but it's not that
> strict.
>
> Thanks,
> Igor
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.1.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWBDSDCRDmVDuy+mK58QAAmwwP/3q0tbLZA95RVsvSLrXk
ipuhjiGPvAX8o2kTYFtf5tXkMuiJIJIy+WK1uD6zs+CXM/2JR6SJthS3tE9A
meaFW7W5lropbWKRZ8TkpUNQAXDyRrpSEcTDBWciq+EOca5tlP+17KDevVnZ
PWDCNPlZmbHyBy91iJju4TTzaJYoD8mXU/+4xLCicePDPomlpO4oyndDfOmI
JP5uRDmgP0ecsxfcyoYSTCJylfnBsmK0IMyxZoV2Mx+SEcqgtECPCOY7Uc/4
wwXGhu//zO7twyOvtsk4OQGjLX9wpSpVWz+zcR2RYiYfw3YSTSzGvbBC5hpb
pfQya5DbypJra2oz5BZkikvwYPhxPoI0FcdTCYFFxclm0jMwQqh2b141kN8Z
eR7v8ttfnbACumWP74j2KSpHRm/1l65nN4wqzg3ovoesjoJDvb2miz8AX7ag
FXVa54JpIcoIzCkIkqvpCfzhatGU55yQiyt7aFAhJfpmP/cNpxmAete8buTK
6aFMiYWFJe+md/bLOrk5g/cyr9BUq+tHT7Qf+mRmgw9fuECUXMXMzf6vOUk8
0JnYiYVk0j+twZeuDaVPBrXEMKuYuq7NlILuHJDF3meRPM2xekan8ARZoJxL
XAOzvaEFly0TH5DJfItSVOL86qtp+1orULSrVbtvolxzQtv8xiNOzJYBKEnO
ouVI
=d8mm
-----END PGP SIGNATURE-----
