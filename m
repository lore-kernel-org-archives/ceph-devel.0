From: Samuel Just <sjust@redhat.com>
Subject: Re: Per Object Scrub
Date: Tue, 4 Aug 2015 09:41:28 -0700
Message-ID: <CAN=+7FXQEitnumxwn53CTjE3Nv_KMyVbV_tA2SYK=+ebceDU5w@mail.gmail.com>
References: <CY1PR0401MB0985BEEA720362B4E22AA93D88760@CY1PR0401MB0985.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36485 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbbHDQl3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:41:29 -0400
Received: by igbij6 with SMTP id ij6so78200029igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 09:41:28 -0700 (PDT)
In-Reply-To: <CY1PR0401MB0985BEEA720362B4E22AA93D88760@CY1PR0401MB0985.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Manzanares <Adam.Manzanares@hgst.com>
Cc: "Ceph Developer List (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

That's the idea.  The blueprint has some information about the design.
I do want to add per-object scrub as part of the scrub/repair
improvements.
-Sam

On Tue, Aug 4, 2015 at 9:34 AM, Adam Manzanares
<Adam.Manzanares@hgst.com> wrote:
> I noticed that there is a blueprint for osd: scrub and repair for Infernalis:
>
> https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_Scrub_and_Repair
>
> There is also a feature request for per-object scrub:
>
> http://tracker.ceph.com/issues/9951
>
> I noticed in the blueprint that there was no mention of a per-object scrub, I am also interested
> in this feature. Is there any plan of adding per-object scrub when scrub and repair is improved?
>
>
> Thanks,
> Adam
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
