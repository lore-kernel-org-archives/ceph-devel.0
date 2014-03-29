From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: drop an unsafe assertion
Date: Sat, 29 Mar 2014 12:55:16 +0200
Message-ID: <CALFYKtDDpbjGKpR-vPn=bRMUN1PLFXTAHEpPNrkDne+rUnPTVQ@mail.gmail.com>
References: <1395867122-9340-1-git-send-email-elder@linaro.org>
	<alpine.DEB.2.00.1403281739030.22715@cobra.newdream.net>
	<53362600.1090904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33607 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaC2KzR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Mar 2014 06:55:17 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so5558665qge.30
        for <ceph-devel@vger.kernel.org>; Sat, 29 Mar 2014 03:55:17 -0700 (PDT)
In-Reply-To: <53362600.1090904@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, ob@daevel.fr

On Sat, Mar 29, 2014 at 3:46 AM, Alex Elder <elder@linaro.org> wrote:
> On 03/28/2014 07:41 PM, Sage Weil wrote:
>> Hi Alex, Ilya,
>>
>> I've added this and the previous patch to a for-linus branch to send to
>> Linux for 3.14.  The net of the two patches is simply removing the assert,
>> however... the first changes several lines that then get changed back.
>> Should we squash them?
>
> In my opinion, yes.  Ilya's movement of the assert within
> the spinlock was solving one problem, but ultimately that
> assertion should go away.

Sage, the way you squashed it we lost Alex's authorship and ended up
with his Signed-off-by, my Reviewed-by and me as an Author.  Since you
haven't pulled it into kernel.org yet, I did

git commit --amend --author='Alex Elder <elder@linaro.org>'

on for-linus to restore justice ;)

Thanks,

                Ilya
