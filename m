From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Write operation is stuck
Date: Tue, 23 Feb 2010 10:11:14 -0800
Message-ID: <a37615151002231011i33a905c8qa338c4018752cc9e@mail.gmail.com>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1466363504195151363=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "Talyansky, Roman" <roman.talyansky@sap.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============1466363504195151363==
Content-Type: multipart/alternative; boundary=001636b14b85b6f4cb048048795f

--001636b14b85b6f4cb048048795f
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Feb 23, 2010 at 6:11 AM, Talyansky, Roman
<roman.talyansky@sap.com>wrote:

> Hi Sage,
>
> As you advised us, we switched to the release 0.19 of ceph and ran into
> another bug in the ceph client. When writing to a file with the O_SYNC flag,
>  "0" is always returned although the data is written to disk.
> This poses a problem in our benchmark which uses the return value as number
> of bytes written. Also it seems that such behavior infringes the POSIX
> write() contract.
>
>
Yeah, thanks. A fix was pushed to the unstable branch. We will probably
start maintaining a stable version that will contain such fixes, but you can
apply this in the mean time:

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2c4ae44..88932c9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -807,7 +807,7 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const
struct iovec *iov,
        struct ceph_osd_client *osdc = &ceph_client(inode->i_sb)->osdc;
        loff_t endoff = pos + iov->iov_len;
        int got = 0;
-       int ret;
+       int ret, err;

        if (ceph_snap(inode) != CEPH_NOSNAP)
                return -EROFS;
@@ -838,9 +838,12 @@ retry_snap:

                if ((ret >= 0 || ret == -EIOCBQUEUED) &&
                    ((file->f_flags & O_SYNC) ||
IS_SYNC(file->f_mapping->host)
-                    || ceph_osdmap_flag(osdc->osdmap,
CEPH_OSDMAP_NEARFULL)))
-                       ret = vfs_fsync_range(file, file->f_path.dentry,
+                    || ceph_osdmap_flag(osdc->osdmap,
CEPH_OSDMAP_NEARFULL))) {
+                       err = vfs_fsync_range(file, file->f_path.dentry,
                                              pos, pos + ret - 1, 1);
+                       if (err < 0)
+                               ret = err;
+               }
        }
        if (ret >= 0) {
                spin_lock(&inode->i_lock);



Yehuda

--001636b14b85b6f4cb048048795f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Tue, Feb 23, 2010 at=
 6:11 AM, Talyansky, Roman <span dir=3D"ltr">&lt;<a href=3D"mailto:roman.ta=
lyansky@sap.com">roman.talyansky@sap.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex;">
Hi Sage,<br>
<br>
As you advised us, we switched to the release 0.19 of ceph and ran into ano=
ther bug in the ceph client. When writing to a file with the O_SYNC flag, =
=A0&quot;0&quot; is always returned although the data is written to disk.<b=
r>

This poses a problem in our benchmark which uses the return value as number=
 of bytes written. Also it seems that such behavior infringes the POSIX wri=
te() contract.<br><br></blockquote><div><br></div><div>Yeah, thanks. A fix =
was pushed to the unstable branch. We will probably start maintaining a sta=
ble version that will contain such fixes, but you can apply this in the mea=
n time:</div>
<div><br></div><div><div>diff --git a/fs/ceph/file.c b/fs/ceph/file.c</div>=
<div>index 2c4ae44..88932c9 100644</div><div>--- a/fs/ceph/file.c</div><div=
>+++ b/fs/ceph/file.c</div><div>@@ -807,7 +807,7 @@ static ssize_t ceph_aio=
_write(struct kiocb *iocb, const struct iovec *iov,</div>
<div>=A0=A0 =A0 =A0 =A0struct ceph_osd_client *osdc =3D &amp;ceph_client(in=
ode-&gt;i_sb)-&gt;osdc;</div><div>=A0=A0 =A0 =A0 =A0loff_t endoff =3D pos +=
 iov-&gt;iov_len;</div><div>=A0=A0 =A0 =A0 =A0int got =3D 0;</div><div>- =
=A0 =A0 =A0 int ret;</div><div>+ =A0 =A0 =A0 int ret, err;</div>
<div><br></div><div>=A0=A0 =A0 =A0 =A0if (ceph_snap(inode) !=3D CEPH_NOSNAP=
)</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EROFS;</div><div>@@ -=
838,9 +838,12 @@ retry_snap:</div><div><br></div><div>=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0if ((ret &gt;=3D 0 || ret =3D=3D -EIOCBQUEUED) &amp;&amp;</d=
iv>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((file-&gt;f_flags &amp; O_S=
YNC) || IS_SYNC(file-&gt;f_mapping-&gt;host)</div><div>- =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0|| ceph_osdmap_flag(osdc-&gt;osdmap, CEPH_OSDMAP_NEA=
RFULL)))</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vf=
s_fsync_range(file, file-&gt;f_path.dentry,</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| ceph_osdmap_flag(osdc-&gt;=
osdmap, CEPH_OSDMAP_NEARFULL))) {</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 err =3D vfs_fsync_range(file, file-&gt;f_path.dentry,</div>=
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0pos, pos + ret - 1, 1);</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err &lt; 0)</div><di=
v>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D err=
;</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }</div><div>=A0=A0 =A0 =A0 =A0}</=
div><div>=A0=A0 =A0 =A0 =A0if (ret &gt;=3D 0) {</div><div>=A0=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0spin_lock(&amp;inode-&gt;i_lock);</div>
<div><br></div><div><br></div><div><br></div><div>Yehuda</div></div></div><=
/div>

--001636b14b85b6f4cb048048795f--


--===============1466363504195151363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============1466363504195151363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============1466363504195151363==--
