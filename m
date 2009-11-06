From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [RFC] v2 separate otw data from host data
Date: Fri, 6 Nov 2009 12:08:39 -0800
Message-ID: <a37615150911061208m2957b648hf99d11820bfefe6c@mail.gmail.com>
References: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052127340.24285@cobra.newdream.net>
	<3A19C8FD-BDC5-41A5-BBED-8C8CE47FBEFC@soe.ucsc.edu>
	<Pine.LNX.4.64.0911052224121.24285@cobra.newdream.net>
	<1826697A-2DAB-4532-99B1-E1247AFDAD64@soe.ucsc.edu>
	<Pine.LNX.4.64.0911061138560.15146@cobra.newdream.net>
	<AF9F8769-3573-40CE-B786-433CD60245DE@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6583677735217204371=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <AF9F8769-3573-40CE-B786-433CD60245DE@soe.ucsc.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@lists.sourceforge.net, Noah Watkins <noah@noahdesu.com>
List-Id: ceph-devel.vger.kernel.org

--===============6583677735217204371==
Content-Type: multipart/alternative; boundary=0016e68dd1ebeaeb160477b96858

--0016e68dd1ebeaeb160477b96858
Content-Type: text/plain; charset=ISO-8859-1

> - lost the comments on the struct in ceph_fs.h

> I bumped the inline comments to a block comment above the struct. Or
> did you mean 'lose them' instead of 'lost' ?
>

personally I prefer seeing those inline on the struct. That way one feels
the obligation to update the comments whenever the struct is changed, and it
is faster reading through the code.

Yehuda

--0016e68dd1ebeaeb160477b96858
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt; - lost the comments on the struct in ceph_fs.h<br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">I bumped the inline comments to a block comment above the struct.=
 Or<br>

did you mean &#39;lose them&#39; instead of &#39;lost&#39; ?<br></blockquot=
e></div><br>personally I prefer seeing those inline on the struct. That way=
 one feels the obligation to update the comments whenever the struct is cha=
nged, and it is faster reading through the code.<br>
<br>Yehuda<br>

--0016e68dd1ebeaeb160477b96858--


--===============6583677735217204371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6583677735217204371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6583677735217204371==--
