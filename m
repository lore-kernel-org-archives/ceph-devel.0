From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: assert in can_discard_replica_op
Date: Wed, 16 Aug 2017 15:54:24 -0700
Message-ID: <CAJ4mKGZ7XOTUX4yzhEqv0eejyMox_2MDAcjEzqcnk3AOrz_eAg@mail.gmail.com>
References: <CAB7xdikmXB_r=YS_FSKe7yUrUpPBf6Eej5025rVYNeYgg-LciQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:38813 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbdHPWyZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 18:54:25 -0400
Received: by mail-io0-f172.google.com with SMTP id g71so17912053ioe.5
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 15:54:25 -0700 (PDT)
In-Reply-To: <CAB7xdikmXB_r=YS_FSKe7yUrUpPBf6Eej5025rVYNeYgg-LciQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 15, 2017 at 5:42 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi,
>
> recently, we got an assert in function can_discard_replica_op() when
> osd is handling replica op reply. The assert is caused by
> get_down_at() which checks if the source osd is still exists(),
> otherwise it assert.
>
> seems in our testing environment, the source osd send an op reply to
> primary osd and then died.
>
> My question should we first check exists() and avoid the assert happen
> in get_down_at() or it's expected to be always exists() at this
> situation.

An OSD existing is just making sure it is in the OSDMap at all (it
doesn't need to be up or in). If you've managed to get an OSD sending
ops during an epoch where it doesn't exist, something has gone
terribly wrong — the local assert is not the problem! We can follow-up
on the assert at the ticket you made
(http://tracker.ceph.com/issues/21006).
-Greg
