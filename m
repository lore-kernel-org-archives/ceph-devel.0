From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 17/33] libceph: introduce get_osdmap_client_data_v()
Date: Fri, 28 Mar 2014 16:59:37 +0200
Message-ID: <CALFYKtBd=fsLcD_Zyz88_grvGhGvYDsiirscU-Zhdp_K9JzQug@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-18-git-send-email-ilya.dryomov@inktank.com>
	<53348771.6060201@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61633 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaC1O7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 10:59:38 -0400
Received: by mail-qa0-f50.google.com with SMTP id o15so5288943qap.37
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 07:59:37 -0700 (PDT)
In-Reply-To: <53348771.6060201@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:17 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Full and incremental osdmaps are structured identically and have
>> identical headers.  Add a helper to decode both "old" (16-bit version,
>> v6) and "new" (8-bit struct_v+struct_compat+struct_len, v7) osdmap
>> enconding headers and switch to it.
>
> It wasn't clear to me at first that this was adding a
> new bit of functionality--support for v7 OSD map encodings.
>
> A couple comments below but this looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  net/ceph/osdmap.c |   81 ++++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 65 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 0134df3639d2..ae96c73aff71 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -683,6 +683,63 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>>       return 0;
>>  }
>>
>> +#define OSDMAP_WRAPPER_COMPAT_VER    7
>> +#define OSDMAP_CLIENT_DATA_COMPAT_VER        1
>
> Don't these definitions belong in a common header?

I think it would be out of context in a common header.  It's just so
that the error string is updated whenever the actual integer changes,
a poor substitute for a piece of ceph.git DECODE magic.

>
>> +/*
>> + * Return 0 or error.  On success, *v is set to 0 for old (v6) osdmaps,
>> + * to struct_v of the client_data section for new (v7 and above)
>> + * osdmaps.
>> + */
>> +static int get_osdmap_client_data_v(void **p, void *end,
>> +                                 const char *s, u8 *v)
>
> I like to avoid one-character names (in this case, "s").
> Mainly because it's hard to search for them.
>
> You could pass a Boolean "full" and use that to select
> what's printed in the warning messages.

I was passing "incremental" bool at one point, similar to the other
helpers, but then changed it because it made it look like this function
does different things for full and incremental maps, when the whole
point is that their headers are the same.  I'll rename "s" to "prefix"
though.

Thanks,

                Ilya
