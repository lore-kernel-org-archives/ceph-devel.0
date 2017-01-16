From: Alexey Sheplyakov <asheplyakov@mirantis.com>
Subject: Re: Wrong crush map after all OSDs down
Date: Mon, 16 Jan 2017 13:15:11 +0400
Message-ID: <CAC7t81bNHMryNxnKEos+-kPJ4aR-gwUynyqR-T1n6191qFcsVA@mail.gmail.com>
References: <CAGRcXKaE8LDzbAvwOBy1uWsaDRd_phOdA8Ek6NNMQ8spJvs_PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36346 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdAPJPM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2017 04:15:12 -0500
Received: by mail-yw0-f177.google.com with SMTP id a10so64911089ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2017 01:15:12 -0800 (PST)
In-Reply-To: <CAGRcXKaE8LDzbAvwOBy1uWsaDRd_phOdA8Ek6NNMQ8spJvs_PA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jin Cai <caijin.laurence@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Actually down/slow OSDs are detected by other OSDs.  OSDs exchange
heartbeats every few seconds.
When an OSD haven't received a reply from its neighbor within the
grace period (default: 20 seconds),
the OSD (which has sent the heartbeat) considers its neighbor down and
reports this to a monitor.
After receiving 3 such messages in a row the monitor marks the OSD in
question as down.

Also OSDs report their status directly to monitors every few (~2)
minutes (to avoid flooding monitors).
If the monitor haven't received any status reports from an OSD within
a grace period (~15 minutes)
the OSD in question is considered down.

If all OSDs are down there is no OSD which could have reported its
neighbors are down. Thus monitor
will consider all OSDs as up until the OSD report grace period (~15
minutes) expires.

See http://docs.ceph.com/docs/giant/rados/configuration/mon-osd-interaction/#configuring-monitor-osd-interaction
for more details.

Best regards,
     Alexey


On Sat, Jan 14, 2017 at 7:59 PM, Jin Cai <caijin.laurence@gmail.com> wrote:
> Hi all,
> I deployed a ceph cluster with jewel in four physical machines.
> Three physical machines were used for OSD and each of them had eight
> OSDs. The left one was used to serve as a monitor.
> At first, everything worked well.
> By the reason of test, I stopped all the OSD daemon and double checked
> no OSD process running.
> After that, I executed ceph -s and got the following output:
>  osdmap e164: 24 osds: 7 up, 7 in
> No matter how much time elapsed, the output didn't change.
>
> The expected output should be:
> osdmap e164: 24 osds: 0 up, 0 in
>
> I think it is the matter of synchronisation between OSDs and monitor
> Would you like you explain this strange phenomenon for me.
> Thanks a bunch in advance.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
