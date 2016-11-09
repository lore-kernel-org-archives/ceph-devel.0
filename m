From: kefu chai <tchaikov@gmail.com>
Subject: Re: Seeking help in getting run-tox-ceph-detect-init to work.
Date: Wed, 9 Nov 2016 16:17:56 +0800
Message-ID: <CAJE9aOOj-A-kkBzjyOei7JHRY=qRmT_fVF9L7M_wFyypMKvoBQ@mail.gmail.com>
References: <6a74274e-4134-183c-f8fa-a180b5a93783@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34855 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbcKIIR5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 03:17:57 -0500
Received: by mail-qk0-f171.google.com with SMTP id n204so236927969qke.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2016 00:17:57 -0800 (PST)
In-Reply-To: <6a74274e-4134-183c-f8fa-a180b5a93783@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 9, 2016 at 6:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I'm looking for a developer with more Python experience....
> Especially with getting things thru tox.
>
> I was able to add FreeBSD support to ceph-detect-init in #11829. But
> then that is tested in run-tox-detect-init. Which now fails in a Linux
> Jenkins run:
> https://jenkins.ceph.com/job/ceph-pull-requests/13621/consoleFull#124607955c19247c4-fcb7-4c61-9a5d-7e2b9731c678
>
> But that heavily depends on mock and variations on
> platform.linux_distribution(), which is over my head.
>
> Like:
>     def test_get(self):
>         g = ceph_detect_init.get
>        with mock.patch('platform.linux_distribution',
>                         lambda **kwargs: (('unknown', '', ''))):
>             self.assertRaises(exc.UnsupportedPlatform, g)
>
> Which hits the assert because linux_distribution() returns
>         (' ', ' ', ' ')
> and the system info needs to be extracted from other functions.
>
> The brutal way would be to override this test, but the question then is
> with what? Because there is no one function that returns the required
> values. So the code would be a copy from what is in the _init_.py code.
>
> And that feels like a butcher testing his own meat.

yes, you need to mock some methods get called in
platform_information(), please see the updated patch at:
https://github.com/tchaikov/ceph/commit/fced2823c311bee2be0d226759809fc10170a6ff

in which, i also added a test for unsupported system.

>
> So help very much welcomed,
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
