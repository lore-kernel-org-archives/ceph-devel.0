From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW S3 Api
Date: Wed, 30 Jan 2013 08:04:39 -0800
Message-ID: <CAC-hyiGdR8AMMFk41tWgjmYNAqffTd8R8UacdcaFEPErEr=+Rw@mail.gmail.com>
References: <5EFBD28BA42C604BB012164C72CA5604502B0E1D@SMBXKO6.cgm.ag>
	<5EFBD28BA42C604BB012164C72CA5604502B0E6B@SMBXKO6.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35174 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab3A3QEk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 11:04:40 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so1443798ieb.29
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 08:04:40 -0800 (PST)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA5604502B0E6B@SMBXKO6.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 30, 2013 at 7:44 AM, J=E4ger, Philipp <Philipp.Jaeger@cgm.c=
om> wrote:
> Hello everybody,
>
> we want to set up ceph+radosgw to use it with the S3 API.
>
> So I set it up with this manual:
>
> http://ceph.com/docs/master/radosgw/manual-install/
>
> and this:
> http://ceph.com/docs/master/radosgw/config/
>
>
> At the moment we want to test in our local network, its not published=
 to the internet.
>
> We make a wildcard cname entry in our dns to forward subdomain calls =
to the server: *.servername.cgm.ag =3D> servername.cgm.ag
>
> We have to activate SSL for an encrypted connection.
>
> Our programmer want to connect and create a bucket like its described=
 here:
> http://ceph.com/docs/master/radosgw/s3/java/
>
> He gets the following:
>
> "FAILED: createBucket
> com.amazonaws.AmazonClientException: Unable to execute HTTP request: =
peer not authenticated
>        at com.amazonaws.http.AmazonHttpClient.executeHelper(AmazonHtt=
pClient.java:328)
>        at com.amazonaws.http.AmazonHttpClient.execute(AmazonHttpClien=
t.java:165)
>        at com.amazonaws.services.s3.AmazonS3Client.invoke(AmazonS3Cli=
ent.java:2949)
>        at com.amazonaws.services.s3.AmazonS3Client.createBucket(Amazo=
nS3Client.java:616)
>        at com.amazonaws.services.s3.AmazonS3Client.createBucket(Amazo=
nS3Client.java:538)
>        at com.cgm.connect.securefiletransfer.hwb.S3Test.createBucket(=
S3Test.java:64)
>        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
>        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAcc=
essorImpl.java:57)
>        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingM=
ethodAccessorImpl.java:43)
>        at java.lang.reflect.Method.invoke(Method.java:601)
>        at org.testng.internal.MethodInvocationHelper.invokeMethod(Met=
hodInvocationHelper.java:80)
>        at org.testng.internal.Invoker.invokeMethod(Invoker.java:691)
>        at org.testng.internal.Invoker.invokeTestMethod(Invoker.java:8=
83)
>        at org.testng.internal.Invoker.invokeTestMethods(Invoker.java:=
1208)
>        at org.testng.internal.TestMethodWorker.invokeTestMethods(Test=
MethodWorker.java:127)
>        at org.testng.internal.TestMethodWorker.run(TestMethodWorker.j=
ava:111)
>        at org.testng.TestRunner.privateRun(TestRunner.java:753)
>        at org.testng.TestRunner.run(TestRunner.java:613)
>        at org.testng.SuiteRunner.runTest(SuiteRunner.java:335)
>        at org.testng.SuiteRunner.runSequentially(SuiteRunner.java:330=
)
>        at org.testng.SuiteRunner.privateRun(SuiteRunner.java:292)
>        at org.testng.SuiteRunner.run(SuiteRunner.java:241)
>        at org.testng.SuiteRunnerWorker.runSuite(SuiteRunnerWorker.jav=
a:52)
>        at org.testng.SuiteRunnerWorker.run(SuiteRunnerWorker.java:86)
>        at org.testng.TestNG.runSuitesSequentially(TestNG.java:1169)
>        at org.testng.TestNG.runSuitesLocally(TestNG.java:1094)
>        at org.testng.TestNG.run(TestNG.java:1006)
>        at org.testng.remote.RemoteTestNG.run(RemoteTestNG.java:107)
>        at org.testng.remote.RemoteTestNG.initAndRun(RemoteTestNG.java=
:199)
>        at org.testng.remote.RemoteTestNG.main(RemoteTestNG.java:170)
> Caused by: javax.net.ssl.SSLPeerUnverifiedException: peer not authent=
icated
>        at sun.security.ssl.SSLSessionImpl.getPeerCertificates(SSLSess=
ionImpl.java:397)
>        at org.apache.http.conn.ssl.AbstractVerifier.verify(AbstractVe=
rifier.java:128)
>        at org.apache.http.conn.ssl.SSLSocketFactory.connectSocket(SSL=
SocketFactory.java:390)
>        at org.apache.http.impl.conn.DefaultClientConnectionOperator.o=
penConnection(DefaultClientConnectionOperator.java:148)
>        at org.apache.http.impl.conn.AbstractPoolEntry.open(AbstractPo=
olEntry.java:149)
>        at org.apache.http.impl.conn.AbstractPooledConnAdapter.open(Ab=
stractPooledConnAdapter.java:121)
>        at org.apache.http.impl.client.DefaultRequestDirector.tryConne=
ct(DefaultRequestDirector.java:561)
>        at org.apache.http.impl.client.DefaultRequestDirector.execute(=
DefaultRequestDirector.java:415)
>        at org.apache.http.impl.client.AbstractHttpClient.execute(Abst=
ractHttpClient.java:820)
>        at org.apache.http.impl.client.AbstractHttpClient.execute(Abst=
ractHttpClient.java:754)
>        at org.apache.http.impl.client.AbstractHttpClient.execute(Abst=
ractHttpClient.java:732)
>        at com.amazonaws.http.AmazonHttpClient.executeHelper(AmazonHtt=
pClient.java:280)
>        ... 29 more
>
> "
>
> Domain: cgm.ag
> Name of the server: sg3cephtstko1 =3D sg3cephtstko1.cgm.ag(fqdn)
> In the /var/www folder is the s3gw.fcgi script with the command descr=
ibed in the manual.
>
> We have bought a wildcard ssl certificate for our domain, so no probl=
em with self signed certificates I think.
>
> Radosgw,ceph and apache service is running.
>
>
> So do you have any ideas where the problem is?
>
> "peer not authenticated" =3D> Is it a problem of SSL or something to =
do with the radosgw config?
> Is there a possibility to test the functionality that you can say the=
re's no problem with the set up in general, for example a script runnin=
g on the server itself?
> Is there something we forget or misconfigured?
>
>

Does it work without https? Do requests reach the gateway? What does
the radosgw log show? What does the apache access log show?

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
