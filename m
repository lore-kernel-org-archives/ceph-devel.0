From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v3 04/16] libceph: define ceph_extract_encoded_string()
Date: Thu, 12 Jul 2012 14:48:35 -0500
Message-ID: <4FFF2A13.4050407@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com> <4FFDF9B8.5040401@inktank.com> <4FFF05D4.9080006@inktank.com> <alpine.DEB.2.00.1207121117140.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56415 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab2GLTsh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 15:48:37 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so2836603ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 12:48:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207121117140.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/12/2012 01:20 PM, Sage Weil wrote:
> I think the caller should be able to distinguish between these two cases 
> in the return value. 

OK.  I'll adjust and repost.	-Alex
