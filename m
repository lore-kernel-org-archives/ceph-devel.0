From: sandyxu4999 <sandyxu4999-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Rgw potential security issue
Date: Mon, 7 Sep 2015 16:58:18 +0800
Message-ID: <BLU437-SMTP7D443DB1C2DD33C55EE7ABD540@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0519870815=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0519870815==
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D=22Content-Type=22 content=3D=22text/html;=
 charset=3Dutf-8=22 /></head><body>
        <div id=3D=22contentDescription=22 style=3D=22line-height:1.5;tex=
t-align:justify;text-justify:inter-ideograph=22>
            <div>Hi Cephers,</div><div><br></div><div>Recently when I did=
 some tests of rgw functions I found that the swift key of a subuser is k=
ept after removing the subuser. As a result, this subuser-swift=5Fkey pai=
r can still pass authentication system and get an auth-token (without any=
 permission though). Moreover, if we create a subuser with the same name =
later, the swift key becomes valid again. I know we can actually delete t=
he key by explicitly specifying '--purge-keys', just curious why it is no=
t set as default.</div><div><br></div><div>Any thought or comment=3F</div=
><div><br></div><div>P.S. You may find more information on ceph tracker: =
http://tracker.ceph.com/issues/12890&nbsp;</div><div><br></div><div><br><=
/div><div>Best Regards,</div><div>Sangdi Xu</div>
            =20
        </div>
    </body></html>

--===============0519870815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0519870815==--
