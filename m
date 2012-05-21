From: Felix Feinhals <ff@turtle-entertainment.de>
Subject: Re: MDS crash, wont startup again
Date: Mon, 21 May 2012 14:38:20 +0200
Message-ID: <CA+WUqKz5HQ77p7TYxJhiOPfY6Tm+12O+FRFr19ra6t9bZb6YSg@mail.gmail.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
 <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com> <4FB56FD1.5090805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39040 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754611Ab2EUMim (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 May 2012 08:38:42 -0400
Received: by lahd3 with SMTP id d3so3421450lah.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 05:38:41 -0700 (PDT)
In-Reply-To: <4FB56FD1.5090805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Josh,

i quoted the trace and some other stats in my first email, maybe it
got stuck in the spam filters.
Well next try:

snip

-3> 2012-05-10 14:52:29.509940 7fb1c9351700 1 mds.0.40 handle_mds_map
 i am now mds.0.40
 -2> 2012-05-10 14:52:29.509956 7fb1c9351700 1 mds.0.40 handle_mds_map
 state change up:reconnect --> up:rejoin
 -1> 2012-05-10 14:52:29.509963 7fb1c9351700 1 mds.0.40 rejoin_joint_start
 0> 2012-05-10 14:52:29.512503 7fb1c9351700 -1 *** Caught signal
 (Segmentation fault) **
 in thread 7fb1c9351700

ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
 1: ceph-mds() [0x814279]
 2: (()+0xeff0) [0x7fb1cddbfff0]
 3: (SnapRealm::have_past_parents_open(snapid_t, snapid_t)+0x4f) [0x6cb5ef]
 4: (MDCache::check_realm_past_parents(SnapRealm*)+0x2b) [0x55d58b]
 5: (MDCache::choose_lock_states_and_reconnect_caps()+0x29c) [0x572eec]
 6: (MDCache::rejoin_gather_finish()+0x90) [0x5931a0]
 7: (MDCache::rejoin_send_rejoins()+0x2c05) [0x59b9d5]
 8: (MDS::rejoin_joint_start()+0x131) [0x4a8721]
 9: (MDS::handle_mds_map(MMDSMap*)+0x2c4a) [0x4c253a]
 10: (MDS::handle_core_message(Message*)+0x913) [0x4c4513]
 11: (MDS::_dispatch(Message*)+0x2f) [0x4c45ef]
 12: (MDS::ms_dispatch(Message*)+0x1fb) [0x4c628b]
 13: (SimpleMessenger::dispatch_entry()+0x979) [0x7acb49]
 14: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7336ed]
 15: (()+0x68ca) [0x7fb1cddb78ca]
 16: (clone()+0x6d) [0x7fb1cc63f92d]

snip

I though ceph chooses which MDS is active and which is standby, i just
have 3 in the cluster config:

[mds.a]
host = x

[mds.b]
host = y

[mds.c]
host = z

no global MDS config.
Should i reconfigure this?



2012/5/17 Josh Durgin <josh.durgin@inktank.com>:
> On 05/16/2012 01:11 AM, Felix Feinhals wrote:
>>
>> Hi again,
>>
>> anything on this Problem? Seems that the only choice for me is to
>> reinitialize the whole cephfs (mkcephfs...)
>> :(
>
>
> Hi Felix, it looks like your first mail never reached the list.
>
>
>> 2012/5/10 Felix Feinhals<ff@turtle-entertainment.de>:
>>>
>>> Hi List,
>>>
>>> we installed a ceph cluster with ceph version 0.46.
>>> 3 OSDs, 3 MONs and 3 MDSs.
>>>
>>> After copying a bunch of files to a ceph-fuse mount all MDS daemons
>>> crash and now i cant bring them back online.
>>> I already tried to restart the daemons in different order and also
>>> removed one OSD, nothing really happened only now we have pgs with
>>> active+remapped which i think is normal.
>>> Any hints?
>
>
> Are all three MDS active? At this point, more than one active MDS is
> likely to crash. You can have one active and others standby.
>
> If you've got only one active, what was the backtrace of the crash?
> It'll be at the end of the MDS log (by default in /var/log/ceph).
