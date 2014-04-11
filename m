From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW- Admin API
Date: Fri, 11 Apr 2014 09:11:43 -0700
Message-ID: <CABBk=J_ZfwdQifRDfb4ePdzOf+_nQ34uZPKk=CD3UJ18nDp_nQ@mail.gmail.com>
References: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
	<CABBk=J_0zwDqMgaVaCdvboG=o+g-oqqOV196ZLxATydF-SdnWg@mail.gmail.com>
	<5EFBD28BA42C604BB012164C72CA56048E113D52@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:39570 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbaDKQLo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 12:11:44 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so4910423veb.5
        for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 09:11:43 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA56048E113D52@SMBXKO3.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?J=E4ger=2C_Philipp?= <philipp.jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
