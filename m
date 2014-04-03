From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <philipp.jaeger@cgm.com>
Subject: RadosGW- Admin API
Date: Thu, 3 Apr 2014 10:51:53 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA56048E10EA54@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:40053 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaDCLAK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Apr 2014 07:00:10 -0400
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "yehudasa@gmail.com" <yehudasa@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello yehuda,

we want to administrate the rados users via the admin api.
http://ceph.com/docs/master/radosgw/adminops/#get-user-info


We got the following logs from the developer, see line " Receiving response: HTTP/1.1 405 Method Not Allowed":

[DEBUG] internal.S3Signer                                            - Calculated string to sign:
"GET

application/x-www-form-urlencoded; charset=utf-8
Mon, 31 Mar 2014 11:25:58 GMT
//"
[DEBUG] com.amazonaws.request                                        - Sending Request: GET https://172.25.3.12 /admin/user?format=json&uid=test Headers: (Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyuo=, Date: Mon, 31 Mar 2014 11:25:58 GMT, User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01, Content-Type: application/x-www-form-urlencoded; charset=utf-8, ) 
[DEBUG] conn.BasicClientConnectionManager                            - Get connection for route {s}->https://172.25.3.12
[DEBUG] conn.DefaultClientConnectionOperator                         - Connecting to 172.25.3.12:443
[DEBUG] protocol.RequestAddCookies                                   - CookieSpec selected: best-match
[DEBUG] protocol.RequestAuthCache                                    - Auth cache not set in the context
[DEBUG] protocol.RequestProxyAuthentication                          - Proxy auth state: UNCHALLENGED
[DEBUG] client.DefaultHttpClient                                     - Attempt 1 to execute request
[DEBUG] conn.DefaultClientConnection                                 - Sending request: GET /admin/user?format=json&uid=test HTTP/1.1
[DEBUG] org.apache.http.wire                                         - >> "GET /admin/user?format=json&uid=test HTTP/1.1[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "Host: 172.25.3.12[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyuo=[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "Date: Mon, 31 Mar 2014 11:25:58 GMT[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "Content-Type: application/x-www-form-urlencoded; charset=utf-8[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "Connection: Keep-Alive[\r][\n]"
[DEBUG] org.apache.http.wire                                         - >> "[\r][\n]"
[DEBUG] org.apache.http.headers                                      - >> GET /admin/user?format=json&uid=test HTTP/1.1
[DEBUG] org.apache.http.headers                                      - >> Host: 172.25.3.12
[DEBUG] org.apache.http.headers                                      - >> Authorization: AWS NQY41E90E38HKJXV6DFM:/v1NjvtT/khFuR875Fx+rexmyuo=
[DEBUG] org.apache.http.headers                                      - >> Date: Mon, 31 Mar 2014 11:25:58 GMT
[DEBUG] org.apache.http.headers                                      - >> User-Agent: aws-sdk-java/1.3.27 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/23.21-b01
[DEBUG] org.apache.http.headers                                      - >> Content-Type: application/x-www-form-urlencoded; charset=utf-8
[DEBUG] org.apache.http.headers                                      - >> Connection: Keep-Alive
[DEBUG] org.apache.http.wire                                         - << "HTTP/1.1 405 Method Not Allowed[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Date: Mon, 31 Mar 2014 11:26:20 GMT[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Server: Apache/2.2.22 (Ubuntu)[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Accept-Ranges: bytes[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Content-Length: 27[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Keep-Alive: timeout=5, max=100[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Connection: Keep-Alive[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "Content-Type: application/json[\r][\n]"
[DEBUG] org.apache.http.wire                                         - << "[\r][\n]"
[DEBUG] conn.DefaultClientConnection                                 - Receiving response: HTTP/1.1 405 Method Not Allowed
[DEBUG] org.apache.http.headers                                      - << HTTP/1.1 405 Method Not Allowed
[DEBUG] org.apache.http.headers                                      - << Date: Mon, 31 Mar 2014 11:26:20 GMT
[DEBUG] org.apache.http.headers                                      - << Server: Apache/2.2.22 (Ubuntu)
[DEBUG] org.apache.http.headers                                      - << Accept-Ranges: bytes
[DEBUG] org.apache.http.headers                                      - << Content-Length: 27
[DEBUG] org.apache.http.headers                                      - << Keep-Alive: timeout=5, max=100
[DEBUG] org.apache.http.headers                                      - << Connection: Keep-Alive
[DEBUG] org.apache.http.headers                                      - << Content-Type: application/json
[DEBUG] client.DefaultHttpClient                                     - Connection can be kept alive for 5000 MILLISECONDS



Do you know where the mistake is or how we can identify it?

The user has the following caps:
  "caps": [
        { "type": "users",
          "perm": "*"}]}

Is there something else to configure?


Thank you very much.

Regards
Philipp




