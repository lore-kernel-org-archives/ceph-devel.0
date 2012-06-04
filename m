From: Greg Farnum <greg@inktank.com>
Subject: Re: MDS crash, wont startup again
Date: Mon, 4 Jun 2012 12:49:31 -0700
Message-ID: <E9C862B1497248E6AFDD2B067DA1C2E9@inktank.com>
References: <CA+WUqKxZoh_5k5qgtUFwnsr2=gaZ4_RONazYQG7enKa75WhNVQ@mail.gmail.com>
 <CA+WUqKyFusqxiPkPvQeSaP_nPBd5_ab4nLz1xWeOZZqMLk1SBA@mail.gmail.com>
 <4FB56FD1.5090805@inktank.com>
 <CA+WUqKz5HQ77p7TYxJhiOPfY6Tm+12O+FRFr19ra6t9bZb6YSg@mail.gmail.com>
 <CAPYLRzjTs19air=7cT3PGSWiHGFUyKuTeX9OHzTBfBPyMXan+g@mail.gmail.com>
 <CA+WUqKyH6bro4u-PXoKC0WEi37bn85YaG8jxi9SZ+fvpZFx--g@mail.gmail.com>
 <DF93AE65E2C74807A83392C93D9EDA0B@inktank.com>
 <CA+WUqKy2DrEM90HrSF8ju68gjLhVv3TWEFTb68fi+5GpifOLTg@mail.gmail.com>
 <CAPYLRzhGQscvJ1g73OwJ8ENKog-CtMp03a3LtB2e+bXSD0Eecg@mail.gmail.com>
 <CA+WUqKxKPTArjxy-sceuAy9eN7mQJ=jU-9_dRQuQAbUd-4aFHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52880 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2FDTte convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 15:49:34 -0400
Received: by pbbrp8 with SMTP id rp8so6435450pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 12:49:33 -0700 (PDT)
In-Reply-To: <CA+WUqKxKPTArjxy-sceuAy9eN7mQJ=jU-9_dRQuQAbUd-4aFHQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Felix Feinhals <ff@turtle-entertainment.de>
Cc: ceph-devel@vger.kernel.org

On Thursday, May 24, 2012 at 5:29 AM, Felix Feinhals wrote:
> Hi,
> =20
> i was using the Debian Packages, but i tried now from source.
> I used the same version from GIT
> (cb7f1c9c7520848b0899b26440ac34a8acea58d1) and compiled it. Same cras=
h
> report.
> Then i applied your patch but again the same crash, i think the
> backtrace is also the same:
> =20
> (gdb) thread 1
> [Switching to thread 1 (Thread 9564)]#0 0x00007f33a3e58ebb in raise
> (sig=3D<value optimized out>)
> at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
> 41 in ../nptl/sysdeps/unix/sysv/linux/pt-raise.c
> (gdb) backtrace
> #0 0x00007f33a3e58ebb in raise (sig=3D<value optimized out>)
> at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
> #1 0x000000000081423e in reraise_fatal (signum=3D11) at
> global/signal_handler.cc:58 (http://signal_handler.cc:58)
> #2 handle_fatal_signal (signum=3D11) at global/signal_handler.cc:104 =
(http://signal_handler.cc:104)
> #3 <signal handler called>
> #4 SnapRealm::have_past_parents_open (this=3D0x0, first=3D..., last=3D=
=2E..)
> at mds/snap.cc:112 (http://snap.cc:112)
> #5 0x000000000055d58b in MDCache::check_realm_past_parents
> (this=3D0x27a7200, realm=3D0x0)
> at mds/MDCache.cc:4495 (http://MDCache.cc:4495)
> #6 0x0000000000572eec in
> MDCache::choose_lock_states_and_reconnect_caps (this=3D0x27a7200)
> at mds/MDCache.cc:4533 (http://MDCache.cc:4533)
> #7 0x00000000005931a0 in MDCache::rejoin_gather_finish
> (this=3D0x27a7200) at mds/MDCache.cc:4444 (http://MDCache.cc:4444)
> #8 0x000000000059b9d5 in MDCache::rejoin_send_rejoins
> (this=3D0x27a7200) at mds/MDCache.cc:3388 (http://MDCache.cc:3388)
> #9 0x00000000004a8721 in MDS::rejoin_joint_start (this=3D0x27bc000) a=
t
> mds/MDS.cc:1404 (http://MDS.cc:1404)
> #10 0x00000000004c253a in MDS::handle_mds_map (this=3D0x27bc000,
> m=3D<value optimized out>)
> at mds/MDS.cc:968 (http://MDS.cc:968)
> #11 0x00000000004c4513 in MDS::handle_core_message (this=3D0x27bc000,
> m=3D0x27ab800) at mds/MDS.cc:1651 (http://MDS.cc:1651)
> #12 0x00000000004c45ef in MDS::_dispatch (this=3D0x27bc000, m=3D0x27a=
b800)
> at mds/MDS.cc:1790 (http://MDS.cc:1790)
> #13 0x00000000004c628b in MDS::ms_dispatch (this=3D0x27bc000,
> m=3D0x27ab800) at mds/MDS.cc:1602 (http://MDS.cc:1602)
> #14 0x0000000000732609 in Messenger::ms_deliver_dispatch
> (this=3D0x279f680) at msg/Messenger.h:178
> #15 SimpleMessenger::dispatch_entry (this=3D0x279f680) at
> msg/SimpleMessenger.cc:363 (http://SimpleMessenger.cc:363)
> #16 0x00000000007207ad in SimpleMessenger::DispatchThread::entry() ()
> #17 0x00007f33a3e508ca in start_thread (arg=3D<value optimized out>) =
at
> pthread_create.c:300
> #18 0x00007f33a26d892d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> #19 0x0000000000000000 in ?? ()
> =20
> Any more ideas? :)
> Or can i get you more debugging output?

Sorry for the delay =E2=80=94 I'm afraid that's a hazard of using the M=
DS before we're ready to support it. :(
Anyway, I haven't had a lot of time to look into this, but that makes i=
t look like there's an actual problem, where one of the inodes can't fi=
nd the "SnapRealm" which it lives in. Things that will make this easier=
 to diagnose (in the event that somebody gets the time) include generat=
ing high-level debug logs and placing them somewhere accessible (start =
up the MDS with "debug mds =3D 20" added to the config file); if you wa=
nt you could also try the below patch (which will cause the MDS to dump=
 its full inode cache upon triggering this bug) and we can see if there=
's anything really obvious.
(This is a fine thing to make bug reports on at tracker.newdream.net, b=
tw =E2=80=94 and that allows attachments of things like log files.)
-Greg

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 143faca..6aa5923 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4527,6 +4527,11 @@ void MDCache::choose_lock_states_and_reconnect_c=
aps()
dout(15) << " chose lock states on " << *in << dendl;

SnapRealm *realm =3D in->find_snaprealm();
+ if (!realm) {
+ dout(0) << "serious error, could not find snaprealm for in " << *in
+ << ", triggering cache dump" << dendl;
+ dump_cache();
+ }

check_realm_past_parents(realm);



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
