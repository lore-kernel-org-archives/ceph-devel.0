From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk and /dev/dm-* permissions - race condition?
Date: Mon, 7 Nov 2016 22:35:18 +0100
Message-ID: <5820F396.3010405@dachary.org>
References: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
 <CADEhWsOYJeq3kVUL31fzsCmi6E2jueYQsy08OV+jXx-waqZe5w@mail.gmail.com>
 <CAGbvivKV1RNfUETQuKaAhGcRz98dNrCO-X8ha_a9CveFhXbNNw@mail.gmail.com>
 <CAGbvivJgNhEFLjAYst-zBCVLFxC0U4ZVHP=v+fXBrUDSfOauvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37417 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcKGVfW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 16:35:22 -0500
In-Reply-To: <CAGbvivJgNhEFLjAYst-zBCVLFxC0U4ZVHP=v+fXBrUDSfOauvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Rajib Hossen <rajib.hossen.ipvision@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I created http://tracker.ceph.com/issues/17813 to track that issue

On 07/11/2016 21:09, Wyllys Ingersoll wrote:
> add a line to the udev 55-dm.rules file just
> before the 'GOTO="dm_end"' line towards the end of that file:
> OWNER:="ceph", GROUP:="ceph", MODE:="0660"

It looks like the proper workaround to me. I'm not sure how that should be packaged though or if there is a better fix.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
