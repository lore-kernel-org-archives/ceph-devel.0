From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: ceph status reporting non-existing osd
Date: Sat, 14 Jul 2012 18:20:26 +0400
Message-ID: <CABYiri9wEoPs87qUr2MANX_AHB-aHprJBdXV0o4TxeDPj6SrhQ@mail.gmail.com>
References: <4FFFD9AB.40608@xdel.ru> <CAPYLRzgOHf9nMdK5oOrs6++H22iFLYvcbhMQsZtd8Z3OskX=yw@mail.gmail.com>
 <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40191 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2GNOUr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 10:20:47 -0400
Received: by wibhm11 with SMTP id hm11so1466405wib.1
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jul 2012 07:20:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207131009280.9771@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Fri, Jul 13, 2012 at 9:09 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 13 Jul 2012, Gregory Farnum wrote:
>> On Fri, Jul 13, 2012 at 1:17 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> > Hi,
>> >
>> > Recently I`ve reduced my test suite from 6 to 4 osds at ~60% usage on
>> > six-node,
>> > and I have removed a bunch of rbd objects during recovery to avoid
>> > overfill.
>> > Right now I`m constantly receiving a warn about nearfull state on
>> > non-existing osd:
>> >
>> >    health HEALTH_WARN 1 near full osd(s)
>> >    monmap e3: 3 mons at
>> > {0=192.168.10.129:6789/0,1=192.168.10.128:6789/0,2=192.168.10.127:6789/0},
>> > election epoch 240, quorum 0,1,2 0,1,2
>> >    osdmap e2098: 4 osds: 4 up, 4 in
>> >     pgmap v518696: 464 pgs: 464 active+clean; 61070 MB data, 181 GB
>> > used, 143 GB / 324 GB avail
>> >    mdsmap e181: 1/1/1 up {0=a=up:active}
>> >
>> > HEALTH_WARN 1 near full osd(s)
>> > osd.4 is near full at 89%
>> >
>> > Needless to say, osd.4 remains only in ceph.conf, but not at crushmap.
>> > Reducing has been done 'on-line', e.g. without restart entire cluster.
>>
>> Whoops! It looks like Sage has written some patches to fix this, but
>> for now you should be good if you just update your ratios to a larger
>> number, and then bring them back down again. :)
>
> Restarting ceph-mon should also do the trick.
>
> Thanks for the bug report!
> sage

Should I restart mons simultaneously? Restarting one by one has no
effect, same as filling up data pool up to ~95 percent(btw, when I
deleted this 50Gb file on cephfs, mds was stuck permanently and usage
remained same until I dropped and recreated data pool - hope it`s one
of known posix layer bugs). I also deleted entry from config, and then
restarted mons, with no effect. Any suggestions?
