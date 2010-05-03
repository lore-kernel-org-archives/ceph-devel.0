From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: [PATCH] ceph-client: fix xattr bugs
Date: Mon, 3 May 2010 14:41:52 +0800
Message-ID: <w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
	 <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
	 <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
	 <Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
	 <m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f195.google.com ([209.85.221.195]:42381 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab0ECGlx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 May 2010 02:41:53 -0400
Received: by qyk33 with SMTP id 33so1041231qyk.24
        for <ceph-devel@vger.kernel.org>; Sun, 02 May 2010 23:41:52 -0700 (PDT)
In-Reply-To: <m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please see my inline reply below.

-Henry

On Sat, May 1, 2010 at 2:21 AM, Sage Weil <sage@newdream.net> wrote:
>
> On Fri, 30 Apr 2010, Henry C Chang wrote:
> > Hi Sage,
> >
> > Thanks for your reply.
> > I don't have the test program that reproduces the bug actually.
> > I detected it manually by entering xattr commands from the command =
prompt.
>
> Do you remember which setfattr/whatever commands?

I installed python-xattr package and it contains a script 'xattr' that
can be used from command prompt directly.

root@ceph-vm2:~# xattr --help
usage: xattr [-l] file [attr_name [attr_value]]
=C2=A0 -l: print long format (attr_name: attr_value) when listing xattr=
s
=C2=A0 With no optional arguments, lists the xattrs on file
=C2=A0 With attr_name only, lists the contents of attr_name on file
=C2=A0 With attr_value, set the contents of attr_name on file

One of my test sequence is:

$ xattr /mnt/ceph/folder user.quota 20000000
$ xattr /mnt/ceph/folder user.quota
20000000
$ umount /mnt/ceph
$ mount -t ceph 192.168.159.135:/ /mnt/ceph
$ xattr /mnt/ceph/folder user.quota
No such attribute.

Thereafter, the system will become abnormal at some point and crash eve=
ntually.

>
> > In fact, I am trying to add "folder quota support" to ceph right no=
w.
> > My rough idea is as below:
> >
> > (1) Store the quota limit in the xattr of the folder;
> > (2) When the client requests a new max size for writing content to =
a file,
> > MDS authorizes the request according to the quota and the rstat of =
the
> > folder.
>
> One thing to keep in mind is that because the recursive rsize info is
> lazily propagated up the file tree, this won't work perfectly. =C2=A0=
If you set
> a limit of 1GB on /foo and are writing data in /foo/bar/baz, it won't=
 stop
> you right at 1GB. =C2=A0Similarly, if you hit the limit, and delete s=
ome stuff,
> it will take time before the MDS notices and lets you start writing a=
gain.
>
Hmm... this would be a problem....
=46rom the perspective of a user, I would be happy if I can write more
than my quota.
However, I would get pissed off if I have deleted some stuff but still
cannot write anything and don't know how long I have to wait.

Is it possible to force MDS to propaget rsize info when files are delet=
ed?
Or, can lazy propagation be bounded to a maximum interval (say 5 second=
s)?


>
> If that is acceptable, then in principle this is doable, although
> difficult. =C2=A0The first step would probably be keeping track of ho=
w much
> "max_size - size" slop is currently outstanding in a recursive fashio=
n so
> that the mds can limit itself. =C2=A0For a single mds that's pretty d=
oable.
> When you consider that the hierarchy can be partitioned across multip=
le
> nodes, it becomes more difficult (which is partly why rsize is lazily
> propagated). =C2=A0This would definitely take some planning...
>
> What is your use case?
>
I want to create "depots" inside ceph:
- Each depot has its own quota limit and can be resized as needed.
- Multiple users can read/write the same depot concurrently.

My original plan is to create a first-level folder for each depot
(e.g., /mnt/ceph/depot1, /mnt/ceph/depot2, ...) and set quota on it.
Do you have any suggestion on implementing such a use case?


>
> sage
>
>
>
> >
> > I detected the xattr bug when I was doing tests for (1). Everything=
 goes
> > well so far after it's fixed.
> > I can write some test programs to test it more since I will write a=
 program
> > (tool) to set/get folder quota.
> >
> > I would appreciate if you can give me some advices on implementing =
"folder
> > quota".
> >
> > Best Regards,
> > Henry
> >
> >
> > On Fri, Apr 30, 2010 at 12:39 AM, Sage Weil <sage@newdream.net> wro=
te:
> >
> > > Hi Henry--
> > >
> > > On Thu, 29 Apr 2010, Henry C Chang wrote:
> > > > 1. fill_inode() incorrectly frees the xattr blob in the end of =
the
> > > > =C2=A0 function. It will cause segfault and then kernel will cr=
ash.
> > >
> > > I fixed this slightly differently, by clearing xattr_blob if/when=
 it is
> > > used. =C2=A0See
> > >
> > >
> > > http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommitdiff;=
h=3Dc89f9c6decdbe2427d4d510a949a2d87c5e340dc
> > >
> > > > 2. ceph_listxattr() should compare index_version and version by=
 '>=3D'.
> > >
> > >
> > > http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommitdiff;=
h=3Dda6eb075f800b64af9e199ffbe9171752647fbaa
> > >
> > > Both are pushed to the unstable branch. =C2=A0Do you mind testing=
? =C2=A0Do you have
> > > a simple test that reproduced the bug before? =C2=A0If so we shou=
ld add it to
> > > the qa suite (which currently does nothing with xattrs).
> > >
> > > Thanks!
> > > sage
> > >
> > >
> > > >
> > > > Signed-off-by: henry_c_chang <henry_c_chang@tcloudcomputing.com=
>
> > > > ---
> > > > =C2=A0inode.c | =C2=A0 =C2=A02 +-
> > > > =C2=A0xattr.c | =C2=A0 =C2=A02 +-
> > > > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/inode.c b/inode.c
> > > > index 261f3e6..bfe48ee 100644
> > > > --- a/inode.c
> > > > +++ b/inode.c
> > > > @@ -742,7 +742,7 @@ no_change:
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D 0;
> > > >
> > > > =C2=A0out:
> > > > - =C2=A0 =C2=A0 =C2=A0 if (xattr_blob)
> > > > + =C2=A0 =C2=A0 =C2=A0 if (err && xattr_blob)
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ceph_buf=
fer_put(xattr_blob);
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> > > > =C2=A0}
> > > > diff --git a/xattr.c b/xattr.c
> > > > index 37d6ce6..8c4ef01 100644
> > > > --- a/xattr.c
> > > > +++ b/xattr.c
> > > > @@ -573,7 +573,7 @@ ssize_t ceph_listxattr(struct dentry *dentr=
y, char
> > > > *names, size_t size)
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ci->i_xattrs.version,=
 ci->i_xattrs.index_version);
> > > >
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (__ceph_caps_issued_mask(ci, CEPH=
_CAP_XATTR_SHARED, 1) &&
> > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ci->i_xattrs.index_versio=
n > ci->i_xattrs.version)) {
> > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ci->i_xattrs.index_versio=
n >=3D ci->i_xattrs.version)) {
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto lis=
t_xattr;
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unl=
ock(&inode->i_lock);
> > > > --
> > > > 1.6.3.3
> > > >
> > >
> >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
