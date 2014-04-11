From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <philipp.jaeger@cgm.com>
Subject: AW: RadosGW- Admin API
Date: Fri, 11 Apr 2014 09:28:04 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA56048E113D52@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
 <CABBk=J_0zwDqMgaVaCdvboG=o+g-oqqOV196ZLxATydF-SdnWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5EFBD28BA42C604BB012164C72CA56048E113D52SMBXKO3cgmag_"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:43071 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbaDKJ2J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 05:28:09 -0400
In-Reply-To: <CABBk=J_0zwDqMgaVaCdvboG=o+g-oqqOV196ZLxATydF-SdnWg@mail.gmail.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--_002_5EFBD28BA42C604BB012164C72CA56048E113D52SMBXKO3cgmag_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello yehuda,

Please have a look:

/etc/ceph/ceph.conf

[client.radosgw.gateway]
host =3D <hostname>
log file =3D /var/log/ceph/radosgw.log
rgw dns name =3D <fqdn>
rgw print continue=3D true
rgw enable ops log =3D true
rgw enable usage log =3D true
admin socket =3D /tmp/radosgw.adsock
debug rgw=3D20

/var/log/apache2/access.log
[11/Apr/2014:09:14:40 +0200] "GET /admin/user?format=3Djson HTTP/1.1" 405 1=
896 "-" "aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21=
-b01"

/var/log/ceph/radosgw.log
2014-04-11 09:07:04.692526 7fe0ca076700  0 -- 172.25.3.12:0/1025431 >> 172.=
25.3.12:6789/0 pipe(0x7fe0b0015820 sd=3D12 :0 pgs=3D0 cs=3D0 l=3D1).fault
2014-04-11 09:07:07.414199 7fe0b87f8700  0 -- 172.25.3.12:0/1025431 >> 172.=
25.3.12:6801/26141 pipe(0x7fe0b00180a0 sd=3D13 :0 pgs=3D0 cs=3D0 l=3D1).fau=
lt
2014-04-11 09:07:15.540562 7f995c46e780  0 ceph version 0.56.1 (e4a541624df=
62ef353e754391cbbb707f54b16f7), process radosgw, pid 27051
2014-04-11 09:07:15.561118 7f994ac91700  2 garbage collection: start
2014-04-11 09:07:21.474434 7f995c46e780 10 allocated request req=3D0x20d8e3=
0
2014-04-11 09:07:21.873066 7f994ac91700  2 garbage collection: stop
2014-04-11 09:07:50.739178 7f995c46e780 20 enqueued request req=3D0x20d8e30
2014-04-11 09:07:50.739222 7f995c46e780 20 RGWWQ:
2014-04-11 09:07:50.739227 7f995c46e780 20 req: 0x20d8e30
2014-04-11 09:07:50.739239 7f995c46e780 10 allocated request req=3D0x20df73=
0
2014-04-11 09:07:50.739469 7f9911fcb700 20 dequeued request req=3D0x20d8e30
2014-04-11 09:07:50.739489 7f9911fcb700 20 RGWWQ: empty
2014-04-11 09:07:50.739511 7f9911fcb700  1 =3D=3D=3D=3D=3D=3D starting new =
request req=3D0x20d8e30 =3D=3D=3D=3D=3D
2014-04-11 09:07:50.739615 7f9911fcb700  2 req 1:0.000104::::initializing
2014-04-11 09:07:50.739680 7f9911fcb700 10 host=3D<hostname> rgw_dns_name=
=3D<fqdn>
2014-04-11 09:07:50.759827 7f9911fcb700  5 nothing to log for operation
2014-04-11 09:07:50.759876 7f9911fcb700  2 req 1:0.020365::GET /admin/user:=
:http status=3D405
2014-04-11 09:07:50.761521 7f9911fcb700  1 =3D=3D=3D=3D=3D=3D req done req=
=3D0x20d8e30 http_status=3D405 =3D=3D=3D=3D=3D=3D
2014-04-11 09:07:51.469971 7f994ffff700  0 WARNING: RGWRados::log_usage(): =
user name empty (bucket=3D), skipping

Thanks

Regards

Philipp


-----Urspr=FCngliche Nachricht-----
Von: Yehuda Sadeh [mailto:yehuda@inktank.com]=20
Gesendet: Donnerstag, 3. April 2014 17:55
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: RadosGW- Admin API

(resending to mailing list)

Could be a more basic issue, can you turn on 'debug rgw =3D 20', and provid=
e the corresponding log?

Yehuda

On Thu, Apr 3, 2014 at 3:51 AM, J=E4ger, Philipp <philipp.jaeger@cgm.com> w=
rote:
> Hello yehuda,
>
> we want to administrate the rados users via the admin api.
> http://ceph.com/docs/master/radosgw/adminops/#get-user-info
>
>
> We got the following logs from the developer, see line " Receiving respon=
se: HTTP/1.1 405 Method Not Allowed":
>
> [DEBUG] internal.S3Signer                                            - Ca=
lculated string to sign:
> "GET
>
> application/x-www-form-urlencoded; charset=3Dutf-8 Mon, 31 Mar 2014=20
> 11:25:58 GMT //"
> [DEBUG] com.amazonaws.request                                        - Se=
nding Request: GET https://172.25.3.12 /admin/user?format=3Djson&uid=3Dtest=
 Headers: (Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexm=
yuo=3D, Date: Mon, 31 Mar 2014 11:25:58 GMT, User-Agent: aws-sdk-java/1.3.2=
7 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01, Content-Type: applica=
tion/x-www-form-urlencoded; charset=3Dutf-8, )
> [DEBUG] conn.BasicClientConnectionManager                            - Ge=
t connection for route {s}->https://172.25.3.12
> [DEBUG] conn.DefaultClientConnectionOperator                         - Co=
nnecting to 172.25.3.12:443
> [DEBUG] protocol.RequestAddCookies                                   - Co=
okieSpec selected: best-match
> [DEBUG] protocol.RequestAuthCache                                    - Au=
th cache not set in the context
> [DEBUG] protocol.RequestProxyAuthentication                          - Pr=
oxy auth state: UNCHALLENGED
> [DEBUG] client.DefaultHttpClient                                     - At=
tempt 1 to execute request
> [DEBUG] conn.DefaultClientConnection                                 - Se=
nding request: GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
> [DEBUG] org.apache.http.wire                                         - >>=
 "GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "Host: 172.25.3.12[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyuo=3D[\r=
][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "Date: Mon, 31 Mar 2014 11:25:58 GMT[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/=
23.21-b01[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "Connection: Keep-Alive[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - >>=
 "[\r][\n]"
> [DEBUG] org.apache.http.headers                                      - >>=
 GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
> [DEBUG] org.apache.http.headers                                      - >>=
 Host: 172.25.3.12
> [DEBUG] org.apache.http.headers                                      - >>=
 Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyuo=3D
> [DEBUG] org.apache.http.headers                                      - >>=
 Date: Mon, 31 Mar 2014 11:25:58 GMT
> [DEBUG] org.apache.http.headers                                      - >>=
 User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/2=
3.21-b01
> [DEBUG] org.apache.http.headers                                      - >>=
 Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8
> [DEBUG] org.apache.http.headers                                      - >>=
 Connection: Keep-Alive
> [DEBUG] org.apache.http.wire                                         - <<=
 "HTTP/1.1 405 Method Not Allowed[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Date: Mon, 31 Mar 2014 11:26:20 GMT[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Server: Apache/2.2.22 (Ubuntu)[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Accept-Ranges: bytes[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Content-Length: 27[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Keep-Alive: timeout=3D5, max=3D100[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Connection: Keep-Alive[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "Content-Type: application/json[\r][\n]"
> [DEBUG] org.apache.http.wire                                         - <<=
 "[\r][\n]"
> [DEBUG] conn.DefaultClientConnection                                 - Re=
ceiving response: HTTP/1.1 405 Method Not Allowed
> [DEBUG] org.apache.http.headers                                      - <<=
 HTTP/1.1 405 Method Not Allowed
> [DEBUG] org.apache.http.headers                                      - <<=
 Date: Mon, 31 Mar 2014 11:26:20 GMT
> [DEBUG] org.apache.http.headers                                      - <<=
 Server: Apache/2.2.22 (Ubuntu)
> [DEBUG] org.apache.http.headers                                      - <<=
 Accept-Ranges: bytes
> [DEBUG] org.apache.http.headers                                      - <<=
 Content-Length: 27
> [DEBUG] org.apache.http.headers                                      - <<=
 Keep-Alive: timeout=3D5, max=3D100
> [DEBUG] org.apache.http.headers                                      - <<=
 Connection: Keep-Alive
> [DEBUG] org.apache.http.headers                                      - <<=
 Content-Type: application/json
> [DEBUG] client.DefaultHttpClient                                     - Co=
nnection can be kept alive for 5000 MILLISECONDS
>
>
>
> Do you know where the mistake is or how we can identify it?
>
> The user has the following caps:
>   "caps": [
>         { "type": "users",
>           "perm": "*"}]}
>
> Is there something else to configure?
>
>
> Thank you very much.
>
> Regards
> Philipp
>
>
>
>

--_002_5EFBD28BA42C604BB012164C72CA56048E113D52SMBXKO3cgmag_
Content-Type: application/x-zip-compressed; name="S3AdminAPI.ZIP"
Content-Description: S3AdminAPI.ZIP
Content-Disposition: attachment; filename="S3AdminAPI.ZIP"; size=8598;
	creation-date="Fri, 11 Apr 2014 09:27:19 GMT";
	modification-date="Fri, 11 Apr 2014 09:27:19 GMT"
Content-Transfer-Encoding: base64

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

--_002_5EFBD28BA42C604BB012164C72CA56048E113D52SMBXKO3cgmag_--
