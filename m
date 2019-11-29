From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: scrub errors on rgw data pool
Date: Fri, 29 Nov 2019 15:45:40 +0530
Message-ID: <CANA9Uk75OULZLAJbWqh+1sd5r5D4LMPrej-gZYUUagDbEZU2HQ@mail.gmail.com>
References: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7518094735601318334=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============7518094735601318334==
Content-Type: multipart/alternative; boundary="000000000000b200240598798374"

--000000000000b200240598798374
Content-Type: text/plain; charset="UTF-8"

Primary OSD crashes with below assert:
12.2.11/src/osd/ReplicatedBackend.cc:1445 assert(peer_missing.count(
fromshard))
==
here I have 2 OSDs with bluestore backend and 1 osd with filestore backend.

On Mon, Nov 25, 2019 at 3:34 PM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hello - We are using the ceph 12.2.11 version (upgraded from Jewel 10.2.12
> to 12.2.11). In this cluster, we are having mix of filestore and bluestore
> OSD backends.
> Recently we are seeing the scrub errors on rgw buckets.data pool every
> day, after scrub operation performed by Ceph. If we run the PG repair, the
> errors will go way.
>
> Anyone seen the above issue?
> Is the mix of filestore backend has bug/issue with 12.2.11 version (ie
> Luminous).
> Is the mix of filestore and bluestore OSDs cause this type of issue?
>
> Thanks
> Swami
>

--000000000000b200240598798374
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Primary=C2=A0OSD crashes with below assert:<div><code><spa=
n class=3D"gmail-n">12.2.11/src/osd/ReplicatedBackend.cc:1445 assert</span>=
<span class=3D"gmail-p">(</span><span class=3D"gmail-n">peer_missing</span>=
<span class=3D"gmail-p">.</span><span class=3D"gmail-n">count</span><span c=
lass=3D"gmail-p">(</span><span class=3D"gmail-n">fromshard</span><span clas=
s=3D"gmail-p">))</span></code><br></div><div><code><span class=3D"gmail-p">=
=3D=3D</span></code></div><div><code><span class=3D"gmail-p">here I have 2 =
OSDs with bluestore backend and 1 osd with filestore backend.</span></code>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Nov 25, 2019 at 3:34 PM M Ranga Swami Reddy &lt;<a href=3D"ma=
ilto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hello - We =
are using the ceph 12.2.11 version (upgraded from Jewel 10.2.12 to 12.2.11)=
. In this cluster, we are having=C2=A0mix of filestore and bluestore OSD ba=
ckends.<div>Recently=C2=A0we are seeing the scrub errors on rgw buckets.dat=
a pool every day, after scrub operation performed by Ceph. If we run the PG=
 repair, the errors will go way.</div><div><br></div><div>Anyone seen the a=
bove issue?=C2=A0=C2=A0</div><div>Is the mix of filestore backend has bug/i=
ssue with 12.2.11 version (ie Luminous).</div><div>Is the mix of filestore =
and bluestore OSDs cause this type of issue?</div><div><br></div><div>Thank=
s</div><div>Swami</div></div>
</blockquote></div>

--000000000000b200240598798374--

--===============7518094735601318334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7518094735601318334==--
