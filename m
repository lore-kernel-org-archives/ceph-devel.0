From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: Fixing NFS
Date: Thu, 10 Feb 2011 10:52:04 -0800
Message-ID: <AANLkTikwSntg4R2tZ5wME-M7ZKXT0SXjZK28Dxci7D-f@mail.gmail.com>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
	<Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
	<20110203175242.GA6348@dreamer>
	<AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
	<Pine.LNX.4.64.1102071931140.16784@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47844 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab1BJSwF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Feb 2011 13:52:05 -0500
Received: by vxb37 with SMTP id 37so881326vxb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Feb 2011 10:52:04 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102071931140.16784@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 7, 2011 at 7:33 PM, Sage Weil <sage@newdream.net> wrote:
=2E..
>
> I believe the only place an actual MDS call is exposed to an NFS expo=
rt is
> in export.c's __cfh_to_dentry(). =A0This is where the ino search is g=
oing to
> need to get more sophisticated (at least on the client side).
>
> An ESTALE from the MDS generally means the starting ino in the reques=
t
> isn't in the cache. =A0You can try all MDSs for one that has it. =A0B=
eyond
> that, we'll need to implement more smarts on the server side!
>
> sage
>

With further testing, I tracked this down to ESTALEs indeed being
returned from __cfh_to_dentry().
I'm guessing this is because it has been flushed from the MDS cache,
as my max mds is 1 and it hasn't failed/migrated.

It looks like CEPH_MDS_OP_LOOKUPHASH is failing to find the dentry...
I was hoping to see how the rest of the kernel client implements
lookup when LOOKUPHASH fails, but it looks like only export.c is using
that operation.  Is it possible to perform a full lookup (past the
cache) of a file from a cfh?  Would appreciate pointers on
implementation.

I also noticed that NFS4ERR_FHEXPIRED is not referenced anywhere in
the kernel (particularly nfs client), so I'm guessing support for
filehandle expiry is quite a ways off.

Another question: I'd like to reproduce this error more quickly by
reducing the mds cache size.  I wanted to confirm 'mds_cache_size' is
what i'm looking for... and that I'd set it in the mds stanza of the
config with 'mds cache size =3D ####'?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
