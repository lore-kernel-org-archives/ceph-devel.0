From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: bluestore block.db on SSD, where block.wal?
Date: Sun, 2 Jun 2019 22:13:01 +0530
Message-ID: <CANA9Uk6nU4KZtipsZe=wXwck5ZP93rUmrvk8cvUmYjNoZwP8Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2623504989797012781=="
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

--===============2623504989797012781==
Content-Type: multipart/alternative; boundary="000000000000835979058a59f13c"

--000000000000835979058a59f13c
Content-Type: text/plain; charset="UTF-8"

Hello - I planned to use the bluestore's block.db on SSD (and data is on
HDD) with 4% of HDD size. Here I have not mentioned the block.wal..in this
case where block.wal place?
is it in HDD (ie data) or in block.db of SSD?

Thanks
Swami

--000000000000835979058a59f13c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello - I planned to use the bluestore&#39;s block.db on S=
SD (and data is on HDD) with 4% of HDD size. Here I have not mentioned the =
block.wal..in this case where block.wal place?<div>is it in HDD (ie data) o=
r in block.db of SSD?</div><div><br></div><div>Thanks</div><div>Swami</div>=
</div>

--000000000000835979058a59f13c--

--===============2623504989797012781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2623504989797012781==--
