From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: storlets
Date: Fri, 26 Sep 2014 09:20:16 -0700
Message-ID: <CABBk=J9S3Y_6aWSj82ixtFUk-+8aDdtudZHRG0iVARy70ikuMw@mail.gmail.com>
References: <alpine.DEB.2.00.1409260641260.30637@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61309 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaIZQUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 12:20:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id y13so13073890pdi.1
        for <ceph-devel@vger.kernel.org>; Fri, 26 Sep 2014 09:20:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409260641260.30637@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 26, 2014 at 6:43 AM, Sage Weil <sweil@redhat.com> wrote:
> http://domino.research.ibm.com/library/cyberdig.nsf/papers/7233ABCCEC84F0BF85257D3100559FD6/$File/H-0320.pdf
> http://researchweb.watson.ibm.com/haifa/projects/storage/datastores/papers/StorletEnginePaper_CameraReady.pdf
>
> This is similar in concept to rados classes for the zerovm stuff, done in
> the context of swift.  It would be great to create a model for doing
> this sort of computation with RGW that takes advantage of rados classes
> where possible.  It's tricky because we're striping data...
>

These can still run on the rgw nodes (similar to the storlets running
on the proxy nodes in the swift case). Ones that run on the data nodes
will need to be stripe-aware obviously. Another possibility is to not
stripe, and have a large object size limit. Swift has a 5GB object
size limit iirc, so it's not much different. Of course, there are
other issues in ceph with larger objects (e.g., deep scrubbing), so
these will need to be addressed too.

Yehuda
