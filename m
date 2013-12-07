From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: [ceph-users] recreate bucket error
Date: Sat, 7 Dec 2013 13:33:25 +0100
Message-ID: <CAMNMNTzd7LEht6y-5vT6sEvJeG3yErQGNGbmGM3x+hYOuTQs0g@mail.gmail.com>
References: <CAMNMNTzt_yPoqOhgKpi9vioAXygzD_oKzhHxsh-WA6NCB7mOcg@mail.gmail.com>
	<CABBk=J95C7OrwTAPN_EJ8dHmTOiSFExhrAv2n5FJ6RyACuMETA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:51890 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab3LGMd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Dec 2013 07:33:26 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2015869oag.7
        for <ceph-devel@vger.kernel.org>; Sat, 07 Dec 2013 04:33:25 -0800 (PST)
In-Reply-To: <CABBk=J95C7OrwTAPN_EJ8dHmTOiSFExhrAv2n5FJ6RyACuMETA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Are you running on latest dumpling
Yes. It was installed, not upgraded from prev version.
This is new crated bucket.
I rebuilded cluster from scratch.

User add command "radosgw-admin user create ..." shows:
WARNING: cannot read region map

Create first time bucket 'test1' via 's3 -u craete test1' got error.
But in radosgw logs it seems ok:
-------
2013-12-07 10:40:04.328277 7f7746ff5700  1 ====== starting new request
req=0x1f5c7b0 =====
2013-12-07 10:40:04.328339 7f7746ff5700  2 req 2:0.000063::PUT
/test1/::initializing
2013-12-07 10:40:04.328361 7f7746ff5700 10 meta>> HTTP_X_AMZ_DATE
2013-12-07 10:40:04.328368 7f7746ff5700 10 x>> x-amz-date:Sat, 07 Dec
2013 09:40:04 GMT
2013-12-07 10:40:04.328383 7f7746ff5700 10 s->object=<NULL> s->bucket=test1
2013-12-07 10:40:04.328390 7f7746ff5700  2 req 2:0.000114:s3:PUT
/test1/::getting op
2013-12-07 10:40:04.328394 7f7746ff5700  2 req 2:0.000118:s3:PUT
/test1/:create_bucket:authorizing
2013-12-07 10:40:04.334424 7f7746ff5700 10 get_canon_resource(): dest=
2013-12-07 10:40:04.334433 7f7746ff5700 10 auth_hdr:
PUT



x-amz-date:Sat, 07 Dec 2013 09:40:04 GMT
/test1/
2013-12-07 10:40:04.334476 7f7746ff5700  2 req 2:0.006200:s3:PUT
/test1/:create_bucket:reading permissions
2013-12-07 10:40:04.334481 7f7746ff5700  2 req 2:0.006205:s3:PUT
/test1/:create_bucket:verifying op mask
2013-12-07 10:40:04.334483 7f7746ff5700  2 req 2:0.006207:s3:PUT
/test1/:create_bucket:verifying op permissions
2013-12-07 10:40:04.335391 7f7746ff5700  2 req 2:0.007115:s3:PUT
/test1/:create_bucket:verifying op params
2013-12-07 10:40:04.335402 7f7746ff5700  2 req 2:0.007126:s3:PUT
/test1/:create_bucket:executing
2013-12-07 10:40:05.420459 7f7746ff5700  2 req 2:1.092182:s3:PUT
/test1/:create_bucket:http status=200
2013-12-07 10:40:05.420621 7f7746ff5700  1 ====== req done
req=0x1f5c7b0 http_status=200 ======
-------


Second try:
-------
2013-12-07 10:40:06.421876 7f778d95d780 10 allocated request req=0x1f5c710
2013-12-07 10:40:06.421936 7f77317ca700  1 ====== starting new request
req=0x1f5bc10 =====
2013-12-07 10:40:06.422038 7f77317ca700  2 req 3:0.000104::PUT
/test1/::initializing
2013-12-07 10:40:06.422069 7f77317ca700 10 meta>> HTTP_X_AMZ_DATE
2013-12-07 10:40:06.422080 7f77317ca700 10 x>> x-amz-date:Sat, 07 Dec
2013 09:40:06 GMT
2013-12-07 10:40:06.422101 7f77317ca700 10 s->object=<NULL> s->bucket=test1
2013-12-07 10:40:06.422110 7f77317ca700  2 req 3:0.000176:s3:PUT
/test1/::getting op
2013-12-07 10:40:06.422117 7f77317ca700  2 req 3:0.000183:s3:PUT
/test1/:create_bucket:authorizing
2013-12-07 10:40:06.429576 7f77317ca700 10 get_canon_resource(): dest=
2013-12-07 10:40:06.429592 7f77317ca700 10 auth_hdr:
PUT



x-amz-date:Sat, 07 Dec 2013 09:40:06 GMT
/test1/
2013-12-07 10:40:06.429679 7f77317ca700  2 req 3:0.007745:s3:PUT
/test1/:create_bucket:reading permissions
2013-12-07 10:40:06.429690 7f77317ca700  2 req 3:0.007756:s3:PUT
/test1/:create_bucket:verifying op mask
2013-12-07 10:40:06.429693 7f77317ca700  2 req 3:0.007759:s3:PUT
/test1/:create_bucket:verifying op permissions
2013-12-07 10:40:06.430945 7f77317ca700  2 req 3:0.009010:s3:PUT
/test1/:create_bucket:verifying op params
2013-12-07 10:40:06.430964 7f77317ca700  2 req 3:0.009030:s3:PUT
/test1/:create_bucket:executing
2013-12-07 10:40:06.436301 7f77317ca700  0 WARNING: couldn't find acl
header for object, generating default
2013-12-07 10:40:06.451160 7f77317ca700  0 get_bucket_info returned -125
2013-12-07 10:40:06.451188 7f77317ca700  0 WARNING: set_req_state_err
err_no=125 resorting to 500
2013-12-07 10:40:06.451223 7f77317ca700  2 req 3:0.029289:s3:PUT
/test1/:create_bucket:http status=500
2013-12-07 10:40:06.451335 7f77317ca700  1 ====== req done
req=0x1f5bc10 http_status=500 ======
-------

ceph -s
  cluster 92833861-954f-4c66-a72b-5a83090a2b3f
   health HEALTH_OK

ceph -v
ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)

I have strange behavior after cluster create.
All PGs were on osd.0 and marked as stale degraded.
After add more osd's it didn't ifxed.
"ceph pg force_create_pg" helps.

After setup cluster I changed crushmap.
Removed osd.0 and added it again to cluster.

It can be a reason?

----
Regards
Dominik

2013/12/6 Yehuda Sadeh <yehuda@inktank.com>:
> I'm having trouble reproducing this one. Are you running on latest
> dumpling? Does it happen with any newly created bucket, or just with
> buckets that existed before?
>
> Yehuda
>
> On Fri, Dec 6, 2013 at 5:07 AM, Dominik Mostowiec
> <dominikmostowiec@gmail.com> wrote:
>> Hi,
>> In version dumpling upgraded from bobtail working create the same bucket.
>>
>> root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
>> Bucket successfully created.
>> root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
>> Bucket successfully created.
>>
>> I installed new dumpling cluster and:
>> root@s1:/var/log/radosgw# s3 -u create test1
>> Bucket successfully created.
>> root@s1:/var/log/radosgw# s3 -u create test1
>>
>> ERROR: ErrorUnknown
>>
>> In radosgw logs:
>>
>> 2013-12-06 13:59:56.083109 7f162d7c2700  1 ====== starting new request
>> req=0xb7d480 =====
>> 2013-12-06 13:59:56.083227 7f162d7c2700  2 req 5:0.000119::PUT
>> /test1/::initializing
>> 2013-12-06 13:59:56.083261 7f162d7c2700 10 meta>> HTTP_X_AMZ_DATE
>> 2013-12-06 13:59:56.083274 7f162d7c2700 10 x>> x-amz-date:Fri, 06 Dec
>> 2013 12:59:56 GMT
>> 2013-12-06 13:59:56.083298 7f162d7c2700 10 s->object=<NULL> s->bucket=test1
>> 2013-12-06 13:59:56.083307 7f162d7c2700  2 req 5:0.000199:s3:PUT
>> /test1/::getting op
>> 2013-12-06 13:59:56.083315 7f162d7c2700  2 req 5:0.000207:s3:PUT
>> /test1/:create_bucket:authorizing
>> 2013-12-06 13:59:56.091724 7f162d7c2700 10 get_canon_resource(): dest=
>> 2013-12-06 13:59:56.091742 7f162d7c2700 10 auth_hdr:
>> PUT
>>
>>
>>
>> x-amz-date:Fri, 06 Dec 2013 12:59:56 GMT
>> /test1/
>> 2013-12-06 13:59:56.091836 7f162d7c2700  2 req 5:0.008728:s3:PUT
>> /test1/:create_bucket:reading permissions
>> 2013-12-06 13:59:56.091848 7f162d7c2700  2 req 5:0.008740:s3:PUT
>> /test1/:create_bucket:verifying op mask
>> 2013-12-06 13:59:56.091852 7f162d7c2700  2 req 5:0.008744:s3:PUT
>> /test1/:create_bucket:verifying op permissions
>> 2013-12-06 13:59:56.093858 7f162d7c2700  2 req 5:0.010750:s3:PUT
>> /test1/:create_bucket:verifying op params
>> 2013-12-06 13:59:56.093882 7f162d7c2700  2 req 5:0.010773:s3:PUT
>> /test1/:create_bucket:executing
>> 2013-12-06 13:59:56.104819 7f162d7c2700  0 WARNING: couldn't find acl
>> header for object, generating default
>> 2013-12-06 13:59:56.132625 7f162d7c2700  0 get_bucket_info returned -125
>> 2013-12-06 13:59:56.132656 7f162d7c2700  0 WARNING: set_req_state_err
>> err_no=125 resorting to 500
>> 2013-12-06 13:59:56.132693 7f162d7c2700  2 req 5:0.049584:s3:PUT
>> /test1/:create_bucket:http status=500
>> 2013-12-06 13:59:56.132890 7f162d7c2700  1 ====== req done
>> req=0xb7d480 http_status=500 ======
>>
>> --
>> Regards
>> Dominik
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



-- 
Pozdrawiam
Dominik
