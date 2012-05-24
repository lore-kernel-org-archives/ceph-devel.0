From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: write-through cache
Date: Wed, 23 May 2012 17:44:11 -0700
Message-ID: <4FBD845B.5030402@inktank.com>
References: <CA+jddaPW1YpHqo667dD6_9ce8iRhQLOX911-dWKT+XRFMR3YGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41752 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2EXAoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 20:44:13 -0400
Received: by pbbrp8 with SMTP id rp8so10641055pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 17:44:13 -0700 (PDT)
In-Reply-To: <CA+jddaPW1YpHqo667dD6_9ce8iRhQLOX911-dWKT+XRFMR3YGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On 05/23/2012 04:44 PM, Mandell Degerness wrote:
> I would like to test the effect of using the new write-through cache
> on RBD volumes mounted to Openstack VMs.  What, precisely, are the
> changes I need to make to the volume XML in order to do so?

If your only volumes are rbd, you can append 
:rbd_cache=true:rbd_cache_max_dirty=0 to the image name in the volume 
xml, so it would include something like

<source protocol="rbd" 
name="pool/image:rbd_cache=true:rbd_cache_max_dirty=0">

Josh
