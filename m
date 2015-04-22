From: Gregory Farnum <greg@gregs42.com>
Subject: Re: init script bug with multiple clusters
Date: Wed, 22 Apr 2015 14:04:38 -0700
Message-ID: <CAC6JEv8qApCFWX342oz_gLBY12f8+xQ3f34nfHe5PmXYbsfTEw@mail.gmail.com>
References: <5524FBB9.9070300@m-privacy.de>
	<CAC6JEv9gHVrTmuo_Nc1vSxCDmh9WckYwrBN34nPrt7gwptGmYA@mail.gmail.com>
	<5530AEFB.1010805@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38157 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbDVVEj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 17:04:39 -0400
Received: by igbhj9 with SMTP id hj9so8135750igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 14:04:39 -0700 (PDT)
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com. [209.85.213.171])
        by mx.google.com with ESMTPSA id w2sm4069346igl.22.2015.04.22.14.04.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 14:04:38 -0700 (PDT)
Received: by igbhj9 with SMTP id hj9so8135424igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2015 14:04:38 -0700 (PDT)
In-Reply-To: <5530AEFB.1010805@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Apr 16, 2015 at 11:58 PM, Amon Ott <a.ott@m-privacy.de> wrote:
> Am 17.04.2015 um 03:01 schrieb Gregory Farnum:
>> This looks good to me, but we need an explicit sign-off from you for
>> it. If you can submit it as a PR on Github that's easiest for us, but
>> if not can you send it in git email patch form? :)
>
> Attached patch against next branch in git email form - hope this is as
> expected. Our devel system cannot send mail directly.

Yep, thanks! And sorry about the delay. I've set up a PR at
https://github.com/ceph/ceph/pull/4437 to make sure it gets reviewed
by somebody else with a little more of an eye on the init scripts;
should go in soon. :)
-Greg
