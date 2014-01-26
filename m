From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH v2 3/3] libceph: handle dead tcp connections during
 connection negotiation
Date: Sun, 26 Jan 2014 14:43:30 +0200
Message-ID: <CALFYKtDRSshn_kHC=2f-b6GsSsJv0DVh+JGJSmO9=vY5Khqo-Q@mail.gmail.com>
References: <1390302667-8729-1-git-send-email-ilya.dryomov@inktank.com>
	<1390302667-8729-4-git-send-email-ilya.dryomov@inktank.com>
	<alpine.DEB.2.00.1401241502010.2149@cobra.newdream.net>
	<CALFYKtDoPBddGcXu5crtcmTStstCOYNo7JK_0YeqLgyA4seakQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:47326 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbaAZMnc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jan 2014 07:43:32 -0500
Received: by mail-we0-f176.google.com with SMTP id t61so4304001wes.35
        for <ceph-devel@vger.kernel.org>; Sun, 26 Jan 2014 04:43:30 -0800 (PST)
In-Reply-To: <CALFYKtDoPBddGcXu5crtcmTStstCOYNo7JK_0YeqLgyA4seakQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I've looked into this some more and I now think connect_timeout
approach not the best way to fix this.  I think a better way is to go
through all connection and negotiation waits on both rbd and cephfs
sides and make sure they are interruptible and have a timeout attached.
Only if that turns out to be not feasible should we go with this
connect_timeout bolt-on.

Thanks,

                Ilya
