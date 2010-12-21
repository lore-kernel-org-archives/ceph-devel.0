From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for ceph-gui
Date: Tue, 21 Dec 2010 16:32:12 -0500
Message-ID: <AANLkTi=svKVzDkiKCYj5LD-_Vc4ZR0VY+_u0R9ZhC-XY@mail.gmail.com>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	<1292358476.25794.88.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
	<1292359839.25794.99.camel@julia.gcs.org.hu>
	<AANLkTikmi_Ke02Fd4BrRXGCiKHSuQhCwY6UME+QU04Uh@mail.gmail.com>
	<1292942649.25876.36.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:61442 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0LUVcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 16:32:14 -0500
Received: by fxm18 with SMTP id 18so4867610fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 13:32:13 -0800 (PST)
In-Reply-To: <1292942649.25876.36.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Dec 21, 2010 at 9:44 AM, Laszlo Boszormenyi <gcs@debian.hu> wrote:
> Hi Colin,
>
> On Tue, 2010-12-14 at 13:06 -0800, Colin McCabe wrote:
>> Yeah, after some discussion, I think we're sticking with gceph. Sorry
>> for the email spam :)
>  Don't worry, I'm always open for discussions. Only please don't make me
> believe I changed your mind about any change in ceph development or I'll
> apply for a job there and ask for some money in return. :)

Hehe. It was mostly an IRC discussion we had in #ceph, combined with a
general preference for shorter names. ;)

>
>> Let me know if you have any issues w/ packaging...
>  I've a question. gceph needs everything noted in debian/ceph.install
> (cephfs, cconf, ... the rados classes and manpages), right? The best
> would be to make a ceph-common package, depending on ceph | gceph and
> the latter packages would contain only the binaries ceph and gceph
> respectively. Am I right?

Yeah. gceph should be a separate, optional package. If you install
gceph, you definitely want the rest of the ceph system, but not vice
versa.

I'm not sure if it makes sense to split off the command-line ceph tool
from the rest of the ceph binaries. It's not a lot of code, and it is
a handy little binary. I guess potentially we could do it if it makes
the packaging cleaner.

cheers,
Colin
