From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGW & Object Tagging
Date: Thu, 2 Mar 2017 12:10:27 -0800
Message-ID: <CADRKj5QbkHAGKKqeA7EbABUjJ559Hh6O4cJtQN0pHHC-4UgspQ@mail.gmail.com>
References: <874lzcq5rm.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35583 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdCBUKj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 15:10:39 -0500
Received: by mail-ot0-f179.google.com with SMTP id x37so15564320ota.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Mar 2017 12:10:38 -0800 (PST)
In-Reply-To: <874lzcq5rm.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

On Wed, Mar 1, 2017 at 9:13 AM, Abhishek L <abhishek@suse.com> wrote:
> Last November, S3 introduced a new set of APIs for Object Tagging[1],
> which are simply key value metadata associated with objects, this
> however doesn't seem to be an API wrapped around the already existing
> x-amz-meta-* tags[2]. Also, beyond an API to GET/PUT/POST tags, S3 also
> seems to have support for tags in their LifeCycle, ACL and CloudWatch
> Metrics.
>
> Would such an API make sense for RGW?
> I'd imagine implementing the API itself wouldn't be that difficult and
> would fit similar to the way we handle object metadata & ACLs etc
> currently. Adding this to elasticsearch might be interesting, but
> supporting this in ACLs & LifeCycle might require much more work.
> Thoughts?
>

I'm all for implementing it. However, one thing that I'm missing in
this api is the ability to search objects by tags. I think that's a
useful feature that we can think of adding. E.g., a list bucket
request that includes a tags=<list of tags> and that will return any
object that includes one of these tags. This will require indexing
data by tags, which will require some thinking as to how to do it
correctly.

Thanks,
Yehuda
