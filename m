From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 14:47:56 -0800
Message-ID: <CADRKj5RHLFyyvKfROV2YzLLPrVxQFFP799ZEr95FA+vpwg38uA@mail.gmail.com>
References: <5672EB1F.9070209@umiacs.umd.edu>
	<CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
	<56730775.3070906@umiacs.umd.edu>
	<CADRKj5Rs4DeVGuZ-9hhFLNW2bMHQ44jsKjUtHw66yHApGVzD2g@mail.gmail.com>
	<567315A8.7070905@umiacs.umd.edu>
	<CADRKj5SqdHyBsnUUo=aFUtMwC1qKhuHyhi_b_v-NOYzKYUhm4A@mail.gmail.com>
	<56733AB1.9080908@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34016 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbbLQWr5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 17:47:57 -0500
Received: by mail-ob0-f176.google.com with SMTP id iw8so67654245obc.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 14:47:57 -0800 (PST)
In-Reply-To: <56733AB1.9080908@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 17, 2015 at 2:44 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> On 12/17/15 3:15 PM, Yehuda Sadeh-Weinraub wrote:
>>
>> Right. Reading the code again:
>>
>> Try:
>> GET /admin/metadata/user&key=cephtest
>
> Thanks this is very helpful and works and I was able to also get the PUT
> working.  Only question is that is it expected to return a 204 no content?

Yes, it's expected.

Yehuda

>
> 2015-12-17 17:42:39.422612 7f88f47f0700 20 RGWEnv::set(): HTTP_HOST:
> localhost:7480
> 2015-12-17 17:42:39.422619 7f88f47f0700 20 RGWEnv::set():
> HTTP_ACCEPT_ENCODING: gzip, deflate
> 2015-12-17 17:42:39.422621 7f88f47f0700 20 RGWEnv::set(): HTTP_ACCEPT: */*
> 2015-12-17 17:42:39.422623 7f88f47f0700 20 RGWEnv::set():
> HTTP_USER_AGENT: python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 17:42:39.422625 7f88f47f0700 20 RGWEnv::set(): HTTP_DATE:
> Thu, 17 Dec 2015 22:42:39 GMT
> 2015-12-17 17:42:39.422627 7f88f47f0700 20 RGWEnv::set(): CONTENT_TYPE:
> application/json
> 2015-12-17 17:42:39.422629 7f88f47f0700 20 RGWEnv::set():
> HTTP_AUTHORIZATION: AWS RTJ1TL13CH613JRU2PJD:K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422630 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_FOR: 192.168.86.254
> 2015-12-17 17:42:39.422632 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_HOST: ceph.umiacs.umd.edu
> 2015-12-17 17:42:39.422634 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_SERVER: cephproxy00.umiacs.umd.edu
> 2015-12-17 17:42:39.422636 7f88f47f0700 20 RGWEnv::set():
> HTTP_CONNECTION: Keep-Alive
> 2015-12-17 17:42:39.422637 7f88f47f0700 20 RGWEnv::set():
> CONTENT_LENGTH: 1531
> 2015-12-17 17:42:39.422638 7f88f47f0700 20 RGWEnv::set():
> REQUEST_METHOD: PUT
> 2015-12-17 17:42:39.422640 7f88f47f0700 20 RGWEnv::set(): REQUEST_URI:
> /admin/metadata/user
> 2015-12-17 17:42:39.422641 7f88f47f0700 20 RGWEnv::set(): QUERY_STRING:
> key=-staff
> 2015-12-17 17:42:39.422643 7f88f47f0700 20 RGWEnv::set(): REMOTE_USER:
> 2015-12-17 17:42:39.422644 7f88f47f0700 20 RGWEnv::set(): SCRIPT_URI:
> /admin/metadata/user
> 2015-12-17 17:42:39.422651 7f88f47f0700 20 RGWEnv::set(): SERVER_PORT: 7480
> 2015-12-17 17:42:39.422652 7f88f47f0700 20 CONTENT_LENGTH=1531
> 2015-12-17 17:42:39.422654 7f88f47f0700 20 CONTENT_TYPE=application/json
> 2015-12-17 17:42:39.422655 7f88f47f0700 20 HTTP_ACCEPT=*/*
> 2015-12-17 17:42:39.422655 7f88f47f0700 20 HTTP_ACCEPT_ENCODING=gzip,
> deflate
> 2015-12-17 17:42:39.422656 7f88f47f0700 20 HTTP_AUTHORIZATION=AWS
> RTJ1TL13CH613JRU2PJD:K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422657 7f88f47f0700 20 HTTP_CONNECTION=Keep-Alive
> 2015-12-17 17:42:39.422658 7f88f47f0700 20 HTTP_DATE=Thu, 17 Dec 2015
> 22:42:39 GMT
> 2015-12-17 17:42:39.422658 7f88f47f0700 20 HTTP_HOST=localhost:7480
> 2015-12-17 17:42:39.422659 7f88f47f0700 20
> HTTP_USER_AGENT=python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 17:42:39.422660 7f88f47f0700 20
> HTTP_X_FORWARDED_FOR=192.168.86.254
> 2015-12-17 17:42:39.422660 7f88f47f0700 20
> HTTP_X_FORWARDED_HOST=ceph.umiacs.umd.edu
> 2015-12-17 17:42:39.422661 7f88f47f0700 20
> HTTP_X_FORWARDED_SERVER=cephproxy00.umiacs.umd.edu
> 2015-12-17 17:42:39.422662 7f88f47f0700 20 QUERY_STRING=key=-staff
> 2015-12-17 17:42:39.422662 7f88f47f0700 20 REMOTE_USER=
> 2015-12-17 17:42:39.422663 7f88f47f0700 20 REQUEST_METHOD=PUT
> 2015-12-17 17:42:39.422664 7f88f47f0700 20 REQUEST_URI=/admin/metadata/user
> 2015-12-17 17:42:39.422664 7f88f47f0700 20 SCRIPT_URI=/admin/metadata/user
> 2015-12-17 17:42:39.422665 7f88f47f0700 20 SERVER_PORT=7480
> 2015-12-17 17:42:39.422667 7f88f47f0700 20 RGWEnv::set(): HTTP_HOST:
> localhost:7480
> 2015-12-17 17:42:39.422668 7f88f47f0700 20 RGWEnv::set():
> HTTP_ACCEPT_ENCODING: gzip, deflate
> 2015-12-17 17:42:39.422670 7f88f47f0700 20 RGWEnv::set(): HTTP_ACCEPT: */*
> 2015-12-17 17:42:39.422671 7f88f47f0700 20 RGWEnv::set():
> HTTP_USER_AGENT: python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 17:42:39.422672 7f88f47f0700 20 RGWEnv::set(): HTTP_DATE:
> Thu, 17 Dec 2015 22:42:39 GMT
> 2015-12-17 17:42:39.422673 7f88f47f0700 20 RGWEnv::set(): CONTENT_TYPE:
> application/json
> 2015-12-17 17:42:39.422674 7f88f47f0700 20 RGWEnv::set():
> HTTP_AUTHORIZATION: AWS RTJ1TL13CH613JRU2PJD:K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422676 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_FOR: 192.168.86.254
> 2015-12-17 17:42:39.422677 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_HOST: ceph.umiacs.umd.edu
> 2015-12-17 17:42:39.422678 7f88f47f0700 20 RGWEnv::set():
> HTTP_X_FORWARDED_SERVER: cephproxy00.umiacs.umd.edu
> 2015-12-17 17:42:39.422679 7f88f47f0700 20 RGWEnv::set():
> HTTP_CONNECTION: Keep-Alive
> 2015-12-17 17:42:39.422680 7f88f47f0700 20 RGWEnv::set():
> CONTENT_LENGTH: 1531
> 2015-12-17 17:42:39.422681 7f88f47f0700 20 RGWEnv::set():
> REQUEST_METHOD: PUT
> 2015-12-17 17:42:39.422682 7f88f47f0700 20 RGWEnv::set(): REQUEST_URI:
> /admin/metadata/user
> 2015-12-17 17:42:39.422683 7f88f47f0700 20 RGWEnv::set(): QUERY_STRING:
> key=-staff
> 2015-12-17 17:42:39.422684 7f88f47f0700 20 RGWEnv::set(): REMOTE_USER:
> 2015-12-17 17:42:39.422685 7f88f47f0700 20 RGWEnv::set(): SCRIPT_URI:
> /admin/metadata/user
> 2015-12-17 17:42:39.422686 7f88f47f0700 20 RGWEnv::set(): SERVER_PORT: 7480
> 2015-12-17 17:42:39.422687 7f88f47f0700 20 CONTENT_LENGTH=1531
> 2015-12-17 17:42:39.422687 7f88f47f0700 20 CONTENT_TYPE=application/json
> 2015-12-17 17:42:39.422688 7f88f47f0700 20 HTTP_ACCEPT=*/*
> 2015-12-17 17:42:39.422689 7f88f47f0700 20 HTTP_ACCEPT_ENCODING=gzip,
> deflate
> 2015-12-17 17:42:39.422689 7f88f47f0700 20 HTTP_AUTHORIZATION=AWS
> RTJ1TL13CH613JRU2PJD:K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422690 7f88f47f0700 20 HTTP_CONNECTION=Keep-Alive
> 2015-12-17 17:42:39.422691 7f88f47f0700 20 HTTP_DATE=Thu, 17 Dec 2015
> 22:42:39 GMT
> 2015-12-17 17:42:39.422691 7f88f47f0700 20 HTTP_HOST=localhost:7480
> 2015-12-17 17:42:39.422692 7f88f47f0700 20
> HTTP_USER_AGENT=python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 17:42:39.422693 7f88f47f0700 20
> HTTP_X_FORWARDED_FOR=192.168.86.254
> 2015-12-17 17:42:39.422693 7f88f47f0700 20
> HTTP_X_FORWARDED_HOST=ceph.umiacs.umd.edu
> 2015-12-17 17:42:39.422694 7f88f47f0700 20
> HTTP_X_FORWARDED_SERVER=cephproxy00.umiacs.umd.edu
> 2015-12-17 17:42:39.422695 7f88f47f0700 20 QUERY_STRING=key=-staff
> 2015-12-17 17:42:39.422695 7f88f47f0700 20 REMOTE_USER=
> 2015-12-17 17:42:39.422696 7f88f47f0700 20 REQUEST_METHOD=PUT
> 2015-12-17 17:42:39.422696 7f88f47f0700 20 REQUEST_URI=/admin/metadata/user
> 2015-12-17 17:42:39.422697 7f88f47f0700 20 SCRIPT_URI=/admin/metadata/user
> 2015-12-17 17:42:39.422698 7f88f47f0700 20 SERVER_PORT=7480
> 2015-12-17 17:42:39.422698 7f88f47f0700  1 ====== starting new request
> req=0x7f891c045010 =====
> 2015-12-17 17:42:39.422707 7f88f47f0700  2 req 301:0.000008::PUT
> /admin/metadata/user::initializing for trans_id =
> tx00000000000000000012d-0056733a5f-5f7c-default
> 2015-12-17 17:42:39.422710 7f88f47f0700 10 host=localhost
> 2015-12-17 17:42:39.422711 7f88f47f0700 20 subdomain= domain=
> in_hosted_domain=0
> 2015-12-17 17:42:39.422727 7f88f47f0700  2 req 301:0.000028::PUT
> /admin/metadata/user::getting op
> 2015-12-17 17:42:39.422729 7f88f47f0700  2 req 301:0.000030::PUT
> /admin/metadata/user:set_metadata:authorizing
> 2015-12-17 17:42:39.422746 7f88f47f0700 10 get_canon_resource():
> dest=/admin/metadata/user
> 2015-12-17 17:42:39.422748 7f88f47f0700 10 auth_hdr:
> PUT
>
> application/json
> Thu, 17 Dec 2015 22:42:39 GMT
> /admin/metadata/user
> 2015-12-17 17:42:39.422777 7f88f47f0700 15 calculated
> digest=K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422779 7f88f47f0700 15
> auth_sign=K3xaPHDy6t3r0COfjwl9rAUsUfY=
> 2015-12-17 17:42:39.422779 7f88f47f0700 15 compare=0
> 2015-12-17 17:42:39.422781 7f88f47f0700  2 req 301:0.000082::PUT
> /admin/metadata/user:set_metadata:reading permissions
> 2015-12-17 17:42:39.422783 7f88f47f0700  2 req 301:0.000084::PUT
> /admin/metadata/user:set_metadata:init op
> 2015-12-17 17:42:39.422784 7f88f47f0700  2 req 301:0.000085::PUT
> /admin/metadata/user:set_metadata:verifying op mask
> 2015-12-17 17:42:39.422785 7f88f47f0700 20 required_mask= 0 user.op_mask=7
> 2015-12-17 17:42:39.422786 7f88f47f0700  2 req 301:0.000088::PUT
> /admin/metadata/user:set_metadata:verifying op permissions
> 2015-12-17 17:42:39.422788 7f88f47f0700  2 req 301:0.000090::PUT
> /admin/metadata/user:set_metadata:verifying op params
> 2015-12-17 17:42:39.422790 7f88f47f0700  2 req 301:0.000091::PUT
> /admin/metadata/user:set_metadata:executing
> 2015-12-17 17:42:39.423280 7f88f47f0700 20 get_obj_state:
> rctx=0x7f88f47ea710 obj=.users.uid:-staff state=0x7f891c04ddd0
> s->prefetch_data=0
> 2015-12-17 17:42:39.423286 7f88f47f0700 10 cache get:
> name=.users.uid+-staff : hit
> 2015-12-17 17:42:39.423290 7f88f47f0700 20 get_obj_state: s->obj_tag was
> set empty
> 2015-12-17 17:42:39.423292 7f88f47f0700 10 cache get:
> name=.users.uid+-staff : hit
> 2015-12-17 17:42:39.442633 7f88f47f0700 10 cache put: name=.users.uid+-staff
> 2015-12-17 17:42:39.442640 7f88f47f0700 10 moving .users.uid+-staff to
> cache LRU end
> 2015-12-17 17:42:39.442660 7f88f47f0700 10 distributing notification
> oid=notify.7 bl.length()=1259
> 2015-12-17 17:42:39.443653 7f89177fe700 10 RGWWatcher::handle_notify()
> notify_id 279172874441 cookie 66521888 notifier 24444 bl.length()=1259
> 2015-12-17 17:42:39.443665 7f89177fe700 10 cache put: name=.users.uid+-staff
> 2015-12-17 17:42:39.443667 7f89177fe700 10 moving .users.uid+-staff to
> cache LRU end
> 2015-12-17 17:42:39.444461 7f88f47f0700  2 req 301:0.021761::PUT
> /admin/metadata/user:set_metadata:http status=204
> 2015-12-17 17:42:39.444466 7f88f47f0700  1 ====== req done
> req=0x7f891c045010 http_status=204 ======
> 2015-12-17 17:42:39.444471 7f88f47f0700 20 process_request() returned -1902
> 2015-12-17 17:42:39.444493 7f88f47f0700  1 civetweb: 0x7f891c023d20:
> 127.0.0.1 - - [17/Dec/2015:17:42:39 -0500] "PUT /admin/metadata/user
> HTTP/1.1" 204 0 - python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 17:42:43.481916 7f8916ffd700  2
> RGWDataChangesLog::ChangesRenewThread: start
>
> --
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
