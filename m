From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Thu, 14 Feb 2013 20:25:41 +0100
Message-ID: <511D3A35.7090702@mermaidconsulting.dk>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com>	<5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:52036 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932492Ab3BNTZs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 14:25:48 -0500
In-Reply-To: <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi Sage,

> block device level.  We plan to implement an incremental backup funct=
ion=20
> for the relative change between two snapshots (or a snapshot and the=20
> head).  It's O(n) the size of the device vs the number of files, but=20
> should be more efficient for all but the most sparse of images.  The=20
> implementation should be simple; the challenge is mostly around the=20
> incremental file format, probably.
> That doesn't help you now, but would be a relatively self-contained p=
iece=20
> of functionality for someone to contribute to RBD.  This isn't a top=20

I'm very interesting in having an incremental backup tool for Ceph, so=20
if it is possible for me to do, I would like to take a shot at=20
implementing it. It will be a spare time project, so I cannot say how=20
fast it will progress though.

If you have any details on how you would like to see the implementation=
=20
work, please let me know!


Thanks in advance,
--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
