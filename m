From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph osd create
Date: Mon, 20 Aug 2012 13:30:27 -0700
Message-ID: <CA+jddaP=-6kO-ewLoNnWeg6b552p=nLA6ycQt_4qoDj7sVHy0w@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
	<CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61634 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2HTUa2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 16:30:28 -0400
Received: by qcro28 with SMTP id o28so4630962qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 13:30:27 -0700 (PDT)
In-Reply-To: <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Follow up question:

Is there now, or will there be a migration path that works to add
existing OSDs to the function such that future calls to "ceph osd
create <uuid>" return the current OSD number used in an existing
configuration?  I am content if it is an undocumented hack that I can
run on each OSD to register the information with the monitors (I am
assuming that is where the correlation is stored).

Regards,
Mandell Degerness

On Wed, Aug 1, 2012 at 4:43 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Wed, Aug 1, 2012 at 4:27 PM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
>> As of this time, we are allocating OSD numbers based on servers.  The
>> "ceph osd create" command seems like it may be useful, but is not
>> documented nearly well enough yet. Can someone please provide answers
>> to the following:
>>
>> 1. Is this guaranteed to always produce an OSD number that is unique,
>> with no worries about race conditions?
>
> Yes.
>
> You can also use "ceph osd create UUID", so it's safe to run multiple
> times, get the same result for the same UUID, and not waste numbers.
>
>> 2. Does this eliminate the need to worry about the value of max_osd?
>
> It increases max_osd as necessary.
> https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L2167
>
>> 3. Are there any other side effects of running the command?
>
> Nope.
>
>
> You may be interested in digging into the mechanics of the new chef
> deployment stuff, and "osd hotplugging" as I call it. It completely
> automates osd id allocation.
>
> http://ceph.com/docs/master/install/chef/
> http://ceph.com/docs/master/config-cluster/chef/
>
> More architectural docs don't really exist yet, sorry.
