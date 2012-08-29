From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RBD kernel: Weird messages about "connect authorization failure"
 or "socket closed"
Date: Wed, 29 Aug 2012 17:04:47 +0200
Message-ID: <CAF6-1L7nf1+jUjSMDbP-1yhELndm1mNQiAVcsAOvMetD=hnAoQ@mail.gmail.com>
References: <CAF6-1L4q5PsDjE=393oOjRZ56n-=7XjdQQu0i+1KhOeWc7KsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49162 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2H2PEs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 11:04:48 -0400
Received: by vcbfk26 with SMTP id fk26so715629vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 08:04:47 -0700 (PDT)
In-Reply-To: <CAF6-1L4q5PsDjE=393oOjRZ56n-=7XjdQQu0i+1KhOeWc7KsGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

In the OSD log I see thos " auth: could not find secret_id=0" ... Any idea ?

Because obviously it succeeds a couple of millisecond later.


2012-08-29 13:47:17.873583 7f981ae9d700  0 -- 192.168.1.71:6807/2080
>> 192.168.1.28:0/440990652 pipe(0x75d6800 sd=33 pgs=0 cs=0
l=0).accept peer addr is really 192.168.1.28:0/440990652 (socket is
192.168.1.28:38689/0)
2012-08-29 13:47:17.873717 7f981ae9d700  0 auth: could not find secret_id=0
2012-08-29 13:47:17.873727 7f981ae9d700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=0
2012-08-29 13:47:17.873731 7f981ae9d700  1
CephxAuthorizeHandler::verify_authorizer isvalid=0
2012-08-29 13:47:17.873733 7f981ae9d700  0 -- 192.168.1.71:6807/2080
>> 192.168.1.28:0/440990652 pipe(0x75d6800 sd=33 pgs=0 cs=0
l=1).accept bad authorizer
2012-08-29 13:47:17.873925 7f981ae9d700  0 auth: could not find secret_id=0
2012-08-29 13:47:17.873938 7f981ae9d700  0 cephx: verify_authorizer
could not get service secret for service osd secret_id=0
2012-08-29 13:47:17.873941 7f981ae9d700  1
CephxAuthorizeHandler::verify_authorizer isvalid=0
2012-08-29 13:47:17.873942 7f981ae9d700  0 -- 192.168.1.71:6807/2080
>> 192.168.1.28:0/440990652 pipe(0x75d6800 sd=33 pgs=0 cs=0
l=1).accept bad authorizer
2012-08-29 13:47:18.599819 7f981ae9d700  0 -- 192.168.1.71:6807/2080
>> 192.168.1.28:0/440990652 pipe(0x56e6600 sd=33 pgs=0 cs=0
l=0).accept peer addr is really 192.168.1.28:0/440990652 (socket is
192.168.1.28:38690/0)
2012-08-29 13:47:18.600056 7f981ae9d700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-08-29 13:47:18.600433 7f981e2ae700  0 osd.3 913 pg[2.14( v
905'2959 (79'1958,905'2959] n=17 ec=1 les/c 913/913 912/912/904) [3,0]
r=0 lpr=912 mlcod 0'0 active+clean] watch: ctx->obc=0x5bccb00 cookie=6
oi.version=2956 ctx->at_version=913'2960
2012-08-29 13:47:18.600443 7f981e2ae700  0 osd.3 913 pg[2.14( v
905'2959 (79'1958,905'2959] n=17 ec=1 les/c 913/913 912/912/904) [3,0]
r=0 lpr=912 mlcod 0'0 active+clean] watch: oi.user_version=2955


Cheers,

    Sylvain
