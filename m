From: Andreas Grimm <agrimm61@gmail.com>
Subject: Re: RBD/OSD questions
Date: Fri, 7 May 2010 18:38:28 +0200
Message-ID: <v2vcf40c6a91005070938y85d18ec2wa5a579944841511f@mail.gmail.com>
References: <784866.39317.qm@web36101.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.1005061517070.18563@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:53849 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0EGQib convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 May 2010 12:38:31 -0400
Received: by fg-out-1718.google.com with SMTP id d23so819321fga.1
        for <ceph-devel@vger.kernel.org>; Fri, 07 May 2010 09:38:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1005061517070.18563@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

That sounds promising. I have another question about the OSDs.
=46ollowing scenario:

I have a couple servers with each having six disks. My idea is to
start an osd for every single disk on each server.
Will Ceph place the replicas on different hosts by design, or can i
solve this via a crush map?

Just a short question on terminus: what is a RBD (something about rados=
?)?

Thanks
Andreas

> The image is striped over objects, _then_ the objects are replicated
> across OSDs. =A0Objects themselves aren't striped.
>
> For example, if an image is striped over objects A B C D E F, each 4M=
B,
> you might end up with
>
> osd0: A =A0B' C =A0D =A0E' F'
> osd1: A' B =A0C' D' E =A0F
>
> where A is the primary copy, A' is the replica, etc.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
