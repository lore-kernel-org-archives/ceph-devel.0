From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pools limit
Date: Tue, 16 Jul 2019 19:46:28 +0530
Message-ID: <CANA9Uk6ZyYY1HuFXEjvs4aT3zaf7YvDdCH20Rhgb_5U89em0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2649834263249410853=="
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

--===============2649834263249410853==
Content-Type: multipart/alternative; boundary="0000000000006d84a5058dcd06be"

--0000000000006d84a5058dcd06be
Content-Type: text/plain; charset="UTF-8"

Hello - I have created 10 nodes ceph cluster with 14.x version. Can you
please confirm below:

Q1 - Can I create 100+ pool (or more) on the cluster? (the reason is -
creating a pool per project). Any limitation on pool creation?

Q2 - In the above pool - I use 128 PG-NUM - to start with and enable
autoscale for PG_NUM, so that based on the data in the pool, PG_NUM will
increase by ceph itself.

Let me know if any limitations for the above and any fore see issue?

Thanks
Swami

--0000000000006d84a5058dcd06be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello - I have created 10 nodes ceph cluster with 14.x ver=
sion. Can you please confirm below:<div><br></div><div>Q1 - Can I create 10=
0+ pool (or more) on the cluster? (the reason is - creating a pool per proj=
ect). Any limitation on pool creation?</div><div><br></div><div>Q2 - In the=
 above pool - I use 128 PG-NUM - to start with and enable autoscale for PG_=
NUM, so that based on the data in the pool, PG_NUM will increase by ceph it=
self.</div><div><br></div><div>Let me know if any limitations for the above=
 and any fore see issue?</div><div><br></div><div>Thanks</div><div>Swami</d=
iv></div>

--0000000000006d84a5058dcd06be--

--===============2649834263249410853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2649834263249410853==--
