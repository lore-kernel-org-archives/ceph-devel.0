From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Re: Re:Re: Re:Re:Re:Re: How does rbd-mirror preserve the order of
 WRITE operations that finished on the primary cluster
Date: Tue, 6 Jun 2017 07:20:02 -0400
Message-ID: <CA+aFP1B6KpO4QV=gO0VLU6manv9vRiX6_aXBr50VUu9Xn=4b3Q@mail.gmail.com>
References: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com>
 <CA+aFP1B=M97rVtGcY=v79zg_2rS=+NNcO5FTT32yLCZtky7N7g@mail.gmail.com>
 <75e21ee8.f334.15c78f23929.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706051616540.3646@piezo.novalocal>
 <428d3e79.3d2.15c7a56a64f.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706052222060.3646@piezo.novalocal>
 <cdf481f.45b.15c7a741e28.Coremail.xxhdx1985126@163.com> <448ceff0.46ce.15c7b5c0b16.Coremail.xxhdx1985126@163.com>
 <CACJqLyYVmvTuxz6rABvweFyM2++2TFf2q6n3-dzt6AfrpZyDKQ@mail.gmail.com>
 <344a1254.5a75.15c7b942fa4.Coremail.xxhdx1985126@163.com> <762fe21a.9068.15c7c58f41b.Coremail.xxhdx1985126@163.com>
 <CACJqLyaKv3TvkFopog0mkGCyDqOaC-9ZcgPnPgYMvNRiW3DWCg@mail.gmail.com> <349ebded.9bdc.15c7c722502.Coremail.xxhdx1985126@163.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33469 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdFFLUD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 07:20:03 -0400
Received: by mail-yb0-f177.google.com with SMTP id 202so40620748ybd.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 04:20:03 -0700 (PDT)
In-Reply-To: <349ebded.9bdc.15c7c722502.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: Haomai Wang <haomai@xsky.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 6, 2017 at 4:07 AM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
> So, if that case happens, rbd-mirror will go on replicate subsequent writes, is this right?

Yes -- until it reaches a flush event and is stalled on the
uncommitted IO from the down OSD (or until it reaches the hard-stop of
100 in-flight, uncommitted IOs).


-- 
Jason
