From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: vi, multiple users
Date: Wed, 30 Dec 2009 20:31:16 -0800
Message-ID: <a37615150912302031w2f28c7d6u62f8fa94935c0f1@mail.gmail.com>
References: <a37615150912301156w2cc0bb07l3035a2176f71d0cf@mail.gmail.com>
	<Pine.LNX.4.64.0912302001370.10847@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6231831524240958642=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0912302001370.10847@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============6231831524240958642==
Content-Type: multipart/alternative; boundary=001636c93192d8aa39047bfeb92a

--001636c93192d8aa39047bfeb92a
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Dec 30, 2009 at 8:02 PM, Sage Weil <sage@newdream.net> wrote:

>
> BTW the corruption I was seeing was that the second page was written to
> the first page (or something very close to that, possibly shifted by a
> byte?).
>

I see the last page being written over the first one, also shifted by one
byte. The rest of the pages are just garbage. Could be just a bug in the
sync write related functions, wasn't able to isolate it yet.

--001636c93192d8aa39047bfeb92a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Wed, Dec 30, 2009 at=
 8:02 PM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sage@newdream.n=
et">sage@newdream.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x;">
<div><div></div><div class=3D"h5"><br>
</div></div>BTW the corruption I was seeing was that the second page was wr=
itten to<br>
the first page (or something very close to that, possibly shifted by a<br>
byte?).<br></blockquote><div><br></div><div>I see the last page being writt=
en over the first one, also shifted by one byte. The rest of the pages are =
just garbage. Could be just a bug in the sync write related functions, wasn=
&#39;t able to isolate it yet.</div>
</div></div>

--001636c93192d8aa39047bfeb92a--


--===============6231831524240958642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============6231831524240958642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============6231831524240958642==--
