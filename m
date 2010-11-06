From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [RFC] rbd sysfs interface
Date: Fri, 5 Nov 2010 22:51:26 -0700
Message-ID: <AANLkTinQK_9qp-8jJ5j3-ChUjwhGiGzAmCu5cBtHX75g@mail.gmail.com>
References: <AANLkTinOeby9P847gJFn_t0h5nDY7cfi3cW9hEaUrS1v@mail.gmail.com>
	<20101106050721.GA2194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52006 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0KFFv2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Nov 2010 01:51:28 -0400
In-Reply-To: <20101106050721.GA2194@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, linux-kernel@vger.kernel.org

On Fri, Nov 5, 2010 at 10:07 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 05, 2010 at 04:09:31PM -0700, Yehuda Sadeh Weinraub wrote:
>>
>> Does this seem sane? Any comments would be greatly appreciated.
>
> It sounds like you need to use configfs instead of sysfs, as your model
> was the reason it was created.
>
> Have you tried that?

Oh, will look at it now. With ceph (although for a different purpose)
we went through proc -> sysfs -> debugfs, however, it seems that we've
missed at least one userspace-kernel channel.

Thanks,
Yehuda
