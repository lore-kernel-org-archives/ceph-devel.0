From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] Python Ioctx.get_xattrs does not take xattr_name
Date: Wed, 10 Jul 2013 13:46:28 -0700
Message-ID: <51DDC824.5000004@inktank.com>
References: <20130709151533.GN2650@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44785 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab3GJUra (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 16:47:30 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so7123276pad.9
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 13:47:29 -0700 (PDT)
In-Reply-To: <20130709151533.GN2650@sventech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: ceph-devel@vger.kernel.org

On 07/09/2013 08:15 AM, Johannes Erdfelt wrote:
> Fixes bug 5528
>
> Since it returns all xattrs, it does not take an xattr_name. Also,
> add unit tests for the Object xattrs methods.
>
> Signed-off-by: Johannes Erdfelt <johannes@erdfelt.com>

Applied to next and master, thanks!

Josh

