From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: No function to list the pool in rados.py
Date: Fri, 02 Dec 2011 14:11:51 -0800
Message-ID: <4ED94D27.8090101@dreamhost.com>
References: <8512670932FB654F81AF0FEF1BE6D49D8EB4D1@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41076 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab1LBWLv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 17:11:51 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D8EB4D1@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On 12/01/2011 09:33 PM, Eric_YH_Chen@wistron.com wrote:
> Hi, ceph developments:
>
>    Could we add one more function in rados.py to list the pool?
>
>    I had already implemented the function. Thanks a lot!
>
> class Rados(object):
>      def list(self):
>          size = c_size_t(512)
>          while True:
>              c_names = create_string_buffer(size.value)
>              ret = self.librados.rados_pool_list(self.cluster,
> byref(c_names), size)
>              if ret>  size.value:
>                  size = ret
>              else:
>                  break
>          return filter(lambda name: name != '', c_names.raw.split('\0'))

Added in c883100448bb7e86b4f0d52a425e0d0a278c79a0 with a couple small 
changes to check that we're connected and keep the type of size c_size_t.

Next time if you could send a patch or github pull request it'd be 
easier to apply.

Thanks!
Josh
