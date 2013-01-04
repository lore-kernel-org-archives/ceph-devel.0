From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH v2] rbd: Support plain/json/xml output formatting
Date: Fri, 04 Jan 2013 15:50:05 -0800
Message-ID: <50E76AAD.1040808@inktank.com>
References: <50CF559E.9040504@inktank.com> <1355919440-24357-1-git-send-email-psomas@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52486 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab3ADXuL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 18:50:11 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so9421836pbb.25
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 15:50:11 -0800 (PST)
In-Reply-To: <1355919440-24357-1-git-send-email-psomas@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stratos Psomadakis <psomas@grnet.gr>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 12/19/2012 04:17 AM, Stratos Psomadakis wrote:
> This patch renames the --format option to --image-format, for specyfing the RBD
> image format, and uses --format to specify the output formating (to be
> consistent with the other ceph tools). To avoid breaking backwards compatibility
> with existing scripts, rbd will still accept --format [1|2] for the image
> format, but will print a warning message, noting its use is deprecated.
>
> The rbd subcommands that support the new --format option are : ls, info, snap
> list, children, showmapped, lock list.
>
> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
> ---
> Hi,
>
> this is the updated version of the patch. I renamed --format option to
>   --image-format, and used --format to specify the output formatting, as you
> suggested.
>
> I also implemented some basic error checking on the --format input, and modified
> the rbd subcommands you mentioned, to support plain/json/xml output formatting.
> Although, I'm not sure if the json and xml output of those commands is what
> you'd want.
>
> The style issues should also be resolved now.
>
> Let me know what you think.

There were still some style issues (missing braces, long lines, and
spaces instead of tabs), but I squashed fixes to those into the
wip-rbd-formatted-output branch.

I changed the output a bit to uses ints, arrays, etc. where it
seemed appropriate. The tests aren't quite done yet, but does
this new json output look good to you?

Josh

