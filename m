From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: new naming convention for building repos and binaries from
 branches
Date: Fri, 7 Oct 2016 19:16:57 +0000
Message-ID: <26CBB0BA-AF47-40AB-BF35-B50F5A6501A3@Teradata.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
 <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33577 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751959AbcJGTRA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2016 15:17:00 -0400
In-Reply-To: <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com>
Content-Language: en-US
Content-ID: <E780A0359A6E564C8C20791C8463F1D6@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


> On Oct 7, 2016, at 7:27 AM, Andrew Schoen <aschoen@redhat.com> wrote:
> 
>> I think we need a "do not build" prefix and a "build this asap" prefix.
>> Maybe nobuild-* and asap-*?
>> 
> 
> Is the 'asap-*' want here because of the typical long wait on the gitbuilders?
> 
> The way we're configured now we can build 10 branches at a time, all
> of those branches building for 3 distros. I haven't seen a build take
> longer than an hour or so. It'd be easy to scale that up as well, but
> I don't see the queue ever being backed up at our current load.

Most of the builds will be building almost the same files, I hope you guys are
using build caching mechanisms such as ccache to accelerate the build time.

Nitin


