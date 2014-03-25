From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 14:34:58 +0200
Message-ID: <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<53316D18.7040103@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35244 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaCYMe7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 08:34:59 -0400
Received: by mail-qg0-f48.google.com with SMTP id j107so1113730qga.7
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 05:34:58 -0700 (PDT)
In-Reply-To: <53316D18.7040103@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

> On 03/25/2014 04:04 AM, Ilya Dryomov wrote:
>> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
>>> Hi,
>>>
>>> what can/should I do to help fix that problem ?
>>>
>>> for now, RBD kernel client hang on :
>>>         Assertion failure in rbd_img_obj_callback() at line 2131:
>>>            rbd_assert(which >= img_request->next_completion);
>
> If you can build your own kernel as Ilya says I'd like to
> see the values of which and img_request->next_completion
> here.

Looks like which was 1, which means that next_completion had to be 2 or
greater.  I miss solaris crash dumps ...

On a different note, why are we asserting next_completion outside of
a spinlock which is supposed to protect next_completion?

Thanks,

                Ilya
