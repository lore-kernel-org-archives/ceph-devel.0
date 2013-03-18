From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [radosgw] Race condition corrupting data on COPY ?
Date: Mon, 18 Mar 2013 17:39:21 +0100
Message-ID: <CAF6-1L7vTi0EbFPsu7S2xaW89jRFFvP6JZeaD+tSdEKd=yfWzg@mail.gmail.com>
References: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
	<CAC-hyiGy9RWf_ZJ8d4rPwZETRcOiDGx505=tj1n0_+VivXi8qA@mail.gmail.com>
	<CAF6-1L5QQrKpBPxY1-P-8i1EX8k8N7hT79Rx2oNF0pZMxJMSpg@mail.gmail.com>
	<CAC-hyiHLsjd7UAWHq9DWsZyGqLTyeKp28VV84gKrr-8Kmo-+Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:52475 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab3CRQjX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 12:39:23 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so2588379bkc.16
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 09:39:22 -0700 (PDT)
In-Reply-To: <CAC-hyiHLsjd7UAWHq9DWsZyGqLTyeKp28VV84gKrr-8Kmo-+Aw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> Can't make much out of it, will probably need rgw logs (and preferably
> with also 'debug ms = 1') for this issue.

Well, the problem is that I can't make it happen again ... it happened
4 times during an import of ~3000 files ... I'm trying to reproduce
this on a test cluster but so far, no luck. I'll give it another shot
tomorrow.

And I can't enable debug on prod for long periods, the space for log
is limited and would be filled in minutes with all the requests. I
also disabled the use of copy in production anyway because I can't
have it corrupt random customer files.


Cheers,

    Sylvain
