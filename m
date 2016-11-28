From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: What is XFS/filesystem corruption and whose fault is it?
Date: Mon, 28 Nov 2016 13:10:11 -0800
Message-ID: <CAJ4mKGZEpa045MWB=tbE-YXPDMNbBCetq2g_wfOUBZRsN+GStQ@mail.gmail.com>
References: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz> <1843397305.3730062.1480168576510.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36461 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754874AbcK1VKM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 16:10:12 -0500
Received: by mail-io0-f172.google.com with SMTP id m5so115850471ioe.3
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 13:10:12 -0800 (PST)
In-Reply-To: <1843397305.3730062.1480168576510.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 26, 2016 at 5:56 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> I think writeback should not be a problem if barrier is enabled.
>
> you can loose last x seconds of writes, but fs should not break.

That might work for XFS but it won't work for the wider Ceph cluster —
it's against the RADOS guarantees and expectations for an OSD to go
back in time after committing an update and *can* result in failure.
-Greg

>
>
> Also for ssd drives, you need supercapacitor (generally present in all enterprise ssd),
> to not loose datas in ssd memory buffer
>
> ----- Mail original -----
> De: "Nathan Cutler" <ncutler@suse.cz>
> À: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoyé: Vendredi 25 Novembre 2016 17:26:07
> Objet: What is XFS/filesystem corruption and whose fault is it?
>
> I've been doing some research on OSDs not starting after power outages,
> when supposedly "uncorruptible" XFS filesystems are corrupted and need
> repair. This led me to write the following brief blog post:
>
> http://smithfarm-thebrain.blogspot.cz/2016/11/what-is-xfsfilesystem-corruption-and.html
>
> Any comments and/or suggestions for improvement would be most welcome.
>
> Thanks for reading!
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
