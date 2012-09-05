From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Initial rest-bench execution failure
Date: Wed, 5 Sep 2012 07:38:19 -0700
Message-ID: <CAC-hyiEicrcTCK9qtRAKkkM4Pc6A7dgHh777VFCTz7Wn3jfs1w@mail.gmail.com>
References: <50473D4F.4010903@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36659 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab2IEOiU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 10:38:20 -0400
Received: by bkwj10 with SMTP id j10so296702bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 07:38:19 -0700 (PDT)
In-Reply-To: <50473D4F.4010903@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 4:53 AM, James Page <james.page@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I'm seeing an odd error when executing rest-bench for the first time
> against a single node ceph deployment:
>
> prompt> rest-bench --access-key=xxx --secret=yyy --api-host=localhost
> write
> host=localhost
> ERROR: failed to create bucket: ConnectionFailed
> failed initializing benchmark
>
> Excerpt from apache2 access.log;
> 127.0.0.1 - - [05/Sep/2012:12:40:38 +0100] "PUT /rest-bench-bucket/
> HTTP/1.1" 200 138 "-" "Mozilla/4.0 (Compatible; rest-bench; libs3 2.0;
> Linux x86_64)"
>
> Excerpt from radosgw log file:
> 2012-09-05 12:40:38.448014 7f5068fc9700 10 cache get:
> name=.users+B587ZPR3Z9TCQZY6D7M4 : hit
> 2012-09-05 12:40:38.448069 7f5068fc9700 10 get_canon_resource():
> dest=/rest-bench-bucket/
> 2012-09-05 12:40:38.448075 7f5068fc9700 10 auth_hdr:
> PUT
>
> x-amz-date:Wed, 05 Sep 2012 11:40:38 GMT
> /rest-bench-bucket/
> 2012-09-05 12:40:38.448187 7f5068fc9700 15
> b64=skwbg2pHJMbceUantJa1OVut8lk=
> 2012-09-05 12:40:38.448193 7f5068fc9700 15
> auth_sign=skwbg2pHJMbceUantJa1OVut8lk=
> 2012-09-05 12:40:38.448196 7f5068fc9700 15 compare=0
> 2012-09-05 12:40:38.448201 7f5068fc9700 2 req 1:0.001795:s3:PUT
> /rest-bench-bucket/:create_bucket:reading permissions
> 2012-09-05 12:40:38.448207 7f5068fc9700 2 req 1:0.001801:s3:PUT
> /rest-bench-bucket/:create_bucket:verifying op permissions
> 2012-09-05 12:40:38.448872 7f5068fc9700 2 req 1:0.002466:s3:PUT
> /rest-bench-bucket/:create_bucket:verifying op params
> 2012-09-05 12:40:38.448888 7f5068fc9700 10 --> Status: 100
>
> 2012-09-05 12:40:38.448927 7f5068fc9700 2 req 1:0.002521:s3:PUT
> /rest-bench-bucket/:create_bucket:executing
> 2012-09-05 12:40:38.448966 7f5068fc9700 20 get_obj_state:
> rctx=0x7f50a8002160 obj=.rgw:rest-bench-bucket state=0x7f50a8007d38
> s->prefetch_data=0
> 2012-09-05 12:40:38.448975 7f5068fc9700 10 cache get:
> name=.rgw+rest-bench-bucket : miss
> 2012-09-05 12:40:38.449498 7f5068fc9700 10 cache put:
> name=.rgw+rest-bench-bucket
> 2012-09-05 12:40:38.449505 7f5068fc9700 10 adding
> .rgw+rest-bench-bucket to cache LRU end
> 2012-09-05 12:40:38.449538 7f5068fc9700 20 get_obj_state:
> rctx=0x7f50a8008fa0 obj=.rgw:.pools.avail state=0x7f50a8008598
> s->prefetch_data=0
> 2012-09-05 12:40:38.449546 7f5068fc9700 10 cache get:
> name=.rgw+.pools.avail : miss
> 2012-09-05 12:40:38.450015 7f5068fc9700 10 cache put:
> name=.rgw+.pools.avail
> 2012-09-05 12:40:38.450020 7f5068fc9700 10 adding .rgw+.pools.avail to
> cache LRU end
> 2012-09-05 12:40:38.778331 7f5068fc9700 15 omap_set bucket=.rgw
> oid=.pools.avail key=.rgw.buckets
> 2012-09-05 12:40:39.223706 7f5068fc9700 10 cache put:
> name=.rgw+.pools.avail
> 2012-09-05 12:40:39.223718 7f5068fc9700 10 moving .rgw+.pools.avail to
> cache LRU end
> 2012-09-05 12:40:39.223744 7f5068fc9700 10 distributing notification
> oid=notify bl.length()=174
> 2012-09-05 12:40:39.224468 7f50c8887700 10 RGWWatcher::notify()
> opcode=1 ver=1 bl.length()=174
> 2012-09-05 12:40:39.224489 7f50c8887700 10 cache put:
> name=.rgw+.pools.avail
> 2012-09-05 12:40:39.224494 7f50c8887700 10 moving .rgw+.pools.avail to
> cache LRU end
> 2012-09-05 12:40:40.454025 7f5068fc9700 10 cache put:
> name=.rgw+rest-bench-bucket
> 2012-09-05 12:40:40.454034 7f5068fc9700 10 moving
> .rgw+rest-bench-bucket to cache LRU end
> 2012-09-05 12:40:40.454038 7f5068fc9700 10 updating xattr:
> name=user.rgw.acl bl.length()=143
> 2012-09-05 12:40:40.454067 7f5068fc9700 10 distributing notification
> oid=notify bl.length()=406
> 2012-09-05 12:40:40.454835 7f50c8887700 10 RGWWatcher::notify()
> opcode=1 ver=1 bl.length()=406
> 2012-09-05 12:40:40.454855 7f50c8887700 10 cache put:
> name=.rgw+rest-bench-bucket
> 2012-09-05 12:40:40.454859 7f50c8887700 10 moving
> .rgw+rest-bench-bucket to cache LRU end
> 2012-09-05 12:40:40.454863 7f50c8887700 10 updating xattr:
> name=user.rgw.acl bl.length()=143
> 2012-09-05 12:40:40.455346 7f5068fc9700 20 store_bucket_info:
> bucket=rest-bench-bucket(@.rgw.buckets[4100.1]) owner ubuntu
> 2012-09-05 12:40:40.455357 7f5068fc9700 20 rgw_create_bucket returned
> ret=0 bucket=rest-bench-bucket(@.rgw.buckets[4100.1])
> 2012-09-05 12:40:40.455372 7f5068fc9700 15 omap_set bucket=.users.uid
> oid=ubuntu.buckets key=rest-bench-bucket
> 2012-09-05 12:40:40.537346 7f5068fc9700 10 --> Status: 200
>
> 2012-09-05 12:40:40.537357 7f5068fc9700 10 --> Content-type:
> application/xml^M
>
> 2012-09-05 12:40:40.891583 7f5068fc9700 2 req 1:2.445176:s3:PUT
> /rest-bench-bucket/:create_bucket:http status=200
> 2012-09-05 12:40:40.891736 7f5068fc9700 1 ====== req done
> req=0x7f50d634fe20 http_status=200 ======
>
> rest-bench-bucket also shows up in a 's3 list' output as well.
>
> Subsequent runs of rest-bench work just fine - its just the initial
> one that fails.
>
> Any ideas?  It looks like it might be a bug in libs3 as this is where
> the ConnectionRefused return code status is set.
>

Sounds like a short timeout on the bucket creation operation, might be
a libs3 configurable. The first time it takes a bit longer (2 seconds
in this example) as it needs to create some initial pools for rgw to
operate.

Yehuda
