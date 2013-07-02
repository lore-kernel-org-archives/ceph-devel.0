From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 2 Jul 2013 15:56:34 -0400
Message-ID: <CANP1eJGqq0ocQQUS5sBsvdT35qADSMoFLC71uprt_qw7=Pphrg@mail.gmail.com>
References: <20130629035155.GA7975@gmail.com>
	<CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com>
	<CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
	<11954.1372792498@warthog.procyon.org.uk>
	<CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com>
	<12577.1372793962@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64032 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab3GBT4e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 15:56:34 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so12219713ieb.24
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jul 2013 12:56:34 -0700 (PDT)
In-Reply-To: <12577.1372793962@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

David,

It hasn't changed since the patch I posted inline 4 days ago (same as
the one that went out to linux-cachefs mailing list). You can also get
the 'wip-ceph-fscache' branch from my gitrepo:
https://bitbucket.org/adfin/linux-fs.git. Finally, you can take a look
at the changes in the browser here:
https://bitbucket.org/adfin/linux-fs/commits/61908aea3ce3faf8eda7bdbbbd604068aa3283c9?at=wip-ceph-fscache

I understand you won't be able to run it, but it's still worth it to
see if I'm doing anything that feels wrong.

Thanks,
- Milosz


On Tue, Jul 2, 2013 at 3:39 PM, David Howells <dhowells@redhat.com> wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
>
>> I just looked and saw that it's been pulled a couple hours ago.
>>
>> Can I also trouble you into looking at my patches for Ceph for the
>> FSCache? We're using it (in production starting today actually); we're
>> not able to find any bugs with the current iteration. But it's always
>> nice to have an extra pair of eyes (esp from the maintainer of
>> FSCache).
>
> I'll have a look, but I can't run them as I don't have Ceph set up.
>
> Can you point me at or email me your current patches, just so as I'm looking
> at up to date stuff?
>
> David
