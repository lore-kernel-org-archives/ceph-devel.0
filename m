From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd cannot find cosd process after reboot
Date: Thu, 10 Mar 2011 18:05:09 -0800
Message-ID: <AANLkTimqkQONiZ9e6UFgvfrvoo7A=5hZ1W4JntQvFw80@mail.gmail.com>
References: <AANLkTi=1uDMuN18kOjLm7ysttx3nN9MdMp-7Gdni2S0W@mail.gmail.com>
	<B0304C5EE27C431CA5C86CBBD4514472@gmail.com>
	<AANLkTi=jygN2sjPSceAwyk+=EP3P4AnavxBSGdNiNCZv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42361 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1CKCFM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 21:05:12 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E72C5C064
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 18:05:11 -0800 (PST)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 97523C062
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 18:05:11 -0800 (PST)
Received: by eyx24 with SMTP id 24so783500eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 18:05:10 -0800 (PST)
In-Reply-To: <AANLkTi=jygN2sjPSceAwyk+=EP3P4AnavxBSGdNiNCZv@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/3/10 huang jun <hjwsm1989@gmail.com>:
> hi Greg:
> here is my configure file:
<snip>
> and i find something wrong =A0in /var/log/ceph/osd.0.log
> 2011-03-11 08:42:23.888496 7f207255d6f0 osd0 0 mounting /data/osd0
> 2011-03-11 08:42:23.888517 7f207255d6f0 filestore(/data/osd0) basedir
> /data/osd0 journal
> 2011-03-11 08:42:23.888576 7f207255d6f0 filestore(/data/osd0) x =3D
> 1804289383 =A0 y =3D 1804289384
> 2011-03-11 08:42:23.888621 7f207255d6f0 filestore(/data/osd0) xattrs
> don't appear to work (Operation not supported) on /data/osd0/fsid, be
> sure to mount underlying file system with 'user_xattr' option
> 2011-03-11 08:42:23.888632 7f207255d6f0 osd0 0 =A0unable to mount obj=
ect store
>
> i don't know why "x !=3D y"
> thanks!
Aha! It looks like the filesystem you are attempting to use as the
OSD's data store doesn't have user xattr support enabled. This is a
required feature for Ceph to work, so when the OSD boots up, it
discovers the xattrs are broken and shuts itself back down again.
If you had this working previously, it's possible that you didn't put
user xattrs into the default mount options, so the setting was lost on
reboot.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
