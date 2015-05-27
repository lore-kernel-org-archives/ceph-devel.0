From: Gregory Farnum <greg@gregs42.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Wed, 27 May 2015 14:32:45 -0700
Message-ID: <CAC6JEv_jPTjaodGSz6A5stqT8=9_xbC9FejdEghUcHOaq9iMCA@mail.gmail.com>
References: <5559DE24.4010601@dachary.org>
	<694044148.7711595.1432761176105.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36636 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbE0Vcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 17:32:47 -0400
Received: by qkx62 with SMTP id 62so13857689qkx.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 14:32:47 -0700 (PDT)
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com. [209.85.220.169])
        by mx.google.com with ESMTPSA id o19sm120316qkh.25.2015.05.27.14.32.46
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 14:32:46 -0700 (PDT)
Received: by qkx62 with SMTP id 62so13857412qkx.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 14:32:46 -0700 (PDT)
In-Reply-To: <694044148.7711595.1432761176105.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

On Wed, May 27, 2015 at 2:12 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> QE validation status.
>
> All detailed information is summarized in http://tracker.ceph.com/issues/11492
>
> Team leads pls review for do "go"-"no-go" decision.
>
> Issues to be considered:
>
> rados - passed ~2.8K jobs, listed issues (#11660, #11661) are not blockers
> (NOTE: we also agreed to use the "0/7th" rule for future point releases, e.g. passing "--subset 0/7" will be sufficient for release)
>
> knfs - #11789, #11790 - per Sage - not blockers; Greg, John - agreed?

Mmmm. I'm split in that these look to be new and I don't understand
anything about them, but we also don't care a ton about NFS re-export
of CephFS right now and I don't see how the current backport queue
could have induced them...

>
> samba - I assumed that failured in http://pulpito.ceph.com/teuthology-2015-05-18_13:46:55-samba-hammer-testing-basic-multi/ due to #6613, Greg pls confirm.

That looks to be the case.
