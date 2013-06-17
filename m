From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 2/2] Enable fscache as an optional feature of ceph.
Date: Mon, 17 Jun 2013 12:00:57 -0400
Message-ID: <CANP1eJGxbfdYhJcwz5uPWdQWTWMhHcueQcuhh3kQduyB5Y+ULg@mail.gmail.com>
References: <CANP1eJHwS2gjP=adgr-iJz3pw4LvZMs7PKDqrkTM2c4OimEeTg@mail.gmail.com>
	<alpine.DEB.2.00.1305281010270.16097@cobra.newdream.net>
	<CANP1eJGsCZcR00Bfbfswsfpz9gabXL57smTU3++QZdn_grQ7MA@mail.gmail.com>
	<CAKxz0mzP8p94hMc0RTzaa_gA-PwCoWFUkTba9zNc65+A6VEtLQ@mail.gmail.com>
	<CANP1eJHZskoMVa3KBGMHvxEfNcAJQdDK4ou47meaBDYzPVa=xg@mail.gmail.com>
	<CAKxz0mxQzYOk0uazXc9KjT1yr=-fk3YCprATChBPeqtv62_gug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36238 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3FQQA5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jun 2013 12:00:57 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so7397648iea.18
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jun 2013 09:00:57 -0700 (PDT)
In-Reply-To: <CAKxz0mxQzYOk0uazXc9KjT1yr=-fk3YCprATChBPeqtv62_gug@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elso Andras <elso.andras@gmail.com>
Cc: ceph-devel@vger.kernel.org

Elbandi,

It looks like it's trying to use fscache (from the stats) but there's
no data. Did you install, configure and enable the cachefilesd daemon?
It's the user-space component of fscache. It's the only officially
supported fsache backed by Ubuntu, RHEL & SUSE. I'm guessing that's
your problem since I don't see any of the bellow lines in your dmesg
snippet.

[2049099.198234] CacheFiles: Loaded
[2049099.541721] FS-Cache: Cache "mycache" added (type cachefiles)
[2049099.541727] CacheFiles: File cache on md0 registered

- Milosz

On Mon, Jun 17, 2013 at 11:47 AM, Elso Andras <elso.andras@gmail.com> wrote:
> Hi,
>
>
>> 1) In the graphs you attached what am I looking at? My best guess is that
>> it's traffic on a 10gigE card, but I can't tell from the graph since there's
>> no labels.
> Yes, 10G traffic on switch port. So "incoming" means server-to-switch,
> "outgoing" means switch-to-server. No separated card for ceph traffic
> :(
>
>> 2) Can you give me more info about your serving case. What application are
>> you using to serve the video (http server)? Are you serving static mp4 files
>> from Ceph filesystem?
> lighttpd server with mp4 streaming mod
> (http://h264.code-shop.com/trac/wiki/Mod-H264-Streaming-Lighttpd-Version2),
> the files lives on cephfs.
> there is a speed limit, controlled by mp4 mod. the bandwidth is the
> video bitrate value.
>
> mount options:
> name=test,rsize=0,rasize=131072,noshare,fsc,key=client.test
>
> rsize=0 and rasize=131072 is a tested, with other values there was 4x
> incoming (from osd) traffic than outgoing (to internet) traffic.
>
>> 3) What's the hardware, most importantly how big is your partition that
>> cachefilesd is on and what kind of disk are you hosting it on (rotating,
>> SSD)?
> there are 5 osd servers: HP DL380 G6, 32G ram, 16 X HP sas disk (10k
> rpm) with raid0. bonding two 1G interface together.
> (In previous life, this hw could serve the ~2.3G traffic with raid5
> and three bonding interface)
>
>> 4) Statistics from fscache. Can you paste the output /proc/fs/fscache/stats
>> and /proc/fs/fscache/histogram.
>
> FS-Cache statistics
> Cookies: idx=1 dat=8001 spc=0
> Objects: alc=0 nal=0 avl=0 ded=0
> ChkAux : non=0 ok=0 upd=0 obs=0
> Pages  : mrk=0 unc=0
> Acquire: n=8002 nul=0 noc=0 ok=8002 nbf=0 oom=0
> Lookups: n=0 neg=0 pos=0 crt=0 tmo=0
> Invals : n=0 run=0
> Updates: n=0 nul=0 run=0
> Relinqs: n=2265 nul=0 wcr=0 rtr=0
> AttrChg: n=0 ok=0 nbf=0 oom=0 run=0
> Allocs : n=0 ok=0 wt=0 nbf=0 int=0
> Allocs : ops=0 owt=0 abt=0
> Retrvls: n=2983745 ok=0 wt=0 nod=0 nbf=2983745 int=0 oom=0
> Retrvls: ops=0 owt=0 abt=0
> Stores : n=0 ok=0 agn=0 nbf=0 oom=0
> Stores : ops=0 run=0 pgs=0 rxd=0 olm=0
> VmScan : nos=0 gon=0 bsy=0 can=0 wt=0
> Ops    : pend=0 run=0 enq=0 can=0 rej=0
> Ops    : dfr=0 rel=0 gc=0
> CacheOp: alo=0 luo=0 luc=0 gro=0
> CacheOp: inv=0 upo=0 dro=0 pto=0 atc=0 syn=0
> CacheOp: rap=0 ras=0 alp=0 als=0 wrp=0 ucp=0 dsp=0
>
> No histogram, i try to build to enable this.
>
>> 5) dmesg lines for ceph/fscache/cachefiles like:
> [  264.186887] FS-Cache: Loaded
> [  264.223851] Key type ceph registered
> [  264.223902] libceph: loaded (mon/osd proto 15/24)
> [  264.246334] FS-Cache: Netfs 'ceph' registered for caching
> [  264.246341] ceph: loaded (mds proto 32)
> [  264.249497] libceph: client31274 fsid 1d78ebe5-f254-44ff-81c1-f641bb2036b6
>
>
> Elbandi
