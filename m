From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: Re: [ceph-users] RGW Multipart Uplaods
Date: Mon, 18 Feb 2013 13:54:44 -0500
Message-ID: <512278F4.1000701@umiacs.umd.edu>
References: <512256AA.6070408@umiacs.umd.edu> <CAC-hyiE_UAojZCDJ14BRn-hSN-RKJtNDSaaMfzhsPboF8NZ2vA@mail.gmail.com>
Reply-To: derek@umiacs.umd.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from homsar.umiacs.umd.edu ([128.8.120.251]:33063 "EHLO
	homsar.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab3BRSyq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 13:54:46 -0500
In-Reply-To: <CAC-hyiE_UAojZCDJ14BRn-hSN-RKJtNDSaaMfzhsPboF8NZ2vA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: derek@umiacs.umd.edu, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 2/18/13 11:53 AM, Yehuda Sadeh wrote:
> On Mon, Feb 18, 2013 at 8:28 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
>> Hi,
>>
>> I am trying to write some multipart parallel upload scripts.  I have run
>> into an issue with listing the current multipart uploads.  Is this
>> feature available in the current radosgw (0.56.3)?  I am able to upload
>> using multipart when initiatiating the upload and then itterating over
>> the chunks sequentially.  But when I try to iterate over a pool of
>> chunks in parallel I can't call the listing of multipart uploads on the
>> given bucket.
>>
>> The response I get back from the 'GET /?uploads HTTP/1.1' (the server is
>> setup to handle bucket DNS names) is a 200 OK, with a XML
>> <ListBucketResult> with the contents of the bucket.
>>
> 
> The code is there, but looking at it right now, I see some issue. Try
> doing 'GET /?uploadId HTTP/1.1' instead.
> 
> The fix is trivial, I opened issue #4177 for that. I'm also opening an
> issue for fixing our test suite, as it was supposed to catch this
> issue.
> 
> Thanks,
> Yehuda
> 

Hi Yehuda,

Many thanks as usual.  The uploadID syntax seems to give 500 errors as
seen by this request (anonomized) below.

Thanks,
derek

Mon, 18 Feb 2013 18:32:39 GMT
/zeta/?uploadId
2013-02-18 13:32:44.023609 7fe36aff7700 15 b64=###
2013-02-18 13:32:44.023611 7fe36aff7700 15 auth_sign=###
2013-02-18 13:32:44.023612 7fe36aff7700 15 compare=0
2013-02-18 13:32:44.023614 7fe36aff7700  2 req 6:0.000240:s3:GET
/zeta/:list_multipart:reading permissions
2013-02-18 13:32:44.023621 7fe36aff7700 20 get_obj_state:
rctx=0x7fe2fc001070 obj=.rgw:zeta state=0x7fe2fc009c08 s->prefetch_data=0
2013-02-18 13:32:44.023625 7fe36aff7700 10 moving .rgw+zeta to cache LRU end
2013-02-18 13:32:44.023627 7fe36aff7700 10 cache get: name=.rgw+zeta : hit
2013-02-18 13:32:44.023631 7fe36aff7700 20 get_obj_state: s->obj_tag was
set empty
2013-02-18 13:32:44.023633 7fe36aff7700 10 moving .rgw+zeta to cache LRU end
2013-02-18 13:32:44.023634 7fe36aff7700 10 cache get: name=.rgw+zeta : hit
2013-02-18 13:32:44.023643 7fe36aff7700 20 rgw_get_bucket_info:
bucket=zeta(@.rgw.buckets[4631.3]) owner derek
2013-02-18 13:32:44.023650 7fe36aff7700 20 get_obj_state:
rctx=0x7fe2fc001070 obj=zeta: state=0x7fe2fc009c08 s->prefetch_data=0
2013-02-18 13:32:44.023659 7fe36aff7700 15 Read
AccessControlPolicy<AccessControlPolicy
xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>derek</ID><DisplayName>Derek
Yarnell</DisplayName></Owner><AccessControlList><Grant><Grantee
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="CanonicalUser"><ID>derek</ID><DisplayName>Derek
Yarnell</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
2013-02-18 13:32:44.023669 7fe36aff7700 20 get_obj_state:
rctx=0x7fe2fc001070 obj=zeta: state=0x7fe2fc009c08 s->prefetch_data=0
2013-02-18 13:32:44.023675 7fe36aff7700 15 Read
AccessControlPolicy<AccessControlPolicy
xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>derek</ID><DisplayName>Derek
Yarnell</DisplayName></Owner><AccessControlList><Grant><Grantee
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="CanonicalUser"><ID>derek</ID><DisplayName>Derek
Yarnell</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
2013-02-18 13:32:44.023680 7fe36aff7700  2 req 6:0.000305:s3:GET
/zeta/:list_multipart:verifying op permissions
2013-02-18 13:32:44.023682 7fe36aff7700  5 Searching permissions for
uid=derek mask=1
2013-02-18 13:32:44.023684 7fe36aff7700  5 Found permission: 15
2013-02-18 13:32:44.023685 7fe36aff7700 10  uid=derek requested perm
(type)=1, policy perm=1, user_perm_mask=15, acl perm=1
2013-02-18 13:32:44.023687 7fe36aff7700  2 req 6:0.000313:s3:GET
/zeta/:list_multipart:verifying op params
2013-02-18 13:32:44.023689 7fe36aff7700  2 req 6:0.000315:s3:GET
/zeta/:list_multipart:executing
2013-02-18 13:32:44.023692 7fe36aff7700  0 WARNING: set_req_state_err
err_no=95 resorting to 500
2013-02-18 13:32:44.023709 7fe36aff7700  2 req 6:0.000335:s3:GET
/zeta/:list_multipart:http status=500
2013-02-18 13:32:44.023774 7fe36aff7700  1 ====== req done req=0x278dd60
http_status=500 ======
2013-02-18 13:32:47.361755 7fe3a7d31820 20 enqueued request req=0x278e0c0
2013-02-18 13:32:47.361773 7fe3a7d31820 20 RGWWQ:
2013-02-18 13:32:47.361775 7fe3a7d31820 20 req: 0x278e0c0
2013-02-18 13:32:47.361779 7fe3a7d31820 10 allocated request req=0x278e020
2013-02-18 13:32:47.361786 7fe376bfd700 20 dequeued request req=0x278e0c0
2013-02-18 13:32:47.361802 7fe376bfd700 20 RGWWQ: empty
2013-02-18 13:32:47.361808 7fe376bfd700  1 ====== starting new request
req=0x278e0c0 =====
2013-02-18 13:32:47.361843 7fe376bfd700  2 req 7:0.000035::::initializing
2013-02-18 13:32:47.361851 7fe376bfd700 10 host=zeta.obj.somedomain.com
rgw_dns_name=obj.somedomain.com
2013-02-18 13:32:47.361879 7fe376bfd700 10 s->object=<NULL> s->bucket=zeta
2013-02-18 13:32:47.361883 7fe376bfd700 20 FCGI_ROLE=RESPONDER
2013-02-18 13:32:47.361884 7fe376bfd700 20 SCRIPT_URL=/
2013-02-18 13:32:47.361885 7fe376bfd700 20
SCRIPT_URI=http://zeta.obj.somedomain.com/
2013-02-18 13:32:47.361886 7fe376bfd700 20 HTTP_AUTHORIZATION=AWS ###:###
2013-02-18 13:32:47.361887 7fe376bfd700 20 HTTP_HOST=zeta.obj.somedomain.com
2013-02-18 13:32:47.361888 7fe376bfd700 20 HTTP_ACCEPT_ENCODING=identity
2013-02-18 13:32:47.361889 7fe376bfd700 20 HTTP_DATE=Mon, 18 Feb 2013
18:32:39 GMT
2013-02-18 13:32:47.361890 7fe376bfd700 20 CONTENT_LENGTH=0
2013-02-18 13:32:47.361890 7fe376bfd700 20 HTTP_USER_AGENT=Boto/2.8.0
(darwin)
2013-02-18 13:32:47.361891 7fe376bfd700 20
PATH=/sbin:/usr/sbin:/bin:/usr/bin
2013-02-18 13:32:47.361892 7fe376bfd700 20 SERVER_SIGNATURE=
2013-02-18 13:32:47.361893 7fe376bfd700 20 SERVER_SOFTWARE=Apache/2.2.15
(Red Hat)
2013-02-18 13:32:47.361898 7fe376bfd700 20
SERVER_NAME=zeta.obj.somedomain.com
2013-02-18 13:32:47.361899 7fe376bfd700 20 SERVER_ADDR=10.10.0.1
2013-02-18 13:32:47.361900 7fe376bfd700 20 SERVER_PORT=80
2013-02-18 13:32:47.361901 7fe376bfd700 20 REMOTE_ADDR=192.168.86.54
2013-02-18 13:32:47.361902 7fe376bfd700 20 DOCUMENT_ROOT=/var/www/ceph
2013-02-18 13:32:47.361902 7fe376bfd700 20
SERVER_ADMIN=something@somedomain.com
2013-02-18 13:32:47.361903 7fe376bfd700 20
SCRIPT_FILENAME=/var/www/ceph/s3gw.fcgi
2013-02-18 13:32:47.361904 7fe376bfd700 20 REMOTE_PORT=49825
2013-02-18 13:32:47.361905 7fe376bfd700 20 GATEWAY_INTERFACE=CGI/1.1
2013-02-18 13:32:47.361906 7fe376bfd700 20 SERVER_PROTOCOL=HTTP/1.1
2013-02-18 13:32:47.361906 7fe376bfd700 20 REQUEST_METHOD=GET
2013-02-18 13:32:47.361907 7fe376bfd700 20
QUERY_STRING=page=&params=&uploadId
2013-02-18 13:32:47.361908 7fe376bfd700 20 REQUEST_URI=/?uploadId
2013-02-18 13:32:47.361909 7fe376bfd700 20 SCRIPT_NAME=/
2013-02-18 13:32:47.361911 7fe376bfd700  2 req 7:0.000103:s3:GET
/zeta/::getting op
2013-02-18 13:32:47.361917 7fe376bfd700  2 req 7:0.000108:s3:GET
/zeta/:list_multipart:authorizing
2013-02-18 13:32:47.361939 7fe376bfd700 20 get_obj_state:
rctx=0x7fe32c002a00 obj=.users:#### state=0x7fe32c00d028 s->prefetch_data=0
2013-02-18 13:32:47.361948 7fe376bfd700 10 moving .users+### to cache
LRU end
2013-02-18 13:32:47.361951 7fe376bfd700 10 cache get: name=.users+### : hit
2013-02-18 13:32:47.361957 7fe376bfd700 20 get_obj_state: s->obj_tag was
set empty
2013-02-18 13:32:47.361962 7fe376bfd700 10 moving .users+### to cache
LRU end
2013-02-18 13:32:47.361963 7fe376bfd700 10 cache get: name=.users+### : hit
2013-02-18 13:32:47.362008 7fe376bfd700 10 get_canon_resource():
dest=/zeta/?uploadId
2013-02-18 13:32:47.362009 7fe376bfd700 10 auth_hdr:
GET

-- 
---
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
