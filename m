From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] pybind: trivial fix of missing argument
Date: Thu, 08 Dec 2011 13:32:29 -0800
Message-ID: <4EE12CED.4020007@dreamhost.com>
References: <1323354907-744-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46523 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1LHVc3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 16:32:29 -0500
In-Reply-To: <1323354907-744-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/08/2011 06:35 AM, Henry C Chang wrote:
> Signed-off-by: Henry C Chang<henry.cy.chang@gmail.com>
> ---
>   src/pybind/rados.py |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/pybind/rados.py b/src/pybind/rados.py
> index 3d00938..e43cb04 100755
> --- a/src/pybind/rados.py
> +++ b/src/pybind/rados.py
> @@ -450,7 +450,7 @@ written." % (self.name, ret, length))
>           ret = self.librados.rados_read(self.io, c_char_p(key), ret_buf,
>                   c_size_t(length), c_uint64(offset))
>           if ret<  0:
> -            raise make_ex("Ioctx.read(%s): failed to read %s" % (self.name, key))
> +            raise make_ex(ret, "Ioctx.read(%s): failed to read %s" % (self.name, key))
>           return ctypes.string_at(ret_buf, ret)
>
>       def get_stats(self):

Applied, thanks!
