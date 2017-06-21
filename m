From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [ceph-users] Sparse file info in filestore not propagated to
 other OSDs
Date: Wed, 21 Jun 2017 09:35:44 -0400
Message-ID: <CA+aFP1DJ3L3Pg0r4Pj3o7JoNTNnBRRs0u_nnb2JYz4nGxafUTA@mail.gmail.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal> <d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
 <415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl> <alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
 <e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33133 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFUNfq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 09:35:46 -0400
Received: by mail-yw0-f175.google.com with SMTP id 63so64398169ywr.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 06:35:46 -0700 (PDT)
In-Reply-To: <e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: Sage Weil <sage@newdream.net>, =?UTF-8?Q?Pawe=C5=82_Sadowski?= <ceph@sadziu.pl>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Wed, Jun 21, 2017 at 3:05 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> I saw that RBD (librbd) does that - replacing writes with discards when
> buffer contains only zeros. Some code that does the same in librados could
> be added and it shouldn't impact performance much, current implementation of
> mem_is_zero is fast and shouldn't be a big problem.

I'm pretty sure the only place where librbd converts a write to a
discard is actually the specialized "writesame" operation used by
tcmu-runner, as an optimization for ESX's initialization of a new
image.

-- 
Jason
