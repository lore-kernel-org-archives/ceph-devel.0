From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW- Admin API
Date: Thu, 3 Apr 2014 08:55:08 -0700
Message-ID: <CABBk=J_0zwDqMgaVaCdvboG=o+g-oqqOV196ZLxATydF-SdnWg@mail.gmail.com>
References: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:38433 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaDCPzJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Apr 2014 11:55:09 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so2095328vcb.18
        for <ceph-devel@vger.kernel.org>; Thu, 03 Apr 2014 08:55:08 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?J=E4ger=2C_Philipp?= <philipp.jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

(resending to mailing list)

Could be a more basic issue, can you turn on 'debug rgw =3D 20', and
provide the corresponding log?

Yehuda

On Thu, Apr 3, 2014 at 3:51 AM, J=E4ger, Philipp <philipp.jaeger@cgm.co=
m> wrote:
> Hello yehuda,
>
> we want to administrate the rados users via the admin api.
> http://ceph.com/docs/master/radosgw/adminops/#get-user-info
>
>
> We got the following logs from the developer, see line " Receiving re=
sponse: HTTP/1.1 405 Method Not Allowed":
>
> [DEBUG] internal.S3Signer                                            =
- Calculated string to sign:
> "GET
>
> application/x-www-form-urlencoded; charset=3Dutf-8
> Mon, 31 Mar 2014 11:25:58 GMT
> //"
> [DEBUG] com.amazonaws.request                                        =
- Sending Request: GET https://172.25.3.12 /admin/user?format=3Djson&ui=
d=3Dtest Headers: (Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khF=
uR875Fx+rexmyuo=3D, Date: Mon, 31 Mar 2014 11:25:58 GMT, User-Agent: aw=
s-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01, C=
ontent-Type: application/x-www-form-urlencoded; charset=3Dutf-8, )
> [DEBUG] conn.BasicClientConnectionManager                            =
- Get connection for route {s}->https://172.25.3.12
> [DEBUG] conn.DefaultClientConnectionOperator                         =
- Connecting to 172.25.3.12:443
> [DEBUG] protocol.RequestAddCookies                                   =
- CookieSpec selected: best-match
> [DEBUG] protocol.RequestAuthCache                                    =
- Auth cache not set in the context
> [DEBUG] protocol.RequestProxyAuthentication                          =
- Proxy auth state: UNCHALLENGED
> [DEBUG] client.DefaultHttpClient                                     =
- Attempt 1 to execute request
> [DEBUG] conn.DefaultClientConnection                                 =
- Sending request: GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
> [DEBUG] org.apache.http.wire                                         =
- >> "GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "Host: 172.25.3.12[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmy=
uo=3D[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "Date: Mon, 31 Mar 2014 11:25:58 GMT[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Cl=
ient_VM/23.21-b01[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8[=
\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "Connection: Keep-Alive[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- >> "[\r][\n]"
> [DEBUG] org.apache.http.headers                                      =
- >> GET /admin/user?format=3Djson&uid=3Dtest HTTP/1.1
> [DEBUG] org.apache.http.headers                                      =
- >> Host: 172.25.3.12
> [DEBUG] org.apache.http.headers                                      =
- >> Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyu=
o=3D
> [DEBUG] org.apache.http.headers                                      =
- >> Date: Mon, 31 Mar 2014 11:25:58 GMT
> [DEBUG] org.apache.http.headers                                      =
- >> User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Cli=
ent_VM/23.21-b01
> [DEBUG] org.apache.http.headers                                      =
- >> Content-Type: application/x-www-form-urlencoded; charset=3Dutf-8
> [DEBUG] org.apache.http.headers                                      =
- >> Connection: Keep-Alive
> [DEBUG] org.apache.http.wire                                         =
- << "HTTP/1.1 405 Method Not Allowed[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Date: Mon, 31 Mar 2014 11:26:20 GMT[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Server: Apache/2.2.22 (Ubuntu)[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Accept-Ranges: bytes[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Content-Length: 27[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Keep-Alive: timeout=3D5, max=3D100[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Connection: Keep-Alive[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "Content-Type: application/json[\r][\n]"
> [DEBUG] org.apache.http.wire                                         =
- << "[\r][\n]"
> [DEBUG] conn.DefaultClientConnection                                 =
- Receiving response: HTTP/1.1 405 Method Not Allowed
> [DEBUG] org.apache.http.headers                                      =
- << HTTP/1.1 405 Method Not Allowed
> [DEBUG] org.apache.http.headers                                      =
- << Date: Mon, 31 Mar 2014 11:26:20 GMT
> [DEBUG] org.apache.http.headers                                      =
- << Server: Apache/2.2.22 (Ubuntu)
> [DEBUG] org.apache.http.headers                                      =
- << Accept-Ranges: bytes
> [DEBUG] org.apache.http.headers                                      =
- << Content-Length: 27
> [DEBUG] org.apache.http.headers                                      =
- << Keep-Alive: timeout=3D5, max=3D100
> [DEBUG] org.apache.http.headers                                      =
- << Connection: Keep-Alive
> [DEBUG] org.apache.http.headers                                      =
- << Content-Type: application/json
> [DEBUG] client.DefaultHttpClient                                     =
- Connection can be kept alive for 5000 MILLISECONDS
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
