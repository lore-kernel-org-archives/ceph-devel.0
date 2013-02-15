From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw: Update a key's meta data
Date: Fri, 15 Feb 2013 09:29:33 -0800
Message-ID: <CAC-hyiFb6RkXGGW8VMUbSeysaF2Wo2Ub_183dYSSnuBwW4TBfw@mail.gmail.com>
References: <CAF6-1L6rnEW2Gyfci_n8ffJcd5-fow-9zw1+75z40bz7TS24gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:46876 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab3BOR3f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Feb 2013 12:29:35 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so3560158iae.11
        for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 09:29:34 -0800 (PST)
In-Reply-To: <CAF6-1L6rnEW2Gyfci_n8ffJcd5-fow-9zw1+75z40bz7TS24gA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 14, 2013 at 6:37 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
> I was wondering how I could update a key's metadata like the "Content-Type".
>
> The solution on S3 seem to be to copy the key on itself and replacing
> meta data. If I do that in ceph, will it work ? And more importantly,
> will it be done "intelligently" (i.e. without copying the actual file
> data around).

Same API in S3, copying an object into itself. For Swift there's a
POST request with updated metadata. Data (other than the first chunk)
isn't really copied.

>
> I tried reading the code, but although part of the code seem to hint
> at support for this (in rgw_rest_s3.cc), some other part seem to not
> look at all if the src == dst  (like rgw_op.cc).
>

Right. It is actually missing and it's a bug. I've opened ceph issue #4150.

Thanks,
Yehuda
