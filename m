From: Jin Cai <caijin.laurence@gmail.com>
Subject: Re: Wrong crush map after all OSDs down
Date: Tue, 17 Jan 2017 12:07:27 +0800
Message-ID: <CAGRcXKY5vhcaThd7P398n51QE0iX2_4Q78LcbYy346xeRSXonQ@mail.gmail.com>
References: <CAGRcXKaE8LDzbAvwOBy1uWsaDRd_phOdA8Ek6NNMQ8spJvs_PA@mail.gmail.com>
 <CAC7t81bNHMryNxnKEos+-kPJ4aR-gwUynyqR-T1n6191qFcsVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:32852 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdAQEH2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2017 23:07:28 -0500
Received: by mail-ua0-f177.google.com with SMTP id i68so94699711uad.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2017 20:07:28 -0800 (PST)
In-Reply-To: <CAC7t81bNHMryNxnKEos+-kPJ4aR-gwUynyqR-T1n6191qFcsVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Sheplyakov <asheplyakov@mirantis.com>, ceph-devel@vger.kernel.org

> Hi,
>
> Actually down/slow OSDs are detected by other OSDs.  OSDs exchange
> heartbeats every few seconds.
> When an OSD haven't received a reply from its neighbor within the
> grace period (default: 20 seconds),
> the OSD (which has sent the heartbeat) considers its neighbor down and
> reports this to a monitor.
> After receiving 3 such messages in a row the monitor marks the OSD in
> question as down.
>
> Also OSDs report their status directly to monitors every few (~2)
> minutes (to avoid flooding monitors).
> If the monitor haven't received any status reports from an OSD within
> a grace period (~15 minutes)
> the OSD in question is considered down.
>
> If all OSDs are down there is no OSD which could have reported its
> neighbors are down. Thus monitor
> will consider all OSDs as up until the OSD report grace period (~15
> minutes) expires.

Yes, the expected behaviour should like this. But no matter how much
time it took, the monitor didn't mark these 'up' OSDs down.


>
> See http://docs.ceph.com/docs/giant/rados/configuration/mon-osd-interaction/#configuring-monitor-osd-interaction
> for more details.
>
> Best regards,
>      Alexey
>
>
> On Sat, Jan 14, 2017 at 7:59 PM, Jin Cai <caijin.laurence@gmail.com> wrote:
>> Hi all,
>> I deployed a ceph cluster with jewel in four physical machines.
>> Three physical machines were used for OSD and each of them had eight
>> OSDs. The left one was used to serve as a monitor.
>> At first, everything worked well.
>> By the reason of test, I stopped all the OSD daemon and double checked
>> no OSD process running.
>> After that, I executed ceph -s and got the following output:
>>  osdmap e164: 24 osds: 7 up, 7 in
>> No matter how much time elapsed, the output didn't change.
>>
>> The expected output should be:
>> osdmap e164: 24 osds: 0 up, 0 in
>>
>> I think it is the matter of synchronisation between OSDs and monitor
>> Would you like you explain this strange phenomenon for me.
>> Thanks a bunch in advance.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
