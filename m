From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: How to unset lfor setting (from cache pool)
Date: Mon, 06 Apr 2015 16:21:11 +0700
Message-ID: <55225007.7040404@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1454277900=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1454277900==
Content-Type: multipart/alternative;
 boundary="------------070606020908090708060409"

This is a multi-part message in MIME format.
--------------070606020908090708060409
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have ever to setup the cache-pool for my pool.
But had some proplems about cache-pool running, so I removed the cache 
pool from My CEPH Cluster.

The DATA pool currently don't use cache pool, but "lfor" setting still 
be appeared.
*lfor* seems is a setting, not flag.

pool 3 'data_pool' replicated size 3 min_size 1 crush_ruleset 4 
object_hash rjenkins pg_num 4098 pgp_num 4098 last_change 145235 *lfor 
75731* flags hashpspool stripe_width 0

How to unset lfor?,  and  After unsetting lofr, My pool activities OK?

Thanks!
--
Tuantaba
Ha Noi-VietNam.



--------------070606020908090708060409
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi all,<br>
    <br>
    I have ever to setup the cache-pool for my pool.<br>
    But had some proplems about cache-pool running, so I removed the
    cache pool from My CEPH Cluster.<br>
    <br>
    The DATA pool currently don't use cache pool, but "lfor" setting
    still be appeared.<br>
    <b>lfor</b> seems is a setting, not flag.<br>
    <br>
    pool 3 'data_pool' replicated size 3 min_size 1 crush_ruleset 4
    object_hash rjenkins pg_num 4098 pgp_num 4098 last_change 145235 <b>l=
for
      75731</b> flags hashpspool stripe_width 0<br>
    <br>
    How to unset lfor?,=C2=A0 and=C2=A0 After unsetting lofr, My pool act=
ivities
    OK?<br>
    <br>
    Thanks!<br>
    --<br>
    Tuantaba<br>
    Ha Noi-VietNam.<br>
    <br>
    <br>
  </body>
</html>

--------------070606020908090708060409--

--===============1454277900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1454277900==--
