From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW getting revoked tokens from keystone not working
Date: Fri, 9 Aug 2013 07:19:57 -0700
Message-ID: <CABBk=J_FViXdyDjhcFRQgxqijqx_MUEG-Ftm6aMZimVDPrh1ig@mail.gmail.com>
References: <CAN04cT6ZeAYVGPthhfS0CyV6XGQt27H3VcJHEFKusqpVvCR19g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:56132 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030611Ab3HIOT6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 10:19:58 -0400
Received: by mail-vc0-f170.google.com with SMTP id kw10so1080427vcb.29
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 07:19:58 -0700 (PDT)
In-Reply-To: <CAN04cT6ZeAYVGPthhfS0CyV6XGQt27H3VcJHEFKusqpVvCR19g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

   sorry for the late response.

On Tue, Aug 6, 2013 at 5:10 AM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> Hi ceph devs,
>
> I was working with a RGW / keystone implementation, source tree from
> github master. I stumbled against this error from the radosgw log;
>
> 2013-08-06 14:00:02.523331 7f929c011780 10 allocated request req=0x1c31640
> 2013-08-06 14:00:02.556052 7f923bfff700 10 request returned
> 2013-08-06 14:00:02.556238 7f923bfff700  0 ERROR: keystone revocation
> processing returned error r=-22
>
> That was weird (nothing after the "request returned"), because I
> checked the request using curl and it actually returned data. Then I
> found this;
>
> https://github.com/ceph/ceph/blob/master/src/rgw/rgw_swift.cc#L307
>
> Shouldn't read_data be receive_data, because the received_data is
> called by the curl_easy_perform? Or else the bufferlist in
> RGWSwift::check_revoked() will remain empty at all times.
>
> I might be missing something, so that's why I'm mailing the question
> instead of mailing the patch...

Looking at it now, this is a real issue. I recently renamed the
read_data() to receive_data() to avoid any confusion and missed these.
I'll fix it for dumpling.

Thanks,
Yehuda
