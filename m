From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Wed, 24 Feb 2010 14:34:23 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002161032280.31640@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A238242@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002191007260.20757@cobra.newdream.net>
	<C6A64D82E3A5D24B949315CFBC1FA1AD072A34414F@DEWDFECCR01.wdf.sap.corp>
	<a37615151002231011i33a905c8qa338c4018752cc9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1446135999712393956=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <a37615151002231011i33a905c8qa338c4018752cc9e@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============1446135999712393956==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200DEWDFECCR01wd_"

--_000_C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200DEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

Thanks for the info on the fix. I'll incorporate it into the code and rerun=
 the experiments.
It also seems that the code at that location became a bit more complex - ne=
w #if occurred:

#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2, 6, 32)

And consequently the code under #else should be fixed as well.

Thanks,

Roman

From: Yehuda Sadeh Weinraub [mailto:yehudasa@gmail.com]
Sent: Tuesday, February 23, 2010 8:11 PM
To: Talyansky, Roman
Cc: Sage Weil; ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck


On Tue, Feb 23, 2010 at 6:11 AM, Talyansky, Roman <roman.talyansky@sap.com<=
mailto:roman.talyansky@sap.com>> wrote:
Hi Sage,

As you advised us, we switched to the release 0.19 of ceph and ran into ano=
ther bug in the ceph client. When writing to a file with the O_SYNC flag,  =
"0" is always returned although the data is written to disk.
This poses a problem in our benchmark which uses the return value as number=
 of bytes written. Also it seems that such behavior infringes the POSIX wri=
te() contract.

Yeah, thanks. A fix was pushed to the unstable branch. We will probably sta=
rt maintaining a stable version that will contain such fixes, but you can a=
pply this in the mean time:

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2c4ae44..88932c9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -807,7 +807,7 @@ static ssize_t ceph_aio_write(struct kiocb *iocb, const=
 struct iovec *iov,
        struct ceph_osd_client *osdc =3D &ceph_client(inode->i_sb)->osdc;
        loff_t endoff =3D pos + iov->iov_len;
        int got =3D 0;
-       int ret;
+       int ret, err;

        if (ceph_snap(inode) !=3D CEPH_NOSNAP)
                return -EROFS;
@@ -838,9 +838,12 @@ retry_snap:

                if ((ret >=3D 0 || ret =3D=3D -EIOCBQUEUED) &&
                    ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->h=
ost)
-                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL=
)))
-                       ret =3D vfs_fsync_range(file, file->f_path.dentry,
+                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL=
))) {
+                       err =3D vfs_fsync_range(file, file->f_path.dentry,
                                              pos, pos + ret - 1, 1);
+                       if (err < 0)
+                               ret =3D err;
+               }
        }
        if (ret >=3D 0) {
                spin_lock(&inode->i_lock);



Yehuda

--_000_C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200DEWDFECCR01wd_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>Hi Yehuda,<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>Thanks for the info on the fix. I&#8217;ll incorporate it in=
to the
code and rerun the experiments.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>It also seems that the code at that location became a bit mo=
re
complex &#8211; new #if occurred:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'text-indent:36.0pt'><span style=3D'font-size:=
11.0pt;
font-family:"Calibri","sans-serif";color:#1F497D'>#if LINUX_VERSION_CODE &g=
t;=3D
KERNEL_VERSION(2, 6, 32)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>And consequently the code under #else should be fixed as wel=
l.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>Thanks,<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>Roman<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif"'>From:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Yehuda Sadeh
Weinraub [mailto:yehudasa@gmail.com] <br>
<b>Sent:</b> Tuesday, February 23, 2010 8:11 PM<br>
<b>To:</b> Talyansky, Roman<br>
<b>Cc:</b> Sage Weil; ceph-devel@lists.sourceforge.net<br>
<b>Subject:</b> Re: [ceph-devel] Write operation is stuck<o:p></o:p></span>=
</p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><o:p>&nbsp;</o:p></p>

<div>

<p class=3DMsoNormal>On Tue, Feb 23, 2010 at 6:11 AM, Talyansky, Roman &lt;=
<a
href=3D"mailto:roman.talyansky@sap.com">roman.talyansky@sap.com</a>&gt; wro=
te:<o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hi Sage,<br>
<br>
As you advised us, we switched to the release 0.19 of ceph and ran into ano=
ther
bug in the ceph client. When writing to a file with the O_SYNC flag,
&nbsp;&quot;0&quot; is always returned although the data is written to disk=
.<br>
This poses a problem in our benchmark which uses the return value as number=
 of
bytes written. Also it seems that such behavior infringes the POSIX write()
contract.<o:p></o:p></p>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal>Yeah, thanks. A fix was pushed to the unstable branch.=
 We
will probably start maintaining a stable version that will contain such fix=
es,
but you can apply this in the mean time:<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<div>

<p class=3DMsoNormal>diff --git a/fs/ceph/file.c b/fs/ceph/file.c<o:p></o:p=
></p>

</div>

<div>

<p class=3DMsoNormal>index 2c4ae44..88932c9 100644<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>--- a/fs/ceph/file.c<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+++ b/fs/ceph/file.c<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>@@ -807,7 +807,7 @@ static ssize_t ceph_aio_write(stru=
ct
kiocb *iocb, const struct iovec *iov,<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;struct ceph_osd_clien=
t
*osdc =3D &amp;ceph_client(inode-&gt;i_sb)-&gt;osdc;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;loff_t endoff =3D pos=
 +
iov-&gt;iov_len;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;int got =3D 0;<o:p></=
o:p></p>

</div>

<div>

<p class=3DMsoNormal>- &nbsp; &nbsp; &nbsp; int ret;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; int ret, err;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;if (ceph_snap(inode) =
!=3D
CEPH_NOSNAP)<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;return -EROFS;<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>@@ -838,9 +838,12 @@ retry_snap:<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;if ((ret &gt;=3D 0 || ret =3D=3D -EIOCBQUEUED) &amp;&amp;<o:p></o:p><=
/p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;((file-&gt;f_flags &amp; O_SYNC) ||
IS_SYNC(file-&gt;f_mapping-&gt;host)<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp;|| ceph_osdmap_flag(osdc-&gt;osdmap, CEPH_OSDMAP_NEARFULL)))<o=
:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; ret =3D vfs_fsync_range(file, file-&gt;f_path.dentry,<=
o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp;|| ceph_osdmap_flag(osdc-&gt;osdmap, CEPH_OSDMAP_NEARFULL))) {=
<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; err =3D vfs_fsync_range(file, file-&gt;f_path.dentry,<=
o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pos, pos + ret - 1, 1);<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; if (err &lt; 0)<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D err;<o:p></o:p></p=
>

</div>

<div>

<p class=3DMsoNormal>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<o=
:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;}<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;if (ret &gt;=3D 0) {<=
o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;spin_lock(&amp;inode-&gt;i_lock);<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

<div>

<p class=3DMsoNormal>Yehuda<o:p></o:p></p>

</div>

</div>

</div>

</div>

</div>

</body>

</html>

--_000_C6A64D82E3A5D24B949315CFBC1FA1AD072A3B5200DEWDFECCR01wd_--


--===============1446135999712393956==
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
--===============1446135999712393956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============1446135999712393956==--
