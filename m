From: Milosz Tanski <milosz@adfin.com>
Subject: Re: why index (collectionIndex) need a lock?
Date: Tue, 30 Sep 2014 23:13:44 -0400
Message-ID: <CANP1eJE9547YcnmtsgqzBJaGWiUbqPBHXEoset1oj466QvDpOg@mail.gmail.com>
References: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
	<CAPYLRzg=y1YKsZAACdwT08UiSVf_wZ8G1TFa7MYLOu8xV-fZyw@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2784E092@SACMBXIP02.sdcorp.global.sandisk.com>
	<CA+Hcz5-6=yLTm+niJGp1TJHmPGjAZtsf9Li9iHj=eGe-mCATdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:42448 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaJADNp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 23:13:45 -0400
Received: by mail-la0-f53.google.com with SMTP id gq15so169349lab.12
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 20:13:44 -0700 (PDT)
In-Reply-To: <CA+Hcz5-6=yLTm+niJGp1TJHmPGjAZtsf9Li9iHj=eGe-mCATdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Gregory Farnum <greg@inktank.com>, Nicheal <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 7:36 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
> On Tue, Sep 30, 2014 at 10:42 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Also, I don't think this lock has big impact to performance since it is already sharded to index level. I tried with reader/writer implementation of this lock (logic will be somewhat similar to your state concept) and not getting any benefit .
>
> If there is interest in identifying locks that are introducing latency
> it might useful to add some tracking features to Mutex and RWLock. A
> simple thing would be to just record maximum wait times per lock and
> dump this via admin socket.

Noah,

You're better off running some kind of synthetic test using mutrace
(you can't use tcmalloc/jemalloc) or measuring futex syscalls via a
pref tracepoint. Generally adding this kind of tracking into the locks
itself ends up being even more expensive.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
