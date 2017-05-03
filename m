From: yiming xie <platoxym-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Help! create the secondary zone group failed!
Date: Wed, 3 May 2017 15:04:49 +0800
Message-ID: <7EE1EAEE-D974-4880-8486-26D9A71FCA09@gmail.com>
References: <C5A95B7C-8DB5-4CE1-B10B-1469336B67AC@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/mixed; boundary="===============1468048588=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <C5A95B7C-8DB5-4CE1-B10B-1469336B67AC-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1468048588==
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_146F2EDB-E8C3-4964-B2E0-DA98764CFAB8"


--Apple-Mail=_146F2EDB-E8C3-4964-B2E0-DA98764CFAB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


>    I try to create two zone groups, but I have a problem.
>    I do not know where there was a mistake in this process.
>=20
> 1.create the firstr zone group on the c1 cluster
> ./bin/radosgw-admin -c ./run/c1/ceph.conf realm create =
--rgw-realm=3Dearth --default
> ./bin/radosgw-admin -c ./run/c1/ceph.conf zonegroup create =
--rgw-zonegroup=3Dus --endpoints=3Dhttp://localhost:8001 =
<http://localhost:8001/> --master --default
>=20
> ./bin/radosgw-admin -c ./run/c1/ceph.conf zone create =
--rgw-zonegroup=3Dus --rgw-zone=3Dus-1 --endpoints=3Dhttp://localhost:8001=
 <http://localhost:8001/> --master --default =
--access-key=3D$SYSTEM_ACCESS_KEY --secret=3D$SYSTEM_SECRET_KEY
> ./bin/radosgw-admin -c ./run/c1/ceph.conf user create --uid=3Dzone.user =
--display-name=3D"Zone User" --access-key=3D$SYSTEM_ACCESS_KEY =
--secret=3D$SYSTEM_SECRET_KEY --system
> ./bin/radosgw-admin -c ./run/c1/ceph.conf period update --commit
> //start rgw
> ./bin/radosgw -c ./run/c1/ceph.conf --log-file=3D./run/c1/out/rgw.log =
--debug-rgw=3D20 --debug-ms=3D1 -i client.rgw.us =
<http://client.rgw.us/>-1 -rgw-zone=3Dus-1
>=20
> 2.create the scondary zone group on the c2 cluster
> ./bin/radosgw-admin -c ./run/c2/ceph.conf realm pull =
--url=3Dhttp://localhost:8001 <http://localhost:8001/> =
--access-key=3D$SYSTEM_ACCESS_KEY --secret=3D$SYSTEM_SECRET_KEY
> ./bin/radosgw-admin -c ./run/c2/ceph.conf zonegroup create =
--rgw-zonegroup=3Dus2 --endpoints=3Dhttp://localhost:8002 =
<http://localhost:8002/> --rgw-realm=3Dearth
> ./bin/radosgw-admin -c ./run/c2/ceph.conf period update --commit =
--rgw-zonegroup=3Dus2 --rgw-realm=3Dearth
>=20
> 2017-05-03 00:51:20.190417 7f538dbbb6c0  1 Cannot find zone id=3D =
(name=3D), switching to local zonegroup configuration
> 2017-05-03 00:51:20.192342 7f538dbbb6c0 -1 Cannot find zone id=3D =
(name=3D)
> couldn't init storage provider
>=20
> Tks!
>=20


--Apple-Mail=_146F2EDB-E8C3-4964-B2E0-DA98764CFAB8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><div style=3D"margin: =
0px; line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, =
69, 69);" class=3D"">&nbsp; &nbsp;I try to create two zone groups, but I =
have a problem.</div><div style=3D"margin: 0px; line-height: normal; =
font-family: 'Helvetica Neue'; color: rgb(69, 69, 69);" class=3D""><span =
style=3D"" class=3D"">&nbsp; &nbsp;I do not know where there was a =
mistake in this process.</span></div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D""><br class=3D""></div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D"">1.create the firstr zone group on the c1 =
cluster</div><div style=3D"margin: 0px; line-height: normal; =
font-family: 'Helvetica Neue'; color: rgb(69, 69, 69);" =
class=3D"">./bin/radosgw-admin -c ./run/c1/ceph.conf realm create =
--rgw-realm=3Dearth --default</div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D"">./bin/radosgw-admin -c ./run/c1/ceph.conf zonegroup =
create --rgw-zonegroup=3Dus --endpoints=3D<a =
href=3D"http://localhost:8001/" class=3D"">http://localhost:8001</a> =
--master --default</div><div style=3D"margin: 0px; line-height: normal; =
font-family: 'Helvetica Neue'; color: rgb(69, 69, 69); min-height: =
14px;" class=3D""><br class=3D""></div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D"">./bin/radosgw-admin -c ./run/c1/ceph.conf zone create =
--rgw-zonegroup=3Dus --rgw-zone=3Dus-1 --endpoints=3D<a =
href=3D"http://localhost:8001/" class=3D"">http://localhost:8001</a> =
--master --default --access-key=3D$SYSTEM_ACCESS_KEY =
--secret=3D$SYSTEM_SECRET_KEY</div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D"">./bin/radosgw-admin -c ./run/c1/ceph.conf user create =
--uid=3Dzone.user --display-name=3D"Zone User" =
--access-key=3D$SYSTEM_ACCESS_KEY --secret=3D$SYSTEM_SECRET_KEY =
--system</div><div style=3D"margin: 0px; line-height: normal; =
font-family: 'Helvetica Neue'; color: rgb(69, 69, 69);" =
class=3D"">./bin/radosgw-admin -c ./run/c1/ceph.conf period update =
--commit</div><div style=3D"margin: 0px; line-height: normal; =
font-family: 'Helvetica Neue'; color: rgb(69, 69, 69);" class=3D""><div =
style=3D"margin: 0px; line-height: normal;" class=3D"">//start =
rgw</div><div style=3D"margin: 0px; line-height: normal;" =
class=3D"">./bin/radosgw -c ./run/c1/ceph.conf =
--log-file=3D./run/c1/out/rgw.log --debug-rgw=3D20 --debug-ms=3D1 -i <a =
href=3D"http://client.rgw.us/" class=3D"">client.rgw.us</a>-1 =
-rgw-zone=3Dus-1</div><div style=3D"margin: 0px; line-height: normal;" =
class=3D""><br class=3D""></div></div><div style=3D"margin: 0px; =
line-height: normal; font-family: 'Helvetica Neue'; color: rgb(69, 69, =
69);" class=3D"">2.create the scondary zone group on the c2 =
cluster</div><div style=3D"margin: 0px; line-height: normal;" =
class=3D""><div style=3D"color: rgb(69, 69, 69); font-family: 'Helvetica =
Neue'; margin: 0px; line-height: normal;" class=3D"">./bin/radosgw-admin =
-c ./run/c2/ceph.conf realm pull --url=3D<a =
href=3D"http://localhost:8001/" class=3D"">http://localhost:8001</a> =
--access-key=3D$SYSTEM_ACCESS_KEY --secret=3D$SYSTEM_SECRET_KEY</div><div =
style=3D"color: rgb(69, 69, 69); font-family: 'Helvetica Neue'; margin: =
0px; line-height: normal;" class=3D"">./bin/radosgw-admin -c =
./run/c2/ceph.conf zonegroup create --rgw-zonegroup=3Dus2 --endpoints=3D<a=
 href=3D"http://localhost:8002/" class=3D"">http://localhost:8002</a> =
--rgw-realm=3Dearth</div><div style=3D"margin: 0px; line-height: =
normal;" class=3D""><div style=3D"color: rgb(69, 69, 69); font-family: =
'Helvetica Neue'; margin: 0px; line-height: normal;" =
class=3D"">./bin/radosgw-admin -c ./run/c2/ceph.conf period update =
--commit --rgw-zonegroup=3Dus2&nbsp;--rgw-realm=3Dearth</div><div =
style=3D"color: rgb(69, 69, 69); font-family: 'Helvetica Neue'; margin: =
0px; line-height: normal;" class=3D""><br class=3D""></div><div =
style=3D"margin: 0px; line-height: normal;" class=3D""><div =
style=3D"margin: 0px; line-height: normal;" class=3D""><font =
face=3D"Helvetica Neue" color=3D"#ff2600" class=3D"">2017-05-03 =
00:51:20.190417 7f538dbbb6c0 &nbsp;1 Cannot find zone id=3D (name=3D), =
switching to local zonegroup configuration</font></div><div =
style=3D"margin: 0px; line-height: normal;" class=3D""><font =
face=3D"Helvetica Neue" color=3D"#ff2600" class=3D"">2017-05-03 =
00:51:20.192342 7f538dbbb6c0 -1 Cannot find zone id=3D =
(name=3D)</font></div><div style=3D"margin: 0px; line-height: normal;" =
class=3D""><font face=3D"Helvetica Neue" color=3D"#ff2600" =
class=3D"">couldn't init storage provider</font></div><div =
style=3D"margin: 0px; line-height: normal;" class=3D""><br =
class=3D""></div><div style=3D"margin: 0px; line-height: normal;" =
class=3D"">Tks!</div><div style=3D"color: rgb(69, 69, 69); font-family: =
'Helvetica Neue';" class=3D""><br =
class=3D""></div></div></div></div></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_146F2EDB-E8C3-4964-B2E0-DA98764CFAB8--

--===============1468048588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1468048588==--
