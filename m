From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Thu, 14 Sep 2017 13:44:22 +0200
Message-ID: <87inglfqsp.fsf@suse.com>
References: <CAMMFjmHk-YfW6-qnJmgQOWj-cdRO86ggHK-2y27GN1u-Ao8X-w@mail.gmail.com> <CA+2bHPZ9fjx2Z8uUc-Fo+TsO-m9+PspG2T=NStGdo51FyL-eAQ@mail.gmail.com> <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38890 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdINLoY (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 14 Sep 2017 07:44:24 -0400
In-Reply-To: <CA+2bHPboXJXgzz-aHkWYFqB1EH-tzDHShXSwbkn8EAeogggUjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>

Patrick Donnelly <pdonnell@redhat.com> writes:

> On Wed, Sep 13, 2017 at 8:49 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> On Wed, Sep 13, 2017 at 8:40 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>> This email is an attempt to make sure that all are clear on luminous
>>> v12.2.1 release status.
>>>
>>> Dev leads - what is left before we can start QE validation?
>>
>> To be merged into master today and then backported:
>> http://tracker.ceph.com/issues/21378
>> Luminous backport: http://tracker.ceph.com/issues/21357
>> To be merged into master today and then backported:
>> http://tracker.ceph.com/issues/20594
>
> Final list of CephFS backports needed for 12.2.1:
>
> http://tracker.ceph.com/issues/21323
> http://tracker.ceph.com/issues/21114
> http://tracker.ceph.com/issues/21107
> http://tracker.ceph.com/issues/21357
> http://tracker.ceph.com/issues/21322
> http://tracker.ceph.com/issues/21384
>

So scheduled the relevant suites (rgw,rados,fs) at priority 100 right
now) for the current PRs targeting Luminous, 
http://tracker.ceph.com/issues/21296#note-15

if this run goes through, lets merge these PRs to luminous and handover
to Yuri

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
