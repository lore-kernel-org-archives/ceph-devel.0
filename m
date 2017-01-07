From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Sat, 7 Jan 2017 12:03:52 +1100
Message-ID: <CA+z5DsxYf7DGZTw2QCRMztQ13zFX5NZd3Kj62xFxmwhznosNmg@mail.gmail.com>
References: <592054113.6138.1483710244101@ox.pcextreme.nl> <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
 <308159841.6179.1483720942271@ox.pcextreme.nl> <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36868 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966623AbdAGBEO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 20:04:14 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so51626801wmt.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 17:04:13 -0800 (PST)
In-Reply-To: <CAN=+7FWbLpgDhoxH1QHgPBpMuDAUL2gg3QOhWGAE_9cKt=yBBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 7 January 2017 at 04:04, Samuel Just <sjust@redhat.com> wrote:
> Namespaces are pretty much just a prefix, nothing tracks them.  Are
> you using them simply to avoid name conflicts?

I assumed for some sort of data and/or security segregation using
cephx? 30M pools is not exactly feasible...

-- 
Cheers,
~Blairo
