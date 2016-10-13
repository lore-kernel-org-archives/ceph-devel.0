From: Alfredo Deza <adeza@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Thu, 13 Oct 2016 08:20:42 -0400
Message-ID: <CAC-Np1xnSoNth7rn-9Cu=ws_=6AwMQP7zKvgu2URi5-dTijndg@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to> <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com>
 <26CBB0BA-AF47-40AB-BF35-B50F5A6501A3@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35031 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbcJMMUn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 08:20:43 -0400
Received: by mail-qk0-f170.google.com with SMTP id z190so86115449qkc.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 05:20:43 -0700 (PDT)
In-Reply-To: <26CBB0BA-AF47-40AB-BF35-B50F5A6501A3@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Andrew Schoen <aschoen@redhat.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 7, 2016 at 3:16 PM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
>> On Oct 7, 2016, at 7:27 AM, Andrew Schoen <aschoen@redhat.com> wrote:
>>
>>> I think we need a "do not build" prefix and a "build this asap" prefix.
>>> Maybe nobuild-* and asap-*?

What we are going to start with *today* is to build every branch that
is prefixed with "wip-" since
that is the implicit/historical naming convention for branches.

We will include all the release branches (e.g. hammer, infernalis,
jewel, kraken) as well
as master.

This will allow the "do not build this" branches to just be anything
not prefixed with "wip-" (there are already a few of those
today, like dnm- and testing-)

>>>
>>
>> Is the 'asap-*' want here because of the typical long wait on the gitbuilders?
>>
>> The way we're configured now we can build 10 branches at a time, all
>> of those branches building for 3 distros. I haven't seen a build take
>> longer than an hour or so. It'd be easy to scale that up as well, but
>> I don't see the queue ever being backed up at our current load.
>
> Most of the builds will be building almost the same files, I hope you guys are
> using build caching mechanisms such as ccache to accelerate the build time.
>
> Nitin
>
>
