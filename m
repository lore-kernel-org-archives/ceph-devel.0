From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re:
Date: Thu, 17 May 2012 14:10:41 -0700
Message-ID: <4FB56951.2020401@inktank.com>
References: <CAEj+kbnJ6yHBw3zPA9OivmKwv7BTg32ze4q82dZH2Y74Gk6arw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42296 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664Ab2EQVKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 17:10:44 -0400
Received: by dady13 with SMTP id y13so2929149dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 14:10:44 -0700 (PDT)
In-Reply-To: <CAEj+kbnJ6yHBw3zPA9OivmKwv7BTg32ze4q82dZH2Y74Gk6arw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/07/2012 05:54 PM, Tim Flavin wrote:
> The new site is great!  I like the Ceph documentation, however I found
> a couple of typos.  Is this the best place address them?  (Some of the
> apparent typos may be my not understanding what is going on.)
>
>
>
> http://ceph.com/docs/master/config-cluster/ceph-conf/
>
> The  "Hardware Recommendations" link near the bottom of the page gives
> a 404.  Did you want to point to
> http://ceph.com/docs/master/install/hardware-recommendations/ ?
>
>
> http://ceph.com/docs/master/config-ref/osd-config
>
> For  "osd client message size cap"  The default value is 500 MB but
> the description lists it a 200 MB.
>
>
> http://ceph.com/docs/master/api/librbdpy/
>
> The line of code: "size = 4 * 1024 * 1024  # 4 GiB" appears to be
> missing a * 1024, and the next line
>   is "rbd_inst.create('myimage', 4)" when it probably should be
> "rbd_inst.create('myimage', size)" This is repeated several times.

Thanks for the notes - I've fixed these in the master branch.

All the docs are in git under the doc directory - if you find other
problems, feel free to send a patch or a github pull request. You can
even edit it in a browser on github if you like.
