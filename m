From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: scrub errors on rgw data pool
Date: Mon, 25 Nov 2019 15:34:46 +0530
Message-ID: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918484070848081661=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1918484070848081661==
Content-Type: multipart/alternative; boundary="00000000000056268d059828e5b0"

--00000000000056268d059828e5b0
Content-Type: text/plain; charset="UTF-8"

Hello - We are using the ceph 12.2.11 version (upgraded from Jewel 10.2.12
to 12.2.11). In this cluster, we are having mix of filestore and bluestore
OSD backends.
Recently we are seeing the scrub errors on rgw buckets.data pool every day,
after scrub operation performed by Ceph. If we run the PG repair, the
errors will go way.

Anyone seen the above issue?
Is the mix of filestore backend has bug/issue with 12.2.11 version (ie
Luminous).
Is the mix of filestore and bluestore OSDs cause this type of issue?

Thanks
Swami

--00000000000056268d059828e5b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello - We are using the ceph 12.2.11 version (upgraded fr=
om Jewel 10.2.12 to 12.2.11). In this cluster, we are having=C2=A0mix of fi=
lestore and bluestore OSD backends.<div>Recently=C2=A0we are seeing the scr=
ub errors on rgw buckets.data pool every day, after scrub operation perform=
ed by Ceph. If we run the PG repair, the errors will go way.</div><div><br>=
</div><div>Anyone seen the above issue?=C2=A0=C2=A0</div><div>Is the mix of=
 filestore backend has bug/issue with 12.2.11 version (ie Luminous).</div><=
div>Is the mix of filestore and bluestore OSDs cause this type of issue?</d=
iv><div><br></div><div>Thanks</div><div>Swami</div></div>

--00000000000056268d059828e5b0--

--===============1918484070848081661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1918484070848081661==--
