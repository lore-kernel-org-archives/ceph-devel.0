From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 05/16] rbd: define dup_token()
Date: Wed, 11 Jul 2012 16:50:06 -0500
Message-ID: <4FFDF50E.80809@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8733.9090305@inktank.com> <CAC-hyiEUrYmXqxB3gHQYukKPWSP50-x9=jP94hmv_kGqGy5x5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:55500 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242Ab2GKVuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 17:50:08 -0400
Received: by ghrr11 with SMTP id r11so1774482ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 14:50:07 -0700 (PDT)
In-Reply-To: <CAC-hyiEUrYmXqxB3gHQYukKPWSP50-x9=jP94hmv_kGqGy5x5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 12:48 PM, Yehuda Sadeh wrote:
> I assume this is specialized enough so that there's no risk in reusing
> it in a different context, so for this one we can keep it this way.

I agree on this one.  It's only  used in argument parsing right now.
If we find we want to use it in a place that needs better control it's
easy enough to add the gfp argument.

					-Alex
