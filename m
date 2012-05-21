From: Gregory Farnum <greg@inktank.com>
Subject: Re: MDS crash, wont startup again
Date: Mon, 21 May 2012 11:44:40 -0700
Message-ID: <CAPYLRzjTs19air=7cT3PGSWiHGFUyKuTeX9OHzTBfBPyMXan+g@mail.gmail.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
	<CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
	<4FB56FD1.5090805@inktank.com>
	<CA+WUqKz5HQ77p7TYxJhiOPfY6Tm+12O+FRFr19ra6t9bZb6YSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43478 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2EUSom convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 14:44:42 -0400
Received: by lbbgm6 with SMTP id gm6so3687516lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 11:44:40 -0700 (PDT)
In-Reply-To: <CA+WUqKz5HQ77p7TYxJhiOPfY6Tm+12O+FRFr19ra6t9bZb6YSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Felix Feinhals <ff@turtle-entertainment.de>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Mon, May 21, 2012 at 5:38 AM, Felix Feinhals
<ff@turtle-entertainment.de> wrote:
> Hi Josh,
>
> i quoted the trace and some other stats in my first email, maybe it
> got stuck in the spam filters.
> Well next try:
>
> snip
>
> -3> 2012-05-10 14:52:29.509940 7fb1c9351700 1 mds.0.40 handle_mds_map
> =A0i am now mds.0.40
> =A0-2> 2012-05-10 14:52:29.509956 7fb1c9351700 1 mds.0.40 handle_mds_=
map
> =A0state change up:reconnect --> up:rejoin
> =A0-1> 2012-05-10 14:52:29.509963 7fb1c9351700 1 mds.0.40 rejoin_join=
t_start
> =A00> 2012-05-10 14:52:29.512503 7fb1c9351700 -1 *** Caught signal
> =A0(Segmentation fault) **
> =A0in thread 7fb1c9351700
>
> ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
> =A01: ceph-mds() [0x814279]
> =A02: (()+0xeff0) [0x7fb1cddbfff0]
> =A03: (SnapRealm::have_past_parents_open(snapid_t, snapid_t)+0x4f) [0=
x6cb5ef]
> =A04: (MDCache::check_realm_past_parents(SnapRealm*)+0x2b) [0x55d58b]
> =A05: (MDCache::choose_lock_states_and_reconnect_caps()+0x29c) [0x572=
eec]
> =A06: (MDCache::rejoin_gather_finish()+0x90) [0x5931a0]
> =A07: (MDCache::rejoin_send_rejoins()+0x2c05) [0x59b9d5]
> =A08: (MDS::rejoin_joint_start()+0x131) [0x4a8721]
> =A09: (MDS::handle_mds_map(MMDSMap*)+0x2c4a) [0x4c253a]
> =A010: (MDS::handle_core_message(Message*)+0x913) [0x4c4513]
> =A011: (MDS::_dispatch(Message*)+0x2f) [0x4c45ef]
> =A012: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c628b]
> =A013: (SimpleMessenger::dispatch_entry()+0x979) [0x7acb49]
> =A014: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7336ed]
> =A015: (()+0x68ca) [0x7fb1cddb78ca]
> =A016: (clone()+0x6d) [0x7fb1cc63f92d]

There's nothing obvious here =97 can you run gdb on the core and get
another backtrace and the info from levels 3-5?

> snip
>
> I though ceph chooses which MDS is active and which is standby, i jus=
t
> have 3 in the cluster config:
Yes, it does =97=A0if you don't increase the number of allowed MDSes
you'll just get one of them active.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
