From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <philipp.jaeger@cgm.com>
Subject: AW: RadosGW- Admin API
Date: Thu, 24 Apr 2014 11:17:01 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA56048E127BF7@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
	<CABBk=J_0zwDqMgaVaCdvboG=o+g-oqqOV196ZLxATydF-SdnWg@mail.gmail.com>
	<5EFBD28BA42C604BB012164C72CA56048E113D52@SMBXKO3.cgm.ag>
 <CABBk=J_ZfwdQifRDfb4ePdzOf+_nQ34uZPKk=CD3UJ18nDp_nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:59303 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbaDXLRF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Apr 2014 07:17:05 -0400
In-Reply-To: <CABBk=J_ZfwdQifRDfb4ePdzOf+_nQ34uZPKk=CD3UJ18nDp_nQ@mail.gmail.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Yehuda,

sorry for that, new logs:


Debug developer:
[DEBUG] conn.DefaultClientConnection                                 - =
Receiving response: HTTP/1.1 403 Forbidden
[DEBUG] org.apache.http.headers                                      - =
<< HTTP/1.1 403 Forbidden
[DEBUG] org.apache.http.headers                                      - =
<< Date: Mon, 14 Apr 2014 07:04:13 GMT
[DEBUG] org.apache.http.headers                                      - =
<< Server: Apache/2.2.22 (Ubuntu)
[DEBUG] org.apache.http.headers                                      - =
<< Accept-Ranges: bytes
[DEBUG] org.apache.http.headers                                      - =
<< Content-Length: 23
[DEBUG] org.apache.http.headers                                      - =
<< Keep-Alive: timeout=3D5, max=3D100
[DEBUG] org.apache.http.headers                                      - =
<< Connection: Keep-Alive
[DEBUG] org.apache.http.headers                                      - =
<< Content-Type: application/json
[DEBUG] client.DefaultHttpClient                                     - =
Connection can be kept alive for 5000 MILLISECONDS
[DEBUG] org.apache.http.wire                                         - =
<< "{"Code":"AccessDenied"}"


radosgw.log

2014-04-24 13:06:04.680210 7fba44665780 20 enqueued request req=3D0x253=
1e20
2014-04-24 13:06:04.680277 7fba44665780 20 RGWWQ:
2014-04-24 13:06:04.680281 7fba44665780 20 req: 0x2531e20
2014-04-24 13:06:04.680290 7fba44665780 10 allocated request req=3D0x25=
321e0
2014-04-24 13:06:04.680337 7fba08ff1700 20 dequeued request req=3D0x253=
1e20
2014-04-24 13:06:04.680348 7fba08ff1700 20 RGWWQ: empty
2014-04-24 13:06:04.680363 7fba08ff1700  1 =3D=3D=3D=3D=3D=3D starting =
new request req=3D0x2531e20 =3D=3D=3D=3D=3D
2014-04-24 13:06:04.680471 7fba08ff1700  2 req 2:0.000109::::initializi=
ng
2014-04-24 13:06:04.680497 7fba08ff1700 10 host=3D172.25.3.12 rgw_dns_n=
ame=3DHAPPKO25.cgm.ag
2014-04-24 13:06:04.680622 7fba08ff1700 20 FCGI_ROLE=3DRESPONDER
2014-04-24 13:06:04.680630 7fba08ff1700 20 SCRIPT_URL=3D/admin/user
2014-04-24 13:06:04.680635 7fba08ff1700 20 SCRIPT_URI=3Dhttps://172.25.=
3.12/admin/user
2014-04-24 13:06:04.680639 7fba08ff1700 20 HTTP_AUTHORIZATION=3DAWS NQY=
41E90E38HKJXV6DFM:YaHru0FheiTySH1y7Ek+cENSR44=3D
2014-04-24 13:06:04.680643 7fba08ff1700 20 HTTPS=3Don
2014-04-24 13:06:04.680647 7fba08ff1700 20 HTTP_HOST=3D172.25.3.12
2014-04-24 13:06:04.680663 7fba08ff1700 20 HTTP_USER_AGENT=3Daws-sdk-ja=
va/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/25.5-b02
2014-04-24 13:06:04.680671 7fba08ff1700 20 HTTP_DATE=3DThu, 24 Apr 2014=
 11:05:49 GMT
2014-04-24 13:06:04.680674 7fba08ff1700 20 CONTENT_TYPE=3Dapplication/x=
-www-form-urlencoded; charset=3Dutf-8
2014-04-24 13:06:04.680677 7fba08ff1700 20 HTTP_CONNECTION=3DKeep-Alive
2014-04-24 13:06:04.680680 7fba08ff1700 20 PATH=3D/usr/local/bin:/usr/b=
in:/bin
2014-04-24 13:06:04.680683 7fba08ff1700 20 SERVER_SIGNATURE=3D
2014-04-24 13:06:04.680686 7fba08ff1700 20 SERVER_SOFTWARE=3DApache/2.2=
=2E22 (Ubuntu)
2014-04-24 13:06:04.680689 7fba08ff1700 20 SERVER_NAME=3D172.25.3.12
2014-04-24 13:06:04.680693 7fba08ff1700 20 SERVER_ADDR=3D172.25.3.12
2014-04-24 13:06:04.680697 7fba08ff1700 20 SERVER_PORT=3D443
2014-04-24 13:06:04.680701 7fba08ff1700 20 REMOTE_ADDR=3D10.0.49.80
2014-04-24 13:06:04.680705 7fba08ff1700 20 DOCUMENT_ROOT=3D/var/www
2014-04-24 13:06:04.680708 7fba08ff1700 20 SERVER_ADMIN=3Dedv@cgm.com
2014-04-24 13:06:04.680711 7fba08ff1700 20 SCRIPT_FILENAME=3D/var/www/s=
3gw.fcgi
2014-04-24 13:06:04.680715 7fba08ff1700 20 REMOTE_PORT=3D55225
2014-04-24 13:06:04.680718 7fba08ff1700 20 GATEWAY_INTERFACE=3DCGI/1.1
2014-04-24 13:06:04.680722 7fba08ff1700 20 SERVER_PROTOCOL=3DHTTP/1.1
2014-04-24 13:06:04.680726 7fba08ff1700 20 REQUEST_METHOD=3DGET
2014-04-24 13:06:04.680730 7fba08ff1700 20 QUERY_STRING=3Dpage=3Dadmin&=
params=3D/user&format=3Djson
2014-04-24 13:06:04.680733 7fba08ff1700 20 REQUEST_URI=3D/admin/user?fo=
rmat=3Djson
2014-04-24 13:06:04.680744 7fba08ff1700 20 SCRIPT_NAME=3D/admin/user
2014-04-24 13:06:04.680755 7fba08ff1700  2 req 2:0.000393::GET /admin/u=
ser::getting op
2014-04-24 13:06:04.680768 7fba08ff1700  2 req 2:0.000407::GET /admin/u=
ser:get_user_info:authorizing
2014-04-24 13:06:04.680876 7fba08ff1700 20 get_obj_state: rctx=3D0x7fba=
280066b0 obj=3D.users:NQY41E90E38HKJXV6DFM state=3D0x7fba28006768 s->pr=
efetch_data=3D0
2014-04-24 13:06:04.680904 7fba08ff1700 10 moving .users+NQY41E90E38HKJ=
XV6DFM to cache LRU end
2014-04-24 13:06:04.680909 7fba08ff1700 10 cache get: name=3D.users+NQY=
41E90E38HKJXV6DFM : type miss (requested=3D6, cached=3D3)
2014-04-24 13:06:04.689714 7fba08ff1700 10 cache put: name=3D.users+NQY=
41E90E38HKJXV6DFM
2014-04-24 13:06:04.689731 7fba08ff1700 10 moving .users+NQY41E90E38HKJ=
XV6DFM to cache LRU end
2014-04-24 13:06:04.689748 7fba08ff1700 20 get_obj_state: s->obj_tag wa=
s set empty
2014-04-24 13:06:04.689763 7fba08ff1700 10 moving .users+NQY41E90E38HKJ=
XV6DFM to cache LRU end
2014-04-24 13:06:04.689767 7fba08ff1700 10 cache get: name=3D.users+NQY=
41E90E38HKJXV6DFM : hit
2014-04-24 13:06:04.689905 7fba08ff1700 20 get_obj_state: rctx=3D0x7fba=
280066b0 obj=3D.users.uid:connect state=3D0x7fba28007188 s->prefetch_da=
ta=3D0
2014-04-24 13:06:04.689929 7fba08ff1700 10 moving .users.uid+connect to=
 cache LRU end
2014-04-24 13:06:04.689933 7fba08ff1700 10 cache get: name=3D.users.uid=
+connect : type miss (requested=3D6, cached=3D3)
2014-04-24 13:06:04.692132 7fba08ff1700 10 cache put: name=3D.users.uid=
+connect
2014-04-24 13:06:04.692143 7fba08ff1700 10 moving .users.uid+connect to=
 cache LRU end
2014-04-24 13:06:04.692154 7fba08ff1700 20 get_obj_state: s->obj_tag wa=
s set empty
2014-04-24 13:06:04.692167 7fba08ff1700 10 moving .users.uid+connect to=
 cache LRU end
2014-04-24 13:06:04.692171 7fba08ff1700 10 cache get: name=3D.users.uid=
+connect : hit
2014-04-24 13:06:04.692266 7fba08ff1700 10 get_canon_resource(): dest=3D=
/admin/user
2014-04-24 13:06:04.692273 7fba08ff1700 10 auth_hdr:
GET
application/x-www-form-urlencoded; charset=3Dutf-8
Thu, 24 Apr 2014 11:05:49 GMT
/admin/user
2014-04-24 13:06:04.692509 7fba08ff1700 15 b64=3DC42JUJ9LOM8fa9WaHSu8ij=
EwpHI=3D
2014-04-24 13:06:04.692518 7fba08ff1700 15 auth_sign=3DYaHru0FheiTySH1y=
7Ek+cENSR44=3D
2014-04-24 13:06:04.692521 7fba08ff1700 15 compare=3D22
2014-04-24 13:06:04.692527 7fba08ff1700 10 failed to authorize request
2014-04-24 13:06:04.693049 7fba08ff1700  2 req 2:0.012687::GET /admin/u=
ser:get_user_info:http status=3D403
2014-04-24 13:06:04.694861 7fba08ff1700  1 =3D=3D=3D=3D=3D=3D req done =
req=3D0x2531e20 http_status=3D403 =3D=3D=3D=3D=3D=3D


=20

-----Urspr=FCngliche Nachricht-----
Von: Yehuda Sadeh [mailto:yehuda@inktank.com]=20
Gesendet: Freitag, 11. April 2014 18:12
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: RadosGW- Admin API

You're running Bobtail, this functionality only appeared on Cuttlefish.

Yehuda


On Fri, Apr 11, 2014 at 2:28 AM, J=E4ger, Philipp <philipp.jaeger@cgm.c=
om> wrote:
> Hello yehuda,
>
> Please have a look:
>
> /etc/ceph/ceph.conf
>
> [client.radosgw.gateway]
> host =3D <hostname>
> log file =3D /var/log/ceph/radosgw.log
> rgw dns name =3D <fqdn>
> rgw print continue=3D true
> rgw enable ops log =3D true
> rgw enable usage log =3D true
> admin socket =3D /tmp/radosgw.adsock
> debug rgw=3D20
>
> /var/log/apache2/access.log
> [11/Apr/2014:09:14:40 +0200] "GET /admin/user?format=3Djson HTTP/1.1"=
 405 1896 "-" "aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Clien=
t_VM/23.21-b01"
>
> /var/log/ceph/radosgw.log
> 2014-04-11 09:07:04.692526 7fe0ca076700  0 -- 172.25.3.12:0/1025431 >=
> 172.25.3.12:6789/0 pipe(0x7fe0b0015820 sd=3D12 :0 pgs=3D0 cs=3D0 l=3D=
1).fault
> 2014-04-11 09:07:07.414199 7fe0b87f8700  0 -- 172.25.3.12:0/1025431 >=
> 172.25.3.12:6801/26141 pipe(0x7fe0b00180a0 sd=3D13 :0 pgs=3D0 cs=3D0 =
l=3D1).fault
> 2014-04-11 09:07:15.540562 7f995c46e780  0 ceph version 0.56.1 (e4a54=
1624df62ef353e754391cbbb707f54b16f7), process radosgw, pid 27051
> 2014-04-11 09:07:15.561118 7f994ac91700  2 garbage collection: start
> 2014-04-11 09:07:21.474434 7f995c46e780 10 allocated request req=3D0x=
20d8e30
> 2014-04-11 09:07:21.873066 7f994ac91700  2 garbage collection: stop
> 2014-04-11 09:07:50.739178 7f995c46e780 20 enqueued request req=3D0x2=
0d8e30
> 2014-04-11 09:07:50.739222 7f995c46e780 20 RGWWQ:
> 2014-04-11 09:07:50.739227 7f995c46e780 20 req: 0x20d8e30
> 2014-04-11 09:07:50.739239 7f995c46e780 10 allocated request req=3D0x=
20df730
> 2014-04-11 09:07:50.739469 7f9911fcb700 20 dequeued request req=3D0x2=
0d8e30
> 2014-04-11 09:07:50.739489 7f9911fcb700 20 RGWWQ: empty
> 2014-04-11 09:07:50.739511 7f9911fcb700  1 =3D=3D=3D=3D=3D=3D startin=
g new request req=3D0x20d8e30 =3D=3D=3D=3D=3D
> 2014-04-11 09:07:50.739615 7f9911fcb700  2 req 1:0.000104::::initiali=
zing
> 2014-04-11 09:07:50.739680 7f9911fcb700 10 host=3D<hostname> rgw_dns_=
name=3D<fqdn>
> 2014-04-11 09:07:50.759827 7f9911fcb700  5 nothing to log for operati=
on
> 2014-04-11 09:07:50.759876 7f9911fcb700  2 req 1:0.020365::GET /admin=
/user::http status=3D405
> 2014-04-11 09:07:50.761521 7f9911fcb700  1 =3D=3D=3D=3D=3D=3D req don=
e req=3D0x20d8e30 http_status=3D405 =3D=3D=3D=3D=3D=3D
> 2014-04-11 09:07:51.469971 7f994ffff700  0 WARNING: RGWRados::log_usa=
ge(): user name empty (bucket=3D), skipping
>
> Thanks
>
> Regards
>
> Philipp
>
>
> -----Urspr=FCngliche Nachricht-----
> Von: Yehuda Sadeh [mailto:yehuda@inktank.com]
> Gesendet: Donnerstag, 3. April 2014 17:55
> An: J=E4ger, Philipp
> Cc: ceph-devel@vger.kernel.org
> Betreff: Re: RadosGW- Admin API
>
> (resending to mailing list)
>
> Could be a more basic issue, can you turn on 'debug rgw =3D 20', and =
provide the corresponding log?
>
> Yehuda
>
> On Thu, Apr 3, 2014 at 3:51 AM, J=E4ger, Philipp <philipp.jaeger@cgm.=
com> wrote:
>> Hello yehuda,
>>
>> we want to administrate the rados users via the admin api.
>> http://ceph.com/docs/master/radosgw/adminops/#get-user-info
>>
>>
>> We got the following logs from the developer, see line " Receiving r=
esponse: HTTP/1.1 405 Method Not Allowed":
>>
>> [DEBUG] internal.S3Signer                                           =
 - Calculated string to sign:
>> "GET
>>
>> application/x-www-form-urlencoded; charset=3Dutf-8 Mon, 31 Mar 2014
>> 11:25:58 GMT //"
>> [DEBUG] com.amazonaws.request                                       =
 - Sending Request: GET https://172.25.3.12 /admin/user?format=3Djson&u=
id=3Dtest Headers: (Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/kh=
=46uR875Fx+rexmyuo=3D, Date: Mon, 31 Mar 2014 11:25:58 GMT, User-Agent:=
 aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01=
, Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8, )
>> [DEBUG] conn.BasicClientConnectionManager                           =
 - Get connection for route {s}->https://172.25.3.12
>> [DEBUG] conn.DefaultClientConnectionOperator                        =
 - Connecting to 172.25.3.12:443
>> [DEBUG] protocol.RequestAddCookies                                  =
 - CookieSpec selected: best-match
>> [DEBUG] protocol.RequestAuthCache                                   =
 - Auth cache not set in the context
>> [DEBUG] protocol.RequestProxyAuthentication                         =
 - Proxy auth state: UNCHALLENGED
>> [DEBUG] client.DefaultHttpClient                                    =
 - Attempt 1 to execute request
>> [DEBUG] conn.DefaultClientConnection                                =
 - Sending request: GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
>> [DEBUG] org.apache.http.wire                                        =
 - >> "GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "Host: 172.25.3.12[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexm=
yuo=3D[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "Date: Mon, 31 Mar 2014 11:25:58 GMT[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_C=
lient_VM/23.21-b01[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8=
[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "Connection: Keep-Alive[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - >> "[\r][\n]"
>> [DEBUG] org.apache.http.headers                                     =
 - >> GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
>> [DEBUG] org.apache.http.headers                                     =
 - >> Host: 172.25.3.12
>> [DEBUG] org.apache.http.headers                                     =
 - >> Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmy=
uo=3D
>> [DEBUG] org.apache.http.headers                                     =
 - >> Date: Mon, 31 Mar 2014 11:25:58 GMT
>> [DEBUG] org.apache.http.headers                                     =
 - >> User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Cl=
ient_VM/23.21-b01
>> [DEBUG] org.apache.http.headers                                     =
 - >> Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8
>> [DEBUG] org.apache.http.headers                                     =
 - >> Connection: Keep-Alive
>> [DEBUG] org.apache.http.wire                                        =
 - << "HTTP/1.1 405 Method Not Allowed[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Date: Mon, 31 Mar 2014 11:26:20 GMT[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Server: Apache/2.2.22 (Ubuntu)[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Accept-Ranges: bytes[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Content-Length: 27[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Keep-Alive: timeout=3D5, max=3D100[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Connection: Keep-Alive[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "Content-Type: application/json[\r][\n]"
>> [DEBUG] org.apache.http.wire                                        =
 - << "[\r][\n]"
>> [DEBUG] conn.DefaultClientConnection                                =
 - Receiving response: HTTP/1.1 405 Method Not Allowed
>> [DEBUG] org.apache.http.headers                                     =
 - << HTTP/1.1 405 Method Not Allowed
>> [DEBUG] org.apache.http.headers                                     =
 - << Date: Mon, 31 Mar 2014 11:26:20 GMT
>> [DEBUG] org.apache.http.headers                                     =
 - << Server: Apache/2.2.22 (Ubuntu)
>> [DEBUG] org.apache.http.headers                                     =
 - << Accept-Ranges: bytes
>> [DEBUG] org.apache.http.headers                                     =
 - << Content-Length: 27
>> [DEBUG] org.apache.http.headers                                     =
 - << Keep-Alive: timeout=3D5, max=3D100
>> [DEBUG] org.apache.http.headers                                     =
 - << Connection: Keep-Alive
>> [DEBUG] org.apache.http.headers                                     =
 - << Content-Type: application/json
>> [DEBUG] client.DefaultHttpClient                                    =
 - Connection can be kept alive for 5000 MILLISECONDS
>>
>>
>>
>> Do you know where the mistake is or how we can identify it?
>>
>> The user has the following caps:
>>   "caps": [
>>         { "type": "users",
>>           "perm": "*"}]}
>>
>> Is there something else to configure?
>>
>>
>> Thank you very much.
>>
>> Regards
>> Philipp
>>
>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
