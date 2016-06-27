From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
	objects in pool
Date: Mon, 27 Jun 2016 18:12:38 +1000
Message-ID: <CA+z5DswEaFJsr6uykeYF488is9XMwvwNpPMUC1QXvfdvp9sJcg@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
	<D38DCB57.131AE%warren.wang@walmart.com>
	<20160621075856.3ad471d1@batzmaru.gol.ad.jp>
	<CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
	<CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
	<CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
	<D391D1A4.145D6%warren.wang@walmart.com>
	<BL2PR02MB2115BD5C173011A0CB92F964F42D0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<20160624090806.1246b1ff@batzmaru.gol.ad.jp>
	<BL2PR02MB21153E31C8C9206120947A3FF42E0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+e22SdmGJVzJX9+63T41UGsfFcxs9R=xZqniQyTgu-yG=h0cA@mail.gmail.com>
	<CAFMfnwoqbr+_c913oyxpvzHNS+NPdXX17dMdXoC1ZiuZM1GzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0983951030=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAFMfnwoqbr+_c913oyxpvzHNS+NPdXX17dMdXoC1ZiuZM1GzPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Kyle Bader <kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0983951030==
Content-Type: multipart/alternative; boundary=94eb2c0933626fbfe305363e1517

--94eb2c0933626fbfe305363e1517
Content-Type: text/plain; charset=UTF-8

On 25 Jun 2016 6:02 PM, "Kyle Bader" <kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> fdatasync takes longer when you have more inodes in the slab caches, it's
the double edged sword of vfs_cache_pressure.

That's a bit sad when, iiuc, it's only journals doing fdatasync in the Ceph
write path. I'd have expected the vfs to handle this on a per fs basis (and
a journal filesystem would have very little in the inode cache).

It's somewhat annoying there isn't a way to favor dentries (and perhaps
dentry inodes) over other inodes in the vfs cache. Our experience shows
that it's dentry misses that cause the major performance issues (makes
sense when you consider the osd is storing all its data in the leafs of the
on disk PG structure).

This is another discussion that seems to backup the choice to implement
bluestore.

Cheers,
Blair

--94eb2c0933626fbfe305363e1517
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On 25 Jun 2016 6:02 PM, &quot;Kyle Bader&quot; &lt;<a href=
=3D"mailto:kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; fdatasync takes longer when you have more inodes in the slab caches, i=
t&#39;s the double edged sword of vfs_cache_pressure.</p>
<p dir=3D"ltr">That&#39;s a bit sad when, iiuc, it&#39;s only journals doin=
g fdatasync in the Ceph write path. I&#39;d have expected the vfs to handle=
 this on a per fs basis (and a journal filesystem would have very little in=
 the inode cache).</p>
<p dir=3D"ltr">It&#39;s somewhat annoying there isn&#39;t a way to favor de=
ntries (and perhaps dentry inodes) over other inodes in the vfs cache. Our =
experience shows that it&#39;s dentry misses that cause the major performan=
ce issues (makes sense when you consider the osd is storing all its data in=
 the leafs of the on disk PG structure).</p>
<p dir=3D"ltr">This is another discussion that seems to backup the choice t=
o implement bluestore.</p>
<p dir=3D"ltr">Cheers,<br>
Blair<br>
</p>

--94eb2c0933626fbfe305363e1517--

--===============0983951030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0983951030==--
