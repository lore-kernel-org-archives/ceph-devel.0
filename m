From: Sage Weil <sage@newdream.net>
Subject: Re: inconsistent pgs
Date: Mon, 10 Aug 2015 12:20:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508101219510.22099@cobra.newdream.net>
References: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com> <alpine.DEB.2.00.1508090712130.22099@cobra.newdream.net> <CAJnOFApACz47rukJpf50sY2hBvLoPM1+ZuSoTyaWXykxprrmtA@mail.gmail.com> <alpine.DEB.2.00.1508100531290.22099@cobra.newdream.net>
 <CAJnOFAqSX1UQ1iEFdHoNAoBXoxvRKOH60F1mPt-zR+w9veTSJQ@mail.gmail.com> <alpine.DEB.2.00.1508100641160.22099@cobra.newdream.net> <90559C83A9C7FA45B5846C975DFA612DDB53476094@ABGEX73E.FSC.NET>
 <CAJnOFArUmwW40=5-7HOF47y2JRcHPmLqyumt8G2h4ScyMhvPYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33696 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbbHJTUX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 15:20:23 -0400
In-Reply-To: <CAJnOFArUmwW40=5-7HOF47y2JRcHPmLqyumt8G2h4ScyMhvPYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?KOI8-R?B?68/O09TBztTJziDzwcjJzs/X?= <sakhinov@gmail.com>
Cc: =?ISO-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 10 Aug 2015, ?????????? ??????? wrote:
> Sage, Piotr, sorry for your time and thanx for your help.
> Memtest showed me red results. Will be digging for bad memory chips.

Thank you for following up, and relieved to hear we have a likely culprit.  
Good luck!

sage


> 
> Thanks again.
> 
> ??????? ??????????
> ???.: +7 (909) 945-89-42
> 
> 
> 2015-08-10 16:58 GMT+03:00 Da?ek, Piotr <Piotr.Dalek@ts.fujitsu.com>:
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> owner@vger.kernel.org] On Behalf Of Sage Weil
> >> Sent: Monday, August 10, 2015 3:52 PM
> >> To: ?????????? ???????
> >>
> >> On Mon, 10 Aug 2015, ?????????? ??????? wrote:
> >> > Uploaded another corrupted piece.
> >> >
> >> > 2015-08-10 16:18:40.027726 7f7979697700 -1 log_channel(cluster) log
> >> > [ERR] : be_compare_scrubmaps: 3.fd shard 6: soid
> >> > f2e832fd/rbd_data.ab7174b0dc51.0000000000000249/head//3 data_digest
> >> > 0x64e94460 != known data_digest 0xaec3bea8 from auth shard 10
> >> >
> >> > # ceph-post-file ceph-6-rbd_data.ab7174b0dc51.0000000000000249
> >> > ceph-post-file: e96e5828-b97c-45f1-8e3f-23abbf700865
> >> >
> >> > # ceph-post-file ceph-10-rbd_data.ab7174b0dc51.0000000000000249
> >> > ceph-post-file: e1277a33-74a5-4d46-93c8-266bd81867db
> >> >
> >> > I dont' think of bad disk:
> >> > - all OSDs SMART is clean,
> >> > - I tried to ceph pg repair 3.d8 on another OSDs in the past with the
> >> > same result. Then I rebalanced the cluster so that pg 3.d8 moved to
> >> > [7,1].
> >>
> >> Again, it's all single bit changes:
> >>
> >> [..]
> >>
> >> It looks like it's also always the least significant bit in a 4-byte word.
> >>
> >> Can you see if there is any pattern to which OSDs are used for the
> >> inconsistent PGs?
> >
> > I would check machines that host those PGs for memory errors, especially if they don't have ECC RAM sticks or ECC feature is disabled.
> > http://www.memtest.org/ is a good tool for this purpose.
> >
> > With best regards / Pozdrawiam
> > Piotr Da?ek
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
