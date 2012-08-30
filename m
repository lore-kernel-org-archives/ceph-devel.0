From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD Async request: When / How are the call back called ?
Date: Thu, 30 Aug 2012 08:39:35 -0700
Message-ID: <503F8937.7020900@inktank.com>
References: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com> <503E47C6.2040200@inktank.com> <CAF6-1L7GstF3ooOV7hOfCKXvFPP51Ce-mFovpt5oRm-_T=sffg@mail.gmail.com> <20120830145209.GE19573@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58103 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab2H3Pji (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 11:39:38 -0400
Received: by pbbrr13 with SMTP id rr13so3330979pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 08:39:38 -0700 (PDT)
In-Reply-To: <20120830145209.GE19573@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, ceph-devel@vger.kernel.org

On 08/30/2012 07:52 AM, Mike Ryan wrote:
> On Thu, Aug 30, 2012 at 02:16:36PM +0200, Sylvain Munaut wrote:
>> One more question: When I have async read pending, I would have
>> expected rbd_flush and/or rbd_close to wait for them to finish but
>> they dont. Is there a way to wait for all operation to be complete ?
>> Because if I shutdown everything before they are, the application
>> hangs ...
>
> There's nothing in the API for that. You have to manually iterate over
> all your completion contexts calling wait_for_safe_and_cb() on each.
>
> Note: even if you don't have a callback, you should use the _cb()
> version. I just fixed a use-after-free bug the was caused by this.

That's in librados.

In librbd there's only wait_for_complete(), which
waits for the callback to complete as well.

Josh
