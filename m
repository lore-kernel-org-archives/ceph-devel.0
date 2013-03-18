From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [radosgw] Race condition corrupting data on COPY ?
Date: Mon, 18 Mar 2013 15:40:57 +0100
Message-ID: <CAF6-1L5QQrKpBPxY1-P-8i1EX8k8N7hT79Rx2oNF0pZMxJMSpg@mail.gmail.com>
References: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
	<CAC-hyiGy9RWf_ZJ8d4rPwZETRcOiDGx505=tj1n0_+VivXi8qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:40057 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3CROk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 10:40:58 -0400
Received: by mail-bk0-f51.google.com with SMTP id ik5so2591670bkc.10
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 07:40:57 -0700 (PDT)
In-Reply-To: <CAC-hyiGy9RWf_ZJ8d4rPwZETRcOiDGx505=tj1n0_+VivXi8qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,


> What version are you using? Do you have logs?

I'm running a custom build 0.56.3 + some patches ( basically up
to7889c5412 + fixes for #4150 and #4177 ).

I don't have any radosgw low  ( debug level is set to 0 and it didn't
output anything ).
I have the HTTP logs :

10.0.0.253 s3.svc - [14/Mar/2013:09:23:14 +0000] "PUT
/rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34
HTTP/1.1" 200 0 "-" "Boto/2.6.0 (linux2)"
10.0.0.74 s3.svc - [14/Mar/2013:09:23:14 +0000] "GET
/rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34?Signature=XXX%3D&Expires=1363256594&AWSAccessKeyId=XXX
HTTP/1.1" 200 622080 "-" "python-requests"
10.0.0.253 s3.svc - [14/Mar/2013:09:23:14 +0000] "PUT
/rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34
HTTP/1.1" 200 146 "-" "Boto/2.6.0 (linux2)"
10.0.0.74 s3.svc - [14/Mar/2013:10:14:53 +0000] "GET
/rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34?Signature=XXX%3D&Expires=1363258236&AWSAccessKeyId=XXX
HTTP/1.1" 200 461220 "-" "python-requests"


Cheers,

   Sylvain
