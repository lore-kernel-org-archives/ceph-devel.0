From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Are we ready to move from Trusty to Xenial in the lab?
Date: Tue, 13 Sep 2016 14:08:28 -0500
Message-ID: <be4fe90c-8dcf-8307-5c6a-01d1de0705c6@redhat.com>
References: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759239AbcIMTIa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 15:08:30 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83ABE8553E
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 19:08:30 +0000 (UTC)
In-Reply-To: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Maybe prototype it first on the new smithi nodes and if everything looks 
good, move the rest over?

Mark

On 09/13/2016 02:05 PM, Gregory Meno wrote:
> Hello readers,
>
> I am aware that our nightly tests are running on centos7 and trusty in
> the sepia lab. xenial has been the lastest LTS release of Ubuntu for
> some time now. It seems like we should move the nightly testing on to
> xenial
>
> Here are some benefits to moving the nightlies up to xenial:
>
> * Quicker feedback of issues before we release
> * Easier access to reproduce issues that are reported after release
> * provide an easy way to judge readiness for a Python3 world
>
> Some things that might prevent us from going there this week.
>
> * we should wait till we have a mechanism to re-image bare metal lab
> machines on the fly before each test (edeploy --
> https://github.com/redhat-cip/edeploy)
> * python3 isn't quite ready and we'll feel a lot of pain in the short term
>
> Is there something I'm missing here?
> Should we just go ahead and see how it goes?
>
> cheers,
> Gregory
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
