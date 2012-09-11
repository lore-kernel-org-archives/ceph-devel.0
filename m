From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: crush create-or-move
Date: Tue, 11 Sep 2012 09:15:53 -0700
Message-ID: <504F63B9.7070308@inktank.com>
References: <alpine.DEB.2.00.1209110831260.1305@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64200 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2IKQP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 12:15:56 -0400
Received: by pbbrr13 with SMTP id rr13so1004506pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 09:15:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209110831260.1305@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: tv@inktank.com, ceph-devel@vger.kernel.org

On 09/11/2012 09:09 AM, Sage Weil wrote:
> Hey Tommi-
>
> I pushed a wip-crush branch that implements 'ceph osd crush create-or-move
> ...'.  I don't think it's worth backporting this to argonaut, since the
> user is actually in the deploy scripts, so any chef/juju/whatever won't
> care if they're running against argonaut or bobtail in this case.
> (Right?)  (It also depends on a bunch of option parsing cleanups that I'd
> rather not wade through.)

Don't forget to update doc/control.rst too.

>
> sage

