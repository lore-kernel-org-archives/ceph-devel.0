From: Kostas Liakakis <koukou73gr@gmail.com>
Subject: Re: Not starting a OSD journal
Date: Mon, 30 Jan 2017 11:17:50 +0200
Message-ID: <3e65b463-494b-4609-306e-6851d1c19b2e@gmail.com>
References: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
 <351131ca-d626-3bba-833b-c3281a5b25e1@suse.cz>
 <611a59a0-3511-079b-e2a3-691342234510@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32978 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdA3JRy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2017 04:17:54 -0500
Received: by mail-wm0-f49.google.com with SMTP id t18so8609916wmt.0
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2017 01:17:53 -0800 (PST)
Received: from [192.168.1.67] (adsl-52.176.58.239.tellas.gr. [176.58.239.52])
        by smtp.googlemail.com with ESMTPSA id y97sm17735453wmh.24.2017.01.30.01.17.51
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2017 01:17:51 -0800 (PST)
In-Reply-To: <611a59a0-3511-079b-e2a3-691342234510@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-01-29 22:09, Willem Jan Withagen wrote:
> The disadvantage is that there will be a double write per original writ=
e:
>  (ceph) first write is to the journal-file
>     (zfs) write is stored in the write queue
>     (zfs) write to ZIL(ssd) if write is synced write
>     (zfs) async write to disk when write slot is available
>  (ceph) read from zfs-store,
>     (zfs) delivers data either arc(ram) or l2arc(ssd) or HD
>  (ceph) writes data to filestore.
>     (zfs) write is stored in the write queue
>     (zfs) write to ZIL(ssd) if write is synced write
>     (zfs) async write to disk when write slot is available
>
> And I hoped to forgo the Ceph journal write/read cycle.
You've got a slight misconception there, not that it matters much to
your problem.

A Ceph OSD will never read its journal under normal operation. OSD will
only commit data to the journal before it commits them to its filestore.
The journal is only replayed after an OSD crash or otherwise abnormal
termination.

The way Ceph OSDs w/ filestore has been put in place I don't think there
is a way to fully utilize zfs features.

-K.

