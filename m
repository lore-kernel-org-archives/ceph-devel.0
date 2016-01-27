From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH]common/str_map: Removed unnecessary function overloading
 of get_str_map()
Date: Wed, 27 Jan 2016 10:43:23 +0100
Message-ID: <CAOi1vP-w+EHRON1QLALYGJQvmAuFux2mRBn26ZcCutSEF_HnMw@mail.gmail.com>
References: <CAAKF69rJmAA2rNaFjDetkN5-1uQf+UZXhmD9xXx+89-S0goE4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38526 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbcA0JnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 04:43:25 -0500
Received: by mail-wm0-f41.google.com with SMTP id p63so17248784wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 01:43:24 -0800 (PST)
In-Reply-To: <CAAKF69rJmAA2rNaFjDetkN5-1uQf+UZXhmD9xXx+89-S0goE4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sahithi R V <sahithi.rv1@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 27, 2016 at 7:23 AM, Sahithi R V <sahithi.rv1@gmail.com> wrote:
> Hello,
>
> This patch removes the function overloading of get_str_map() by using
> CONST_DELIMS as default parameters to const char *delims .It also
> replaces all the occurences of get_str_map() function with 2
> arguments, in src directory.

Hi Sahithi,

Generally, pull requests on github are preferred for getting changes
into ceph.  The only exception to that is the kernel client, which is
a bit of a special snowflake.  We aren't picky and will forward patches
back and forth, but a pull request on github would speed things up.

See https://github.com/ceph/ceph/blob/master/SubmittingPatches.rst.

Thanks,

                Ilya
