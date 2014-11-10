From: GuangYang <yguang11@outlook.com>
Subject: RE: PG inconsistency
Date: Mon, 10 Nov 2014 03:25:55 +0000
Message-ID: <BLU175-W4789CCDB578B9A70E1CC8ADF800@phx.gbl>
References: <BLU175-W41E1F32E90ED411A4477FFDF840@phx.gbl>,<alpine.DEB.2.00.1411070213510.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc2s25.hotmail.com ([65.55.111.100]:52275 "EHLO
	BLU004-OMC2S25.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059AbaKJDZ4 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 9 Nov 2014 22:25:56 -0500
In-Reply-To: <alpine.DEB.2.00.1411070213510.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Thanks Sage!

----------------------------------------
> Date: Fri, 7 Nov 2014 02:19:06 -0800
> From: sage@newdream.net
> To: yguang11@outlook.com
> CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> Subject: Re: PG inconsistency
>
> On Thu, 6 Nov 2014, GuangYang wrote:
>> Hello Cephers,
>> Recently we observed a couple of inconsistencies in our Ceph cluster=
,
>> there were two major patterns leading to inconsistency as I observed=
: 1)
>> EIO to read the file, 2) the digest is inconsistent (for EC) even th=
ere
>> is no read error).
>>
>> While ceph has built-in tool sets to repair the inconsistencies, I a=
lso
>> would like to check with the community in terms of what is the best =
ways
>> to handle such issues (e.g. should we run fsck / xfs_repair when suc=
h
>> issue happens).
>>
>> In more details, I have the following questions:
>> 1. When there is inconsistency detected, what is the chance there is
>> some hardware issues which need to be repaired physically, or should=
 I
>> run some disk/filesystem tools to further check?
>
> I'm not really an operator so I'm not as familiar with these tools as=
 I
> should be :(, but I suspect the prodent route is to check the SMART i=
nfo
> on the disk, and/or trigger a scrub of everything else on the OSD (ce=
ph
> osd scrub N). For DreamObjects, I think they usually just fail the OS=
D
> once it starts throwing bad sectors (most of the hardware is already
> reasonably aged).
Google's data also shows the strong correlation between scrub error (es=
pecially several SMART parameters) and disk failure - https://www.useni=
x.org/legacy/event/fast07/tech/full_papers/pinheiro/pinheiro.pdf.
>
>> 2. Should we use fsck / xfs_repair to fix the inconsistencies, or sh=
ould
>> we solely relay on Ceph's repair tool sets?
>
> That might not be a bad idea, but I would urge caution if xfs_repair =
finds
> any issues or makes any changes, as subtle changes to the fs contents=
 can
> confuse ceph-osd. At an absolute minimum, do a full scrub after, but
> even better would be to fail the OSD.
>
> (FWIW I think we should document a recommended "safe" process for
> failing/replacing an OSD that takes the suspect data offline but wait=
s for
> the cluster to heal before destroying any data. Simply marking the OS=
D
> out will work, but then when a fresh drive is added there will be a s=
econd
> repair/rebalance event, which isn't ideal.)
Yeah that would be very helpful, I think the first decision to make is =
to whether should we replace the disk, in our clusters, there is data c=
orruption (EIO) along with SMART warnings, which is an indicator of bad=
 disk, meanwhile, we also observed xattr is lost (http://tracker.ceph.c=
om/issues/10018) without any SMART warnings, after talking to Sam, we s=
uspected it might be due to unexpected host rebooting (or mis-configure=
d RAID controller), in which case we properly no need to replace the di=
sk but only repair by ceph.

In terms of disk replacement, to avoid migrating data back and forth, a=
re the below two approaches reasonable?
=A01. Keep the OSD in and do an ad-hoc disk replacement and provision a=
 new OSD (so that keep the OSD id as the same), and then trigger data m=
igration. In this way the data migration only happens once, however, it=
 does require operators to replace the disk very fast.
=A02. Move the data on the broken disk to a new disk completely and use=
 Ceph to repair bad objects.

Thanks,
Guang

>
> sage
>
>>
>> It would be great to hear you experience and suggestions.
>>
>> BTW, we are using XFS in the cluster.
>>
>> Thanks,
>> Guang N????y????b?????v?????{.n??????z??ay????????j=07???f??????????=
??????:+v????????=07??zZ+??????"?!?
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
