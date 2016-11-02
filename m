From: Marov Aleksey <Marov.A@raidix.com>
Subject: HA: ceph, XioMessenger issue
Date: Wed, 2 Nov 2016 21:17:34 +0000
Message-ID: <FEC85B105C5F644CA51BDB90657EEA98281CB39A@ddsm-mbx01.digdes.com>
References: <FEC85B105C5F644CA51BDB90657EEA98281CB374@ddsm-mbx01.digdes.com>,<alpine.DEB.2.11.1611022003390.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digdes.com ([85.114.5.13]:43788 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757141AbcKBVXQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Nov 2016 17:23:16 -0400
In-Reply-To: <alpine.DEB.2.11.1611022003390.20331@piezo.us.to>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok. Thanks for fast feedback.Yes you are right by default xio is disabled.  I will make pull request after making some corrections and testing rdma on different infiniband devices.

thanks again.

Best Regards
Alex
________________________________________
От: Sage Weil [sweil@redhat.com]
Отправлено: 2 ноября 2016 г. 23:07
Кому: Marov Aleksey
Копия: ceph-devel@vger.kernel.org
Тема: Re: ceph, XioMessenger issue

Hi Marov,

[adding ceph-devel]

On Wed, 2 Nov 2016, Marov Aleksey wrote:
> Sage hello,
>
> My name is Alex. May I ask you to help me to resolve some problem with the
> ceph?
> My problem is as follow. I have been testing ceph performance and wanted to
> check rdma messenger (XioMessenger). I have noticed that last commit in
> ./src/msg/xio/* had been made by you 23 days ago and I think it contains
> small mistake. In the commit 0dbe8fd3987db1c38bb2fbeae7789a8084dd5489 named
> "msg: make loopback Connection feature accurate all the time" in the file
> src/msg/xio/XioMessenger.cc line 353 you removed the constructor argument :
> uint64_t features. In fact, you have removed features from everywhere in
> messengers.
> Also you have removed the line 381 in
> src/msg/xio/XioMessenger.cc:
>
> 381 :  - local_features = features;
> but the next line
> 382 : loop_con->set_features(features);
>
> still use features to pass it in loop_con->set(...). So I got "undefined
> variable"  on compilation.

Ah, my mistake!  XIO does not build by default for me (I don't have
the requisite libraries installed) so I missed this.

> I think it is not so hard to solve this issue. We can
> 1. Pass CEPH_FEATURES_ALL or XIO_FEATURES_ALL in loop_con->set(..)
> or
> 2. Pass 0 to loop_con->set(). I don't know whether it is correct.
> or
> 3. remove this line . In fact, I don't know what loop_con->set does and
> whether it should stay.

Your (1) sounds correct.  Although I see in msg/async/AsyncMessenger.h
we already do

+    local_connection->set_features(CEPH_FEATURES_ALL);

In any case, the intent is to always use CEPH_FEATURE_ALL for the features
we advertise to our peers.

Once you fix the build, please submit a pull request so that we can get
them fixed in the master branch.  Thank you!

> Can you  tell me what is the correct option so I can continue my research?
> Do we have other places to correct?
> I do appreciate any ideas.
> Thanks for you help.
>
> P.S. Have you ever tested XioMessenger after your commit? It worked fine in
> the june of 2016 (ceph-10.2.0) but I'm not sure about the last ceph version.

It sounds like nobody else has hit this yet except you, so apparently
others also are building with xio in their dev environments.  :(

Thanks!
sage
