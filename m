From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: stopped backfilling process
Date: Wed, 6 Nov 2013 07:08:01 +0100
Message-ID: <CAMNMNTxKb+8S4Qqn4dW19gyNBkYzCdm6wYBKbdFP5f4hXQNeqg@mail.gmail.com>
References: <CAMNMNTycwtKKstM8Egp-fSO4BQ-fQ=AYV_J1CdZQwMc-6wXe3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57120 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3KFGIC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 01:08:02 -0500
Received: by mail-oa0-f45.google.com with SMTP id i4so9812539oah.18
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 22:08:01 -0800 (PST)
In-Reply-To: <CAMNMNTycwtKKstM8Egp-fSO4BQ-fQ=AYV_J1CdZQwMc-6wXe3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
This is s3/ceph cluster, .rgw.buckets has 3 copies of data.
Many PG's are only on 2 OSD's and are marked as 'degraded'.
Scrubbing can fix this on degraded object's?

I don't have set tunables in cruch, mabye this can help (this is safe?)?

--
Regards
Dominik



2013/11/5 Dominik Mostowiec <dominikmostowiec@gmail.com>:
> Hi,
> After remove ( ceph osd out X) osd from one server ( 11 osd ) ceph
> starts data migration process.
> It stopped on:
> 32424 pgs: 30635 active+clean, 191 active+remapped, 1596
> active+degraded, 2 active+clean+scrubbing;
> degraded (1.718%)
>
> All osd with reweight==1 are UP.
>
> ceph -v
> ceph version 0.56.7 (14f23ab86b0058a8651895b3dc972a29459f3a33)
>
> health details:
> https://www.dropbox.com/s/149zvee2ump1418/health_details.txt
>
> pg active+degraded query:
> https://www.dropbox.com/s/46emswxd7s8xce1/pg_11.39_query.txt
> pg active+remapped query:
> https://www.dropbox.com/s/wij4uqh8qoz60fd/pg_16.2172_query.txt
>
> Please help - how can we fix it?
>
> --
> Pozdrawiam
> Dominik



-- 
Pozdrawiam
Dominik
