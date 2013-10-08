From: Gregory Farnum <greg@inktank.com>
Subject: Re: rados_clone_range for different pgs
Date: Tue, 8 Oct 2013 09:45:59 -0700
Message-ID: <CAPYLRzgEoWRfHZQ5umUpaauDcp-cNHVuNc_p39YQodvZcq2+Tg@mail.gmail.com>
References: <CA+CdmLbW+Tb2Wz1+DNJ4yFZ7-gDG1XsPfvKGZ-H5iJZQJ=QvZw@mail.gmail.com>
	<alpine.DEB.2.00.1308020615420.15391@cobra.newdream.net>
	<CA+CdmLYG3m8VdG0dFsPE19BOi3SyLLBkss8JT20my3CebfQC_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:64233 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab3JHQqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Oct 2013 12:46:01 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so7038349lab.39
        for <ceph-devel@vger.kernel.org>; Tue, 08 Oct 2013 09:45:59 -0700 (PDT)
In-Reply-To: <CA+CdmLYG3m8VdG0dFsPE19BOi3SyLLBkss8JT20my3CebfQC_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Oct 8, 2013 at 7:40 AM, Oleg Krasnianskiy
<oleg.krasnianskiy@gmail.com> wrote:
> We use ceph to store huge files stripped into small (4mb) objects.
> Due to the fact that files can be changed unpredictably (data
> insertion/modification/deletion in any part of a file), we have to
> copy parts of the objects and it is done via the client.
> I see the following ways to solve this problem:
>  - implement a client that is launched on the same host as the source
> osd, that will handle the copy process
>  - add functionality to the osd, so it can do copy to other osds
>
> Which way best suits with the ceph ideology?

I'm a bit confused; why does chunking of files into objects
necessitate copying between objects?

In any case, I suspect you will want to do this via OSD commands
rather than by trying to put a client next to the OSD (this is subject
to races if an OSD dies, for instance). We are currently implementing
similar functionality for the first time, in order to support caching
and tiering pools. It's not yet exposed to clients, but it shouldn't
be difficult to extend our new "copyfrom" interface (used by the OSD)
to a "copy_chunk" interface that we can expose to clients and copies
part of an object into another, if somebody wants to take a stab at
it!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
