From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Mapping between PG & OSD
Date: Wed, 29 Aug 2012 10:16:03 +0530
Message-ID: <CAGfy=6nWN0=dCPLUv=Bo5jig_Q21pFa=H=qdkEhDRXNcoZ6R+A@mail.gmail.com>
References: <CAGfy=6=6uuw=eGLxTO7Uk_uFi=1FzyhToMXUN8izXjRyHWEWmQ@mail.gmail.com>
	<CADvuQRHoNP2anO0KVS8uaiU-cR+ELAfS2JiP-JgYwy=e_a3DSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53557 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab2H2EqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 00:46:04 -0400
Received: by vcbfk26 with SMTP id fk26so165364vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 21:46:03 -0700 (PDT)
In-Reply-To: <CADvuQRHoNP2anO0KVS8uaiU-cR+ELAfS2JiP-JgYwy=e_a3DSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Tommi ,
      Actually I was thinking of "Availability" of related files to
particular host. I wanted to guide ceph in some way to store related
files for host on his local osd so that I/O over network can be
reduced . One more doubt I would like to ask is Whether read/write
requests are sent to primary only Or only write requests are sent to
primary while read request can be served by any OSD having object
replica ?



Regards,
Hemant Surale.

On Tue, Aug 28, 2012 at 8:54 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Aug 27, 2012 at 11:50 PM, hemant surale <hemant.surale@gmail.com> wrote:
>> Hi All ,
>>       I was unable to figure out how we can direct the ceph to store
>> data based on host needs i.e. Host A wants to keep frequently used
>> data on its own local OSD. So my question is about how we can direct
>> such write/read requests to local OSD than on network? Is it possible
>> ?
>
> Due to the nature of CRUSH -- being a deterministic pseudorandom
> distribution and all -- the writer does not get to choose where n
> object is stored.
>
> The closest thing you can do is have a RADOS pool with a CRUSH ruleset
> that puts the primary on that machine. As you'd need a pool per
> machine, this really doesn't scale up well.
>
> Perhaps the benefits of the scheme you are envisioning aren't as great
> as you think they would be. Often accessing lots of fast servers over
> a fast network performs better than a single local disk.
