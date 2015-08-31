From: Abhishek Varshney <abhishek.varshney-ay2nrczjKqVWk0Htik3J/w@public.gmane.org>
Subject: .rgw.root and .rgw pools
Date: Mon, 31 Aug 2015 18:35:23 +0530
Message-ID: <CAP3mxSxYsLszYBapRrAnw-90B3OhMHktEo_1j0BswF34NcA4UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1060303522=="
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
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1060303522==
Content-Type: multipart/alternative; boundary=047d7b3a91e61dea74051e9b1668

--047d7b3a91e61dea74051e9b1668
Content-Type: text/plain; charset=UTF-8

Hi,

I have been trying to understand the default pools used by the default zone
in a radosgw only configuration and have got a confusion regarding the same.

The documentation here (
http://ceph.com/docs/master/radosgw/config-ref/#pools) says that the set of
default pools include .rgw, while the documentation here (
http://docs.ceph.com/docs/master/radosgw/config/#create-pools) says that
the set of default pools include .rgw.root. PG calc page here (
http://ceph.com/pgcalc/), on the other hand, includes both .rgw and
.rgw.root in the calculation.

I am working on ceph v0.94.2 and the zone map just includes .rgw as
"domain_root". Is this just an inconsistency in the documentation or am I
missing something? Also, it would be nice to have ceph version as an input
in the PG calculation page to avoid such confusion :)

Thanks
Abhishek

-- 


------------------------------------------------------------------------------------------------------------------------------------------

This email and any files transmitted with it are confidential and intended 
solely for the use of the individual or entity to whom they are addressed. 
If you have received this email in error please notify the system manager. 
This message contains confidential information and is intended only for the 
individual named. If you are not the named addressee you should not 
disseminate, distribute or copy this e-mail. Please notify the sender 
immediately by e-mail if you have received this e-mail by mistake and 
delete this e-mail from your system. If you are not the intended recipient 
you are notified that disclosing, copying, distributing or taking any 
action in reliance on the contents of this information is strictly 
prohibited. Although Flipkart has taken reasonable precautions to ensure no 
viruses are present in this email, the company cannot accept responsibility 
for any loss or damage arising from the use of this email or attachments

--047d7b3a91e61dea74051e9b1668
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have been trying to understand th=
e default pools used by the default zone in a radosgw only configuration an=
d have got a confusion regarding the same.</div><div><br></div><div>The doc=
umentation here (<a href=3D"http://ceph.com/docs/master/radosgw/config-ref/=
#pools">http://ceph.com/docs/master/radosgw/config-ref/#pools</a>) says tha=
t the set of default pools include .rgw, while the documentation here (<a h=
ref=3D"http://docs.ceph.com/docs/master/radosgw/config/#create-pools">http:=
//docs.ceph.com/docs/master/radosgw/config/#create-pools</a>) says that the=
 set of default pools include .rgw.root. PG calc page here (<a href=3D"http=
://ceph.com/pgcalc/">http://ceph.com/pgcalc/</a>), on the other hand, inclu=
des both .rgw and .rgw.root in the calculation.=C2=A0</div><div><br></div><=
div>I am working on ceph v0.94.2 and the zone map just includes .rgw as &qu=
ot;domain_root&quot;. Is this just an inconsistency in the documentation or=
 am I missing something? Also, it would be nice to have ceph version as an =
input in the PG calculation page to avoid such confusion :)</div><div><br><=
/div><div>Thanks</div><div>Abhishek</div></div>

<br>
<p>------------------------------<wbr>------------------------------<wbr>--=
----------------------------<wbr>------------------------------<wbr>-------=
-----------</p><p>This email and any files transmitted with it are confiden=
tial and intended solely for the use of the individual or entity to whom th=
ey are addressed. If you have received this email in error please notify th=
e system manager. This message contains confidential information and is int=
ended only for the individual named. If you are not the named addressee you=
 should not disseminate, distribute or copy this e-mail. Please notify the =
sender immediately by e-mail if you have received this e-mail by mistake an=
d delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any act=
ion in reliance on the contents of this information is strictly prohibited.=
 Although Flipkart has taken reasonable precautions to ensure no viruses ar=
e present in this email, the company cannot accept responsibility for any l=
oss or damage arising from the use of this email or attachments</p>
--047d7b3a91e61dea74051e9b1668--

--===============1060303522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1060303522==--
