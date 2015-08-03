From: =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Is it safe to increase pg number in a production
	environment
Date: Mon, 3 Aug 2015 15:57:24 +0800
Message-ID: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1081608113=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, cbt-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1081608113==
Content-Type: multipart/alternative; boundary=047d7bd755c4482c87051c638647

--047d7bd755c4482c87051c638647
Content-Type: text/plain; charset=UTF-8

Hi Cephers,

This is a greeting from Jevon. Currently, I'm experiencing an issue which
suffers me a lot, so I'm writing to ask for your comments/help/suggestions.
More details are provided bellow.

Issue:
I set up a cluster having 24 OSDs and created one pool with 1024 placement
groups on it for a small startup company. The number 1024 was calculated
per the equation 'OSDs * 100'/pool size. The cluster have been running
quite well for a long time. But recently, our monitoring system always
complains that some disks' usage exceed 85%. I log into the system and find
out that some disks' usage are really very high, but some are not(less than
60%). Each time when the issue happens, I have to manually re-balance the
distribution. This is a short-term solution, I'm not willing to do it all
the time.

Two long-term solutions come in my mind,
1) Ask the customers to expand their clusters by adding more OSDs. But I
think they will ask me to explain the reason of the imbalance data
distribution. We've already done some analysis on the environment, we
learned that the most imbalance part in the CRUSH is the mapping between
object and pg. The biggest pg has 613 objects, while the smallest pg only
has 226 objects.

2) Increase the number of placement groups. It can be of great help for
statistically uniform data distribution, but it can also incur significant
data movement as PGs are effective being split. I just cannot do it in our
customers' environment before we 100% understand the consequence. So anyone
did this under a production environment? How much does this operation
affect the performance of Clients?

Any comments/help/suggestions will be highly appreciated.

-- 
Best Regards
Jevon

--047d7bd755c4482c87051c638647
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Cephers,</div><div><br></div><div>This is a greeti=
ng from Jevon. Currently, I&#39;m experiencing an issue which suffers me a =
lot, so I&#39;m writing to ask for your comments/help/suggestions. More det=
ails are provided bellow.</div><div><br></div><div>Issue:</div><div>I set u=
p a cluster having 24 OSDs and created one pool with 1024 placement groups =
on it for a small startup company. The number 1024 was calculated per the e=
quation &#39;OSDs * 100&#39;/pool size. The cluster have been running quite=
 well for a long time. But recently, our monitoring system always complains=
 that some disks&#39; usage exceed 85%. I log into the system and find out =
that some disks&#39; usage are really very high, but some are not(less than=
 60%). Each time when the issue happens, I have to manually re-balance the =
distribution. This is a short-term solution, I&#39;m not willing to do it a=
ll the time.</div><div><br></div><div>Two long-term solutions come in my mi=
nd,=C2=A0</div><div>1) Ask the customers to expand their clusters by adding=
 more OSDs. But I think they will ask me to explain the reason of the imbal=
ance data distribution. We&#39;ve already done some analysis on the environ=
ment, we learned that the most imbalance part in the CRUSH is the mapping b=
etween object and pg. The biggest pg has 613 objects, while the smallest pg=
 only has 226 objects.=C2=A0</div><div><br></div><div>2) Increase the numbe=
r of placement groups. It can be of great help for statistically uniform da=
ta distribution, but it can also incur significant data movement as PGs are=
 effective being split. I just cannot do it in our customers&#39; environme=
nt before we 100% understand the consequence. So anyone did this under a pr=
oduction environment? How much does this operation affect the performance o=
f Clients?</div><div><br></div><div>Any comments/help/suggestions will be h=
ighly appreciated.</div><div><br></div>-- <br><div class=3D"gmail_signature=
"><div>Best Regards<br></div><div>Jevon</div></div>
</div>

--047d7bd755c4482c87051c638647--

--===============1081608113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1081608113==--
