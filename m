From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: WG: RadosGW S3 Api
Date: Wed, 30 Jan 2013 15:44:49 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA5604502B0E6B@SMBXKO6.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA5604502B0E1D@SMBXKO6.cgm.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_5EFBD28BA42C604BB012164C72CA5604502B0E6BSMBXKO6cgmag_"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:58181 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab3A3Poz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 10:44:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by SMXKO1.compugroup.com (Postfix) with ESMTP id 046276055
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 16:45:44 +0100 (CET)
Received: from SMXKO1.compugroup.com ([127.0.0.1])
	by localhost (smxko1.compugroup.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWm0M3S9SkaE for <ceph-devel@vger.kernel.org>;
	Wed, 30 Jan 2013 16:45:43 +0100 (CET)
Received: from SCASKO2.cgm.ag (scasko2.cgm.ag [10.0.0.82])
	by SMXKO1.compugroup.com (Postfix) with ESMTPS id A88C8603D
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 16:45:43 +0100 (CET)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA5604502B0E1D@SMBXKO6.cgm.ag>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--_002_5EFBD28BA42C604BB012164C72CA5604502B0E6BSMBXKO6cgmag_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everybody,

we want to set up ceph+radosgw to use it with the S3 API.

So I set it up with this manual:

http://ceph.com/docs/master/radosgw/manual-install/

and this:
http://ceph.com/docs/master/radosgw/config/


At the moment we want to test in our local network, its not published to th=
e internet.

We make a wildcard cname entry in our dns to forward subdomain calls to the=
 server: *.servername.cgm.ag =3D> servername.cgm.ag

We have to activate SSL for an encrypted connection.=20

Our programmer want to connect and create a bucket like its described here:
http://ceph.com/docs/master/radosgw/s3/java/

He gets the following:

"FAILED: createBucket
com.amazonaws.AmazonClientException: Unable to execute HTTP request: peer n=
ot authenticated
=A0=A0=A0=A0=A0=A0 at com.amazonaws.http.AmazonHttpClient.executeHelper(Ama=
zonHttpClient.java:328)
=A0=A0=A0=A0=A0=A0 at com.amazonaws.http.AmazonHttpClient.execute(AmazonHtt=
pClient.java:165)
=A0=A0=A0=A0=A0=A0 at com.amazonaws.services.s3.AmazonS3Client.invoke(Amazo=
nS3Client.java:2949)
=A0=A0=A0=A0=A0=A0 at com.amazonaws.services.s3.AmazonS3Client.createBucket=
(AmazonS3Client.java:616)
=A0=A0=A0=A0=A0=A0 at com.amazonaws.services.s3.AmazonS3Client.createBucket=
(AmazonS3Client.java:538)
=A0=A0=A0=A0=A0=A0 at com.cgm.connect.securefiletransfer.hwb.S3Test.createB=
ucket(S3Test.java:64)
=A0=A0=A0=A0=A0=A0 at sun.reflect.NativeMethodAccessorImpl.invoke0(Native M=
ethod)
=A0=A0=A0=A0=A0=A0 at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMet=
hodAccessorImpl.java:57)
=A0=A0=A0=A0=A0=A0 at sun.reflect.DelegatingMethodAccessorImpl.invoke(Deleg=
atingMethodAccessorImpl.java:43)
=A0=A0=A0=A0=A0=A0 at java.lang.reflect.Method.invoke(Method.java:601)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.MethodInvocationHelper.invokeMeth=
od(MethodInvocationHelper.java:80)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.Invoker.invokeMethod(Invoker.java=
:691)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.Invoker.invokeTestMethod(Invoker.=
java:883)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.Invoker.invokeTestMethods(Invoker=
.java:1208)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.TestMethodWorker.invokeTestMethod=
s(TestMethodWorker.java:127)
=A0=A0=A0=A0=A0=A0 at org.testng.internal.TestMethodWorker.run(TestMethodWo=
rker.java:111)
=A0=A0=A0=A0=A0=A0 at org.testng.TestRunner.privateRun(TestRunner.java:753)
=A0=A0=A0=A0=A0=A0 at org.testng.TestRunner.run(TestRunner.java:613)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunner.runTest(SuiteRunner.java:335)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunner.runSequentially(SuiteRunner.ja=
va:330)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunner.privateRun(SuiteRunner.java:29=
2)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunner.run(SuiteRunner.java:241)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunnerWorker.runSuite(SuiteRunnerWork=
er.java:52)
=A0=A0=A0=A0=A0=A0 at org.testng.SuiteRunnerWorker.run(SuiteRunnerWorker.ja=
va:86)
=A0=A0=A0=A0=A0=A0 at org.testng.TestNG.runSuitesSequentially(TestNG.java:1=
169)
=A0=A0=A0=A0=A0=A0 at org.testng.TestNG.runSuitesLocally(TestNG.java:1094)
=A0=A0=A0=A0=A0=A0 at org.testng.TestNG.run(TestNG.java:1006)
=A0=A0=A0=A0=A0=A0 at org.testng.remote.RemoteTestNG.run(RemoteTestNG.java:=
107)
=A0=A0=A0=A0=A0=A0 at org.testng.remote.RemoteTestNG.initAndRun(RemoteTestN=
G.java:199)
=A0=A0=A0=A0=A0=A0 at org.testng.remote.RemoteTestNG.main(RemoteTestNG.java=
:170)
Caused by: javax.net.ssl.SSLPeerUnverifiedException: peer not authenticated
=A0=A0=A0=A0=A0=A0 at sun.security.ssl.SSLSessionImpl.getPeerCertificates(S=
SLSessionImpl.java:397)
=A0=A0=A0=A0=A0=A0 at org.apache.http.conn.ssl.AbstractVerifier.verify(Abst=
ractVerifier.java:128)
=A0=A0=A0=A0=A0=A0 at org.apache.http.conn.ssl.SSLSocketFactory.connectSock=
et(SSLSocketFactory.java:390)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.conn.DefaultClientConnectionOper=
ator.openConnection(DefaultClientConnectionOperator.java:148)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.conn.AbstractPoolEntry.open(Abst=
ractPoolEntry.java:149)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.conn.AbstractPooledConnAdapter.o=
pen(AbstractPooledConnAdapter.java:121)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.client.DefaultRequestDirector.tr=
yConnect(DefaultRequestDirector.java:561)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.client.DefaultRequestDirector.ex=
ecute(DefaultRequestDirector.java:415)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.client.AbstractHttpClient.execut=
e(AbstractHttpClient.java:820)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.client.AbstractHttpClient.execut=
e(AbstractHttpClient.java:754)
=A0=A0=A0=A0=A0=A0 at org.apache.http.impl.client.AbstractHttpClient.execut=
e(AbstractHttpClient.java:732)
=A0=A0=A0=A0=A0=A0 at com.amazonaws.http.AmazonHttpClient.executeHelper(Ama=
zonHttpClient.java:280)
=A0=A0=A0=A0=A0=A0 ... 29 more

"

Domain: cgm.ag
Name of the server: sg3cephtstko1 =3D sg3cephtstko1.cgm.ag(fqdn)
In the /var/www folder is the s3gw.fcgi script with the command described i=
n the manual.

We have bought a wildcard ssl certificate for our domain, so no problem wit=
h self signed certificates I think.

Radosgw,ceph and apache service is running.


So do you have any ideas where the problem is?

"peer not authenticated" =3D> Is it a problem of SSL or something to do wit=
h the radosgw config?
Is there a possibility to test the functionality that you can say there's n=
o problem with the set up in general, for example a script running on the s=
erver itself?
Is there something we forget or misconfigured?


Thank you very much


Regards

Philipp





--_002_5EFBD28BA42C604BB012164C72CA5604502B0E6BSMBXKO6cgmag_
Content-Type: application/x-zip-compressed; name="ceph.zip"
Content-Description: ceph.zip
Content-Disposition: attachment; filename="ceph.zip"; size=1354;
	creation-date="Wed, 30 Jan 2013 15:30:58 GMT";
	modification-date="Wed, 30 Jan 2013 15:30:58 GMT"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAIxzPkK4bu+UOwMAALgHAAAOAAAAY2VwaC9jZXBoLmNvbmblVV2vEzkMfe78CusW
CZDaadEC+4F4QexK+7Ro4QVVV8LNuNNsM8mQeNoO6P537My0t1zKL9g+tEpsHx8f2+mqdmGN7rYo
JlP4K0TYU0w2eFiWL14A+grW1AdfzaAPHTRdYqBj66yx7Hogj2tHoLESWtmUj9jxljxbg6xIB8tb
uNHLGwngaCmB9bAaM5fFpJioFYwTeIoQ6XNnI1XwGnzwNFoTxb019BOrcVawfzAWq5Cq22Ii3/Bf
6KJHB8l+IbE/Wy6Xmnr6YUuwCc6Fg/U1YEpdIwzpyM9hYx2lXkg1wnKaTxwiwRGZI3SJIDTYChjH
TpKdNHwT1ozWwZO9yvjyadYxdesk7JTlqHEaRcU+K4iVOBGzsEhCKEKzM9RuNwlSAN4ig2UR0zkw
kZApozah86zRrFUIQRj4ggiP0GKUNnQOI/zz/m0GlYwl/EtN2FOOMaFplNOn6afMwmwxotE2qDd/
p82ZnWaO1Do0A8geXSeaabx0di0Acsp9x7aNoY1W+Q5eMx0VRzjmv4KeaQy0pJOhY+AAaEQMziEV
bbBzPOKV8PE0maklYzd9dlKQ+bzZiXyhvZ/Ds6bCM8TqosxK6gl91iKZaNucVVE6tk5H5jrbWRbj
vBzCzfrB93FF+/Q478ZAQDMRmi3oNFqfGL2hV4JEsmQCWxbDoGbS3Lc6pcdNurgcgJLeiu1mvrkp
JvKB6ddL8x0ATM8qaVb1t2kMyGg6Ng/h4mHmg+xsQwOsoF663V2AXhoyssTCOVhr/vNIppOmP4Jt
SOyxIdUzku7/2Pp8GTYqXsxes7wGF7P19RR7N3TvalR5Wju1NsFbWdHZPYRt57JZkVK6APn73bhx
ev8ArVgJSIn6JOqFKJPqX3RqOPEuPCsmje6WhKpFHiVZ5vl9kj9e/vrb78O7Uy5vfwbxP3kp7kde
QXNt44rmMiSr9iOM+5efd5t7kd/Wc1Xntn230PmPQ3dM5F3I7yJVa21elbR514UvVsMfRRmxCqk+
lLXIc8D+trjqvqM+ahmSgNgs1LIY7x4iFLE+iPxmRzyUJTHctIuTm5oKF+pBejHuMS7kPICevOQi
A1WylXnQHzAqTd2UWBfFN1BLAwQUAAAAAADtlipCkg/cVD8AAAA/AAAADAAAAGNlcGgva2V5cmlu
Z1tjbGllbnQuYWRtaW5dCglrZXkgPSBBUUNOQU85UU9JOEpCeEFBY051ZDVGU1NSMThRWXoyWUN3
VzZGdz09ClBLAwQUAAAACAB2eytCVG3KomoAAAB3AAAAHAAAAGNlcGgva2V5cmluZy5yYWRvc2d3
LmdhdGV3YXmLTs7JTM0r0StKTMkvTi/XS08sSS1PrIzl4sxOrVSwVXAMdIr0THMKNHMuL/DPcHR0
TTJxTPIOjShNLPbOKojMSI7MCvQtt7Xl4kxOLChWyM3PA2pSSszJyS9XKFKCiuYXpyCJllcocQEA
UEsBAhQAFAAAAAgAjHM+Qrhu75Q7AwAAuAcAAA4AAAAAAAAAAQAgAAAAAAAAAGNlcGgvY2VwaC5j
b25mUEsBAhQAFAAAAAAA7ZYqQpIP3FQ/AAAAPwAAAAwAAAAAAAAAAQAgAAAAZwMAAGNlcGgva2V5
cmluZ1BLAQIUABQAAAAIAHZ7K0JUbcqiagAAAHcAAAAcAAAAAAAAAAEAIAAAANADAABjZXBoL2tl
eXJpbmcucmFkb3Nndy5nYXRld2F5UEsFBgAAAAADAAMAwAAAAHQEAAAAAA==

--_002_5EFBD28BA42C604BB012164C72CA5604502B0E6BSMBXKO6cgmag_--
