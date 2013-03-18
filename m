From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [radosgw] Race condition corrupting data on COPY ?
Date: Mon, 18 Mar 2013 09:25:42 -0700
Message-ID: <CAC-hyiHLsjd7UAWHq9DWsZyGqLTyeKp28VV84gKrr-8Kmo-+Aw@mail.gmail.com>
References: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
	<CAC-hyiGy9RWf_ZJ8d4rPwZETRcOiDGx505=tj1n0_+VivXi8qA@mail.gmail.com>
	<CAF6-1L5QQrKpBPxY1-P-8i1EX8k8N7hT79Rx2oNF0pZMxJMSpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:45378 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3CRQZn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 12:25:43 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so3179353iad.12
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 09:25:43 -0700 (PDT)
In-Reply-To: <CAF6-1L5QQrKpBPxY1-P-8i1EX8k8N7hT79Rx2oNF0pZMxJMSpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 18, 2013 at 7:40 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
>> What version are you using? Do you have logs?
>
> I'm running a custom build 0.56.3 + some patches ( basically up
> to7889c5412 + fixes for #4150 and #4177 ).
>
> I don't have any radosgw low  ( debug level is set to 0 and it didn't
> output anything ).
> I have the HTTP logs :
>
> 10.0.0.253 s3.svc - [14/Mar/2013:09:23:14 +0000] "PUT
> /rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34
> HTTP/1.1" 200 0 "-" "Boto/2.6.0 (linux2)"
> 10.0.0.74 s3.svc - [14/Mar/2013:09:23:14 +0000] "GET
> /rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34?Signature=XXX%3D&Expires=1363256594&AWSAccessKeyId=XXX
> HTTP/1.1" 200 622080 "-" "python-requests"
> 10.0.0.253 s3.svc - [14/Mar/2013:09:23:14 +0000] "PUT
> /rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34
> HTTP/1.1" 200 146 "-" "Boto/2.6.0 (linux2)"
> 10.0.0.74 s3.svc - [14/Mar/2013:10:14:53 +0000] "GET
> /rb/138e6898a8039db16df2146398626f0303ae3e97427fdad33c95b6034f690b34?Signature=XXX%3D&Expires=1363258236&AWSAccessKeyId=XXX
> HTTP/1.1" 200 461220 "-" "python-requests"
>
>
Can't make much out of it, will probably need rgw logs (and preferably
with also 'debug ms = 1') for this issue.

Yehuda
