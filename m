From: Gregory Farnum <greg@inktank.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Thu, 9 Jan 2014 09:28:25 -0800
Message-ID: <CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:51372 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaAIR20 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 12:28:26 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so2881943qcx.32
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2014 09:28:25 -0800 (PST)
In-Reply-To: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The FileJournal is also for data safety whenever we're using write
ahead. To disable it we need a backing store that we know can provide
us consistent checkpoints (i.e., we can use parallel journaling mode =97
so for the FileJournal, we're using btrfs, or maybe zfs someday). But
for those systems you can already configure the system not to use a
journal.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
> Hi all,
>
> We know FileJournal plays a important role in FileStore backend, it c=
an
> hugely reduce write latency and improve small write operations.
>
> But in practice, there exists exceptions such as we already use Flash=
Cache or cachepool(although it's not ready).
>
> If cachepool enabled, we may use use journal in cache_pool but may
> not like to use journal in base_pool. The main reason why drop journa=
l
> in base_pool is that journal take over a single physical device and w=
aste
> too much in base_pool.
>
> Like above, if I enable FlashCache or other cache, I'd not like to en=
able
> journal in OSD layer.
>
> So is it necessary to disable journal in special(not really special) =
case?
>
> Best regards,
> Wheats
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
