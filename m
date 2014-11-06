From: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PG inconsistency
Date: Thu, 06 Nov 2014 13:46:12 +0000
Message-ID: <CAF-rypxJ4JCFSxqGYQ3vqPYUhf8rZqgX6mgMUy-sAGp=96-N_Q@mail.gmail.com>
References: <BLU175-W41E1F32E90ED411A4477FFDF840@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1657388360=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1657388360==
Content-Type: multipart/alternative; boundary=089e01634be865eaeb050730eb70

--089e01634be865eaeb050730eb70
Content-Type: text/plain; charset=UTF-8

What is your version of the ceph?
0.80.0 - 0.80.3
https://github.com/ceph/ceph/commit/7557a8139425d1705b481d7f010683169fd5e49b

Thu Nov 06 2014 at 16:24:21, GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>:

> Hello Cephers,
> Recently we observed a couple of inconsistencies in our Ceph cluster,
> there were two major patterns leading to inconsistency as I observed: 1)
> EIO to read the file, 2) the digest is inconsistent (for EC) even there is
> no read error).
>
> While ceph has built-in tool sets to repair the inconsistencies, I also
> would like to check with the community in terms of what is the best ways to
> handle such issues (e.g. should we run fsck / xfs_repair when such issue
> happens).
>
> In more details, I have the following questions:
> 1. When there is inconsistency detected, what is the chance there is some
> hardware issues which need to be repaired physically, or should I run some
> disk/filesystem tools to further check?
> 2. Should we use fsck / xfs_repair to fix the inconsistencies, or should
> we solely relay on Ceph's repair tool sets?
>
> It would be great to hear you experience and suggestions.
>
> BTW, we are using XFS in the cluster.
>
> Thanks,
> Guang
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--089e01634be865eaeb050730eb70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>What is your version of the ceph?</div><div>0.80.0 - 0.80.3</div><div>=
<a href=3D"https://github.com/ceph/ceph/commit/7557a8139425d1705b481d7f0106=
83169fd5e49b">https://github.com/ceph/ceph/commit/7557a8139425d1705b481d7f0=
10683169fd5e49b</a><br><br><div class=3D"gmail_quote">Thu Nov 06 2014 at 16=
:24:21, GuangYang &lt;<a href=3D"mailto:yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org">yguang11@outl=
ook.com</a>&gt;:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hello Cephers,<br>
Recently we observed a couple of inconsistencies in our Ceph cluster, there=
 were two major patterns leading to inconsistency as I observed: 1) EIO to =
read the file, 2) the digest is inconsistent (for EC) even there is no read=
 error).<br>
<br>
While ceph has built-in tool sets to repair the inconsistencies, I also wou=
ld like to check with the community in terms of what is the best ways to ha=
ndle such issues (e.g. should we run fsck / xfs_repair when such issue happ=
ens).<br>
<br>
In more details, I have the following questions:<br>
1. When there is inconsistency detected, what is the chance there is some h=
ardware issues which need to be repaired physically, or should I run some d=
isk/filesystem tools to further check?<br>
2. Should we use fsck / xfs_repair to fix the inconsistencies, or should we=
 solely relay on Ceph&#39;s repair tool sets?<br>
<br>
It would be great to hear you experience and suggestions.<br>
<br>
BTW, we are using XFS in the cluster.<br>
<br>
Thanks,<br>
Guang<br>
______________________________<u></u>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/<u></u>listinfo.cgi/ceph-users-ceph.<u></=
u>com</a><br>
</blockquote></div></div>

--089e01634be865eaeb050730eb70--

--===============1657388360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1657388360==--
