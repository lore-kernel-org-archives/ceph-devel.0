From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: URL-safe base64 encoding for keys
Date: Tue, 3 Jul 2012 10:25:40 -0700
Message-ID: <CAC-hyiEaWqkL9edxyyOBxSqqQa0=6gnZ8W179g5KVX+JLpkDdQ@mail.gmail.com>
References: <4FF2E40B.8090705@widodh.nl>
	<CAPUexz8ThDn+pfqLT1azRMbHeQZP_q-_yD3O-10C=mZ5NnwYpw@mail.gmail.com>
	<CAC-hyiHXV448LMT0qkO2hvpaHw6R4WSu1rvy5L08QeABDLhjww@mail.gmail.com>
	<CAPUexz97CxNgMZj2NWh7FqmV4OdnjJudu504un_4oc9Tevf3BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45457 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab2GCRZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:25:42 -0400
Received: by bkwj10 with SMTP id j10so1921099bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 10:25:41 -0700 (PDT)
In-Reply-To: <CAPUexz97CxNgMZj2NWh7FqmV4OdnjJudu504un_4oc9Tevf3BQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org\"" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 10:23 AM, Florian Haas <florian@hastexo.com> wrote:
> On Tue, Jul 3, 2012 at 5:04 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>> FWIW (only semi-related), some S3 clients -- s3cmd from s3tools, for
>>> example -- seem to choke on the forward slash in radosgw
>>> auto-generated secret keys, as well.
>>>
>>
>> With radosgw we actually switch a while back to use the alternative
>> encoding. If you still have some old access keys, just replace them.
>
> Is "a while back" after 0.47.3? Because I was definitely keys with "/"
> from that version.
>
There are the access keys and there are the secrets. The access keys
are now url safe, the secrets are not.

Yehuda
