From: hemant surale <mike.ryan@inktank.com>
Subject: Re: How to mount all cluster data to one particular Dir in single Host.
Date: Thu, 30 Aug 2012 20:51:59 +0530
Message-ID: <CAGfy=6nLrqXe2TejYUXVxV+PYOstPkFEo2OjLwVhfL5-fqiH0Q@mail.gmail.com>
References: <CAGfy=6nT2w7wqH30QscDREydNg2CS7uGURdx0E-2_qOGqaScoQ@mail.gmail.com>
	<20120830144549.GD19573@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45118 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2H3P2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 11:28:12 -0400
Received: by pbbrr13 with SMTP id rr13so3313625pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 08:28:12 -0700 (PDT)
In-Reply-To: <20120830144549.GD19573@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>

Sir,
I have some doubt regarding write and read operations performed.
Q1.
          Write goes to primary first and then appropriate replicas
can be updated but how read request is served ? does any replica can
answer read request or that also need to be served with primary copy
only?

Q2.
         How does primary is selected ? Can we get the info about
which is primary for particular object?

Till now I successfully able to put file into particular pool using
"rados put" .
Thanks for your prompt reply Sir. I will definitely go for Ceph v0.51
and Ubuntu 12.04.

Regards,
Hemant Surale.

On Thu, Aug 30, 2012 at 8:15 PM, Mike Ryan <mike.ryan@inktank.com> wrote:
> On Thu, Aug 30, 2012 at 04:36:13PM +0530, hemant surale wrote:
>> Is it possible to mount all cluster data on directory present at
>> single node?
>
> Are you trying to see the raw data, how files are stored by the OSD? You
> can't mount them remotely, but you can log into your VMs and look in the
> OSDs' data directories.
>
>> v0.31 & ubuntu 11.10
>
> These are both very old, and we don't support them anymore. For ceph you
> should look into argonaut v0.48.1 or a more recent tag v0.51. For
> Ubuntu, we recommend Precise 12.04.
