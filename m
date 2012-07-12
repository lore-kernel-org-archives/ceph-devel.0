From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 13/16] rbd: rename some fields in struct rbd_dev
Date: Thu, 12 Jul 2012 06:14:48 -0500
Message-ID: <4FFEB1A8.7030203@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8789.2010204@inktank.com> <4FFDE997.3010400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:48690 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351Ab2GLLOu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 07:14:50 -0400
Received: by ghrr11 with SMTP id r11so2251665ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 04:14:49 -0700 (PDT)
In-Reply-To: <4FFDE997.3010400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 04:01 PM, Josh Durgin wrote:
>> Also rename a related symbol name:
>>      RBD_MAX_MD_NAME_LEN -->  RBD_MAX_HEADER_NAME_LEN
> 
> Looks like this got removed in patch 9.

Yes you're right.  I forgot to update the comment when I
reordered the patches.  Thanks.

					-Alex

