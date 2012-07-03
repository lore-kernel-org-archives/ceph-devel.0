From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: URL-safe base64 encoding for keys
Date: Tue, 3 Jul 2012 08:04:03 -0700
Message-ID: <CAC-hyiHXV448LMT0qkO2hvpaHw6R4WSu1rvy5L08QeABDLhjww@mail.gmail.com>
References: <4FF2E40B.8090705@widodh.nl>
	<CAPUexz8ThDn+pfqLT1azRMbHeQZP_q-_yD3O-10C=mZ5NnwYpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45745 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2GCPEF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:04:05 -0400
Received: by bkwj10 with SMTP id j10so1742068bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 08:04:03 -0700 (PDT)
In-Reply-To: <CAPUexz8ThDn+pfqLT1azRMbHeQZP_q-_yD3O-10C=mZ5NnwYpw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 8:00 AM, Florian Haas <florian@hastexo.com> wrote:
> On Tue, Jul 3, 2012 at 2:22 PM, Wido den Hollander <wido@widodh.nl> wrote:
>> Hi,
>>
>> With my CloudStack integration I'm running into a problem with the cephx
>> keys due to '/' being possible in the cephx keys.
>>
>> CloudStack's API expects a URI to be passed when adding a storage pool,
>> e.g.:
>>
>> addStoragePool?uri=rbd://user:cephxkey@monitor.addr/poolname
>>
>> If 'cephxkey' contains a / the URI parser in Java fails (java.net.URI) and
>> splits the URI in the wrong place.
>>
>> For base64 there is a specification [0] that describes the usage of - and _
>> instead of +  and /
>>
>> Is there a way that we change the bits in src/common/armor.c and replace the
>> + and / for - and _?
>
> FWIW (only semi-related), some S3 clients -- s3cmd from s3tools, for
> example -- seem to choke on the forward slash in radosgw
> auto-generated secret keys, as well.
>

With radosgw we actually switch a while back to use the alternative
encoding. If you still have some old access keys, just replace them.

Yehuda
