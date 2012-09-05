From: James Page <james.page@ubuntu.com>
Subject: Initial rest-bench execution failure
Date: Wed, 05 Sep 2012 12:53:51 +0100
Message-ID: <50473D4F.4010903@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37260 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2IELxy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 07:53:54 -0400
Received: from host81-154-14-24.range81-154.btcentralplus.com ([81.154.14.24] helo=[192.168.1.50])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <james.page@ubuntu.com>)
	id 1T9EB6-0007Yv-Ly
	for ceph-devel@vger.kernel.org; Wed, 05 Sep 2012 11:53:52 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm seeing an odd error when executing rest-bench for the first time
against a single node ceph deployment:

prompt> rest-bench --access-key=xxx --secret=yyy --api-host=localhost
write
host=localhost
ERROR: failed to create bucket: ConnectionFailed
failed initializing benchmark

Excerpt from apache2 access.log;
127.0.0.1 - - [05/Sep/2012:12:40:38 +0100] "PUT /rest-bench-bucket/
HTTP/1.1" 200 138 "-" "Mozilla/4.0 (Compatible; rest-bench; libs3 2.0;
Linux x86_64)"

Excerpt from radosgw log file:
2012-09-05 12:40:38.448014 7f5068fc9700 10 cache get:
name=.users+B587ZPR3Z9TCQZY6D7M4 : hit
2012-09-05 12:40:38.448069 7f5068fc9700 10 get_canon_resource():
dest=/rest-bench-bucket/
2012-09-05 12:40:38.448075 7f5068fc9700 10 auth_hdr:
PUT

x-amz-date:Wed, 05 Sep 2012 11:40:38 GMT
/rest-bench-bucket/
2012-09-05 12:40:38.448187 7f5068fc9700 15
b64=skwbg2pHJMbceUantJa1OVut8lk=
2012-09-05 12:40:38.448193 7f5068fc9700 15
auth_sign=skwbg2pHJMbceUantJa1OVut8lk=
2012-09-05 12:40:38.448196 7f5068fc9700 15 compare=0
2012-09-05 12:40:38.448201 7f5068fc9700 2 req 1:0.001795:s3:PUT
/rest-bench-bucket/:create_bucket:reading permissions
2012-09-05 12:40:38.448207 7f5068fc9700 2 req 1:0.001801:s3:PUT
/rest-bench-bucket/:create_bucket:verifying op permissions
2012-09-05 12:40:38.448872 7f5068fc9700 2 req 1:0.002466:s3:PUT
/rest-bench-bucket/:create_bucket:verifying op params
2012-09-05 12:40:38.448888 7f5068fc9700 10 --> Status: 100

2012-09-05 12:40:38.448927 7f5068fc9700 2 req 1:0.002521:s3:PUT
/rest-bench-bucket/:create_bucket:executing
2012-09-05 12:40:38.448966 7f5068fc9700 20 get_obj_state:
rctx=0x7f50a8002160 obj=.rgw:rest-bench-bucket state=0x7f50a8007d38
s->prefetch_data=0
2012-09-05 12:40:38.448975 7f5068fc9700 10 cache get:
name=.rgw+rest-bench-bucket : miss
2012-09-05 12:40:38.449498 7f5068fc9700 10 cache put:
name=.rgw+rest-bench-bucket
2012-09-05 12:40:38.449505 7f5068fc9700 10 adding
.rgw+rest-bench-bucket to cache LRU end
2012-09-05 12:40:38.449538 7f5068fc9700 20 get_obj_state:
rctx=0x7f50a8008fa0 obj=.rgw:.pools.avail state=0x7f50a8008598
s->prefetch_data=0
2012-09-05 12:40:38.449546 7f5068fc9700 10 cache get:
name=.rgw+.pools.avail : miss
2012-09-05 12:40:38.450015 7f5068fc9700 10 cache put:
name=.rgw+.pools.avail
2012-09-05 12:40:38.450020 7f5068fc9700 10 adding .rgw+.pools.avail to
cache LRU end
2012-09-05 12:40:38.778331 7f5068fc9700 15 omap_set bucket=.rgw
oid=.pools.avail key=.rgw.buckets
2012-09-05 12:40:39.223706 7f5068fc9700 10 cache put:
name=.rgw+.pools.avail
2012-09-05 12:40:39.223718 7f5068fc9700 10 moving .rgw+.pools.avail to
cache LRU end
2012-09-05 12:40:39.223744 7f5068fc9700 10 distributing notification
oid=notify bl.length()=174
2012-09-05 12:40:39.224468 7f50c8887700 10 RGWWatcher::notify()
opcode=1 ver=1 bl.length()=174
2012-09-05 12:40:39.224489 7f50c8887700 10 cache put:
name=.rgw+.pools.avail
2012-09-05 12:40:39.224494 7f50c8887700 10 moving .rgw+.pools.avail to
cache LRU end
2012-09-05 12:40:40.454025 7f5068fc9700 10 cache put:
name=.rgw+rest-bench-bucket
2012-09-05 12:40:40.454034 7f5068fc9700 10 moving
.rgw+rest-bench-bucket to cache LRU end
2012-09-05 12:40:40.454038 7f5068fc9700 10 updating xattr:
name=user.rgw.acl bl.length()=143
2012-09-05 12:40:40.454067 7f5068fc9700 10 distributing notification
oid=notify bl.length()=406
2012-09-05 12:40:40.454835 7f50c8887700 10 RGWWatcher::notify()
opcode=1 ver=1 bl.length()=406
2012-09-05 12:40:40.454855 7f50c8887700 10 cache put:
name=.rgw+rest-bench-bucket
2012-09-05 12:40:40.454859 7f50c8887700 10 moving
.rgw+rest-bench-bucket to cache LRU end
2012-09-05 12:40:40.454863 7f50c8887700 10 updating xattr:
name=user.rgw.acl bl.length()=143
2012-09-05 12:40:40.455346 7f5068fc9700 20 store_bucket_info:
bucket=rest-bench-bucket(@.rgw.buckets[4100.1]) owner ubuntu
2012-09-05 12:40:40.455357 7f5068fc9700 20 rgw_create_bucket returned
ret=0 bucket=rest-bench-bucket(@.rgw.buckets[4100.1])
2012-09-05 12:40:40.455372 7f5068fc9700 15 omap_set bucket=.users.uid
oid=ubuntu.buckets key=rest-bench-bucket
2012-09-05 12:40:40.537346 7f5068fc9700 10 --> Status: 200

2012-09-05 12:40:40.537357 7f5068fc9700 10 --> Content-type:
application/xml^M

2012-09-05 12:40:40.891583 7f5068fc9700 2 req 1:2.445176:s3:PUT
/rest-bench-bucket/:create_bucket:http status=200
2012-09-05 12:40:40.891736 7f5068fc9700 1 ====== req done
req=0x7f50d634fe20 http_status=200 ======

rest-bench-bucket also shows up in a 's3 list' output as well.

Subsequent runs of rest-bench work just fine - its just the initial
one that fails.

Any ideas?  It looks like it might be a bug in libs3 as this is where
the ConnectionRefused return code status is set.

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQRz1PAAoJEL/srsug59jD/VEP/A1rwbRkYMb/Pb7p6WGdf+VS
ByNMzaBC43I96ZbTzykWLvnCnWs1WF6XVFnJp69g+bncmGMvt9RMXR9m03V8yeKp
MhFNK70L+bLBi2ZJ6irZ553nFNWkH+e8PoRvuoUffopOa1pD5FzYZfjLPHrCRNhK
wSk3wqD4JrBM3D3n10WcFKfAxXllcE6e0HOPOEMb2XWRSNnf8liJ6jTfdwA36aXw
BPPC51WZA55YywruSPVb7KVlpE/2prqOV5PjghbpQW75MCRu/2Tmw6A+nEUtTBJY
4mQCCKW5EsyZYGQBYcq5dWzdyqpPOxSVrphdnv03AiF1tKcUkP3dZAjX/+U6Kedt
YedshRlcTuMu3WQfuIomIuzlvAhKVYlaYlz2IHVgoc+9z7OAu0Qb9+GnF7FglADF
dlI/DBFaVtyulcLCAV4quVvh8xyLKSIk4mUJsDvrSKaWHEQY3LFZEaJBgHZP1Bvs
/Kx4BL7KZtFZP7gccz+MlgzkinCLEu0YUoFks+/o+eWpnUQt+heab764/fo6CUZC
qhO2goItrKZDUo5ua6vHB5HBcpnWYOAohMNNUJ8MsnJ2Hcc9LLUlAJY+mz9izIha
3p8EzQOeM72TtqqKwKWOFSMISWdhaxKAouLOXXNYcl8tFNTM/Z5+6nyH78VN2PI/
n1XCd0FijPq0U/GTD8NF
=4x5G
-----END PGP SIGNATURE-----
