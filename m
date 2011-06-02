From: Sylar Shen <kimulaaa@gmail.com>
Subject: samba of Ceph
Date: Thu, 2 Jun 2011 10:33:44 +0800
Message-ID: <BANLkTin491FEmWbYaGXa9GYx219L2NoOeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64649 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758966Ab1FBCdp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 22:33:45 -0400
Received: by bwz15 with SMTP id 15so560164bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 19:33:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Dear Brian and Gregory,
Thanks for your information about samba of Ceph.
I am trying to use a Ceph client to mount Ceph DFS(/mnt/cephfs/) and
set up a samba server to share the mount point(/mnt/cephfs/) to
Windows 2008 AD.
(Yes, I would like to integrate Windows Active Directory with a samba
server which is also a Ceph client)
However, I encountered one problem while doing so......><
I cannot write or upload files via samba although the read function is =
OK.
Originally, I think I can fix it by changing /etc/fstab/ settings
like...... "monitor_IP:/ =C2=A0 =C2=A0 =C2=A0 /mnt/cephfs/ =C2=A0 =C2=A0=
 =C2=A0btrfs
defaults,acl =C2=A0 =C2=A01 2"
But it's not working.......and I don't know how to solve this acl
problem at all.......
Brian said he is working on this. Does that mean I cannot just set up
a samba server to share a Ceph mount point to Windows AD now?
Maybe I have to wait until the function of re-export samba is finished?
Thanks for your kindness to reply~~^^

2011/6/1 Brian Chrisman <brchrisman@gmail.com>
>
> On Tue, May 31, 2011 at 9:17 AM, Gregory Farnum <gregf@hq.newdream.ne=
t> wrote:
> > On Sat, May 28, 2011 at 7:45 PM, Sylar Shen <kimulaaa@gmail.com> wr=
ote:
> >> Hi Gregory,
> >> Thanks for your information very much!
> >> By the way, the test of re-exporting NFS I did worked not bad.
> >> And I am wondering since Ceph can re-export NFS, then can Ceph
> >> re-export SAMBA that connects to windows?
> > We don't have a samba re-export functionality, although you can jus=
t
> > run samba on a Ceph mount if you like. And I think bchrisman is
> > working on one, but you'd have to ask him about that. :)
>
>
> Richard Sharpe and I have a VFS layer integrating Ceph (libceph) with
> Samba that is just a stone's throw from basic functionality.
> Current status:
> mount/init, stat, opendir, readdir, and a few other operations are wo=
rking.
> We're chasing down what appears to be a few smaller problems related
> to read/write.
> We've also used to the acl_xattr module to avoid doing a bunch of acl
> translations, though we could probably hit that in a second pass.
> One future critical issue here is going to be the caching mechanism
> and how it works with Samba's process model (process per connection).
> This merits a discussion about how multiple libceph clients will work
> together when run on the same host.
>
> > -Greg
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
> >



--
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
