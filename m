From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next infernalis release v9.2.1
Date: Fri, 12 Feb 2016 10:13:49 -0800
Message-ID: <CAJ4mKGaWYit3X2j8bhsZyiG2ODUinAmTjbS6W3uVzHwALHG4Mw@mail.gmail.com>
References: <CAP3mxSwYvhDwi8Bzd3DSUAph+7Cchmtjw-QqtsDgkoN-CBkAjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35710 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbcBLSNu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Feb 2016 13:13:50 -0500
Received: by mail-wm0-f48.google.com with SMTP id c200so32325364wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Feb 2016 10:13:50 -0800 (PST)
In-Reply-To: <CAP3mxSwYvhDwi8Bzd3DSUAph+7Cchmtjw-QqtsDgkoN-CBkAjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Thu, Feb 11, 2016 at 11:36 PM, Abhishek Varshney
<abhishek.varshney@flipkart.com> wrote:
> Hi Greg,
>
> The next infernalis release as found at
> https://github.com/ceph/ceph/tree/infernalis passed most of the CephFS
> suite ( http://tracker.ceph.com/issues/13750#note-19 ) except for 1
> failure, which was not seen at a later run (
> http://tracker.ceph.com/issues/13750#note-26 ). Do you think the
> infernalis branch is ready for QE to start their own round of testing
> ?

Uh, assuming I'm reading this correctly, you've hit a known
intermittent bug which happened to show up on one run, but not the
next.

You can release without the fix (it's not a regression), but please
realize that we have a lot of intermittent bugs so just because an
issue doesn't appear in one run doesn't mean the issue is gone. :)
-Greg
