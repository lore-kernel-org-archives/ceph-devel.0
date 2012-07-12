From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 10/16] rbd: dynamically allocate image name
Date: Thu, 12 Jul 2012 06:12:23 -0500
Message-ID: <4FFEB117.2030104@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8769.90501@inktank.com> <4FFDE6C8.8070906@inktank.com> <4FFDE789.2080203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41569 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030566Ab2GLLMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 07:12:25 -0400
Received: by ghrr11 with SMTP id r11so2250016ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 04:12:24 -0700 (PDT)
In-Reply-To: <4FFDE789.2080203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 03:52 PM, Josh Durgin wrote:
>>> - int obj_len;
>>> + char *obj; /* rbd image name */
>>> + size_t obj_len;
> 
> On second look, obj_len can be a local variable. It's not used
> outside of option parsing.

I use it in a patch later--in some changes I have not yet posted.

					-Alex

