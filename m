From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Fixing NFS
Date: Mon, 7 Feb 2011 18:06:18 -0800
Message-ID: <AANLkTikPRdsNFBws2wY1ZnngOoKLndCYO6Y+N05v01OG@mail.gmail.com>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
	<Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
	<20110203175242.GA6348@dreamer>
	<AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44470 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1BHCHb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 21:07:31 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2A082C065
	for <ceph-devel@vger.kernel.org>; Mon,  7 Feb 2011 18:07:31 -0800 (PST)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id CAD3BC063
	for <ceph-devel@vger.kernel.org>; Mon,  7 Feb 2011 18:07:30 -0800 (PST)
Received: by eye27 with SMTP id 27so2732818eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Feb 2011 18:07:29 -0800 (PST)
In-Reply-To: <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 7, 2011 at 5:51 PM, Brian Chrisman <brchrisman@gmail.com> w=
rote:
> I was playing around with implementing this. =A0I was trying to get t=
he
> ceph client's export functions to return NFS4ERR_FHEXPIRED instead of
> ESTALE (hoping that my nfs4 clients would then attempt the full looku=
p
> again). =A0I noticed also that the mds itself can also return an ESTA=
LE
> to the ceph kernel client, which seems to be getting propagated back
> to the NFS client. =A0I'm wondering where I could intercept that and
> send back an expiry notice?
I don't think you want to: the MDS only returns ESTALE to the client
if it can't find the inode, but that can happen normally if
responsibility for the inode has been moved to another MDS. The client
should be able to handle this circumstance and from a quick check
that's the only way you're going to get ESTALE back from the MDS
(unless something is horribly broken).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
