From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Mon, 3 Jul 2017 16:39:53 +1000
Message-ID: <CAF-wwdHMGNxKsXaSjHe+ur+onCvdwiZFwXorzQrQu48bi-wDKg@mail.gmail.com>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz> <5079a3cd-8b60-949f-a413-e159902aa275@digiware.nl>
 <bd8f5518-e9a6-98ac-7f0f-646ac01edd4b@suse.cz> <d3bab4db-1a03-13bf-c04a-b28dd8e25939@suse.cz>
 <2b4bf096-1f15-c5f7-2a32-9cdfe88462df@suse.cz> <4d293ea1-11ae-e9bc-5523-51584841c36f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37054 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdGCGjy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jul 2017 02:39:54 -0400
Received: by mail-it0-f51.google.com with SMTP id m84so51525681ita.0
        for <ceph-devel@vger.kernel.org>; Sun, 02 Jul 2017 23:39:54 -0700 (PDT)
In-Reply-To: <4d293ea1-11ae-e9bc-5523-51584841c36f@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jul 2, 2017 at 7:36 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Sorry, please forget everything I wrote above. The kraken make check failure
> is not a case of "Unix Domain socket path too long", after all. (Jenkins is
> set up to grep the log for certain strings and display them as possible
> causes if they are found, and that string appears in a later test, but
> AFAICT it doesn't cause the test to fail.)
>
> Several tests seem to fail, including the very first test:
>
>   2/156 Test   #1: test-ceph-helpers.sh ....................***Failed 44.06
> sec
>
> The log of that failed test is here: https://paste2.org/DB8z1kzV

Looks like this http://tracker.ceph.com/issues/20345

>
> Since this is happening on all kraken PRs, it looks like a regression. I
> will bisect.
>
>
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
