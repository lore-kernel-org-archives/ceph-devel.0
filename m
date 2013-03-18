From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [radosgw] Race condition corrupting data on COPY ?
Date: Mon, 18 Mar 2013 06:29:41 -0700
Message-ID: <CAC-hyiGy9RWf_ZJ8d4rPwZETRcOiDGx505=tj1n0_+VivXi8qA@mail.gmail.com>
References: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63281 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab3CRN3m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 09:29:42 -0400
Received: by mail-ie0-f178.google.com with SMTP id c13so7086859ieb.9
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 06:29:41 -0700 (PDT)
In-Reply-To: <CAF6-1L6+un7+z0MmCH=vKzkXUOevhFDAneYqC3Krxm3nb0LP1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 18, 2013 at 2:50 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
> I've just noticed something rather worrying on our cluster.
>
> Some files are apparently truncated. From the first look I had at it,
> it happened on files where there was a metadata update right after the
> file was stored. The exact sequence was:
>
>  - PUT to store the file
>  - GET to get the file (which at that point is still correct and has
> the proper length)
>  - PUT using a 'copy source' over itself to update the metadata
>
> all of theses happening sequentially in the same second, very quickly.
>
> Then subsequent GET return a truncated file.
>
>
> I'm looking into it to narrow down the issue but I wanted to know if
> anyone had seen something similar ?
>
>
What version are you using? Do you have logs?

Thanks,
Yehuda
