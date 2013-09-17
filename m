From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: how to use the admin api (get user info)
Date: Tue, 17 Sep 2013 17:20:31 +0800 (CST)
Message-ID: <3e8099e6.122e6.1412b3899c9.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842566952=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, ceph Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1842566952==
Content-Type: multipart/alternative;
	boundary="----=_Part_273588_361328757.1379409631689"

------=_Part_273588_361328757.1379409631689
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

 hi
   i follow the  admin api  document  http://ceph.com/docs/master/radosgw/adminops/ ,
when i get user info , it rentue 405 not allowed
my commond is

curl -XGET http://kp/admin/user?format=json -d'{"uid":"user1"}'  -H'Authoeization:AWS ******:******' -H'Date:******' -i -v
the reasult is
405 Method not allowed , {'code':"MethodNotAllowed"}

the same commd will be work when I get usage, the commod is
curl -XGET http://kp/admin/usage?format=json -d'{"uid":"user1"}'  -H'Authoeization:AWS ******:******' -H'Date:******' -i -v
it will return 200 ok , {"entries":[], "summary"}

my ceph vesion is 0.56.3,
Thank you for your patience !

------=_Part_273588_361328757.1379409631689
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><div><div>&nbsp;hi <br>&nbsp;&nbsp; i follow the&nbsp; admin api&nbsp; document&nbsp; <a href="http://ceph.com/docs/master/radosgw/adminops/" target="_blank">http://ceph.com/docs/master/radosgw/adminops/</a> ,<br>when i get user info , it rentue 405 not allowed<br>my commond is <br><br><b><i>curl -XGET http://kp/admin/user?format=json -d'{"uid":"user1"}'&nbsp; -H'Authoeization:AWS ******:******' -H'Date:******' -i -v</i></b><br>the reasult is <br>405 Method not allowed , {'code':"MethodNotAllowed"}<br><br>the same commd will be work when I get usage, the commod is <br><b><i>curl -XGET http://kp/admin/usage?format=json -d'{"uid":"user1"}'&nbsp; -H'Authoeization:AWS ******:******' -H'Date:******' -i -v</i></b><br>it 
 will return 200 ok , {"entries":[], "summary"}<br><br>my ceph vesion is 0.56.3, <br>Thank you for your patience !<br></div></div></div><br><br><span title="neteasefooter"><span id="netease_m
 ail_footer"></span></span>
------=_Part_273588_361328757.1379409631689--


--===============1842566952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1842566952==--
