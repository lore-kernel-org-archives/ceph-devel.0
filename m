From: Sage Weil <sage@newdream.net>
Subject: Re: OSD crashes (10.2.9)
Date: Tue, 19 Sep 2017 17:18:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709191717510.4417@piezo.novalocal>
References: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com> <alpine.DEB.2.11.1709191707410.4417@piezo.novalocal> <CAGbvivLQEv6DYqeE-cJqYO57m8ih0ViKUgQXUF7C7f_TM-Tz5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57914 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdISRSt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 13:18:49 -0400
In-Reply-To: <CAGbvivLQEv6DYqeE-cJqYO57m8ih0ViKUgQXUF7C7f_TM-Tz5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 19 Sep 2017, Wyllys Ingersoll wrote:
> It appears to just be getting an abort signal, I dont see any other assertions.

It may be a ways up in the log if the OSD was busy.  Search for the thread 
id from this line

>      0> 2017-09-19 12:18:26.842937 7f2d95fc4700 -1 *** Caught signal
> (Aborted) **
>  in thread 7f2d95fc4700 thread_name:tp_osd

(7f2d95fc4700 in this case) backwards to find the failed assertion message.

Thanks!
sage
