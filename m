From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v3 04/16] libceph: define ceph_extract_encoded_string()
Date: Thu, 12 Jul 2012 17:47:31 -0500
Message-ID: <4FFF5403.80406@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com> <4FFDF9B8.5040401@inktank.com> <4FFF05D4.9080006@inktank.com> <alpine.DEB.2.00.1207121117140.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49685 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162395Ab2GLWre (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 18:47:34 -0400
Received: by gglu4 with SMTP id u4so3017125ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 15:47:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207121117140.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/12/2012 01:20 PM, Sage Weil wrote:
> I think the caller should be able to distinguish between these two cases 
> in the return value.  What about:
> 
>> > + */
>> > +static inline char *ceph_extract_encoded_string(void **p, void *end,
>> > +						size_t *lenp, gfp_t gfp)
> 
> int ceph_extract_encoded_string(void **p, void *end, char **str, gfp_t gfp)
> 
> and return the length, or an error code?  That avoids futzing with ERR_PTR 
> and gives you the len a bit less awkwardly...
> 

I opted to stick with my original prototype--returning the string--and
using the ERR_PTR() etc.  I return the string because I *always* want
that.  Only sometimes is the length needed.

					-Alex

