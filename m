Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921BC433B4
	for <ceph-devel@archiver.kernel.org>; Fri,  9 Apr 2021 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69DE60FE8
	for <ceph-devel@archiver.kernel.org>; Fri,  9 Apr 2021 15:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIPZi (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIPZi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Apr 2021 11:25:38 -0400
Received: from smtp.bit.nl (smtp.bit.nl [IPv6:2001:7b8:3:5::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C8C061760
        for <ceph-devel@vger.kernel.org>; Fri,  9 Apr 2021 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit.nl;
        s=smtp01; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Cc;
        bh=qfWW4ag96z2EaD+uMahd3CJVLvtdAMJqbUNl1wBg9dc=; b=ugiGSLNS4QbMwImKkpKqgzxV66
        YIy2P/c8+INMDJhjih6QwWhjSN5GT8U1KixkBJI5z2y5rSEwGFf4ljnzcztpfwpltxF/c0oF/U4DK
        +l31+47bTe5T+dzLZCT1KTn3wWUbYkupYNOXW1EfTFc+Ho7LBm3fS+Sfdn5TURrYyns92hxeD7JlW
        yeEXQPZjrCjA6wCz7ub0aORVMn37b1KDTlsqshZbpNn2V2nS0xNpEJ3dvFtZgzhtYtgieJiBjsOAH
        c062lLNW5EbGwnyAEoKeWg//Pkkz7IakvSfDNh/JFl/toqCX1dsinzf8iz6kDWtLe6dtaX1tX+ooT
        Zye729Cg==;
Received: from [2001:7b8:3:1002::1002] (port=10425)
        by smtp4.smtp.dmz.bit.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <stefan@bit.nl>)
        id 1lUt0c-0003Wx-Mg; Fri, 09 Apr 2021 17:25:22 +0200
To:     Robert LeBlanc <robert@leblancnet.us>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        ceph-users <ceph-users@ceph.io>
References: <CAANLjFpjRLtV+GR4WV15iXXCvkig6tJAr_G=_bZpZ=jKnYfvTQ@mail.gmail.com>
 <68fa3e03-55bd-c9aa-b19a-7cbe44af704e@bit.nl>
 <CAANLjFos0mFHhKULDD2SjEMN+JAra2x+tdw9gi5M27G_BumXVA@mail.gmail.com>
 <CAKTRiELqxD+0LtRXan9gMzot3y4A4M4x=km-MB2aET6wP_5mQg@mail.gmail.com>
 <CAANLjFrhHbuM-jW5HuuyBMFVu3GWnG23Ama8_vKs55GpOCTA-w@mail.gmail.com>
 <CAANLjFqttbppgtW=n2V04SyD-Lg2NbsNLvfE83Z5OsS=ZirjmQ@mail.gmail.com>
From:   Stefan Kooman <stefan@bit.nl>
Subject: Re: [ceph-users] Re: Nautilus 14.2.19 mon 100% CPU
Message-ID: <8933c3a0-64f7-aaab-6ab7-30e39b76a387@bit.nl>
Date:   Fri, 9 Apr 2021 17:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAANLjFqttbppgtW=n2V04SyD-Lg2NbsNLvfE83Z5OsS=ZirjmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On 4/9/21 3:40 PM, Robert LeBlanc wrote:
> I'm attempting to deep scrub all the PGs to see if that helps clear up
> some accounting issues, but that's going to take a really long time on
> 2PB of data.

Are you running with 1 mon now? Have you tried adding mons from scratch? 
So with a fresh database? And then maybe after they have joined, kill 
the donor mon and start from scratch.

You have for sure not missed a step during the upgrade (just checking 
mode), i.e. ceph osd require-osd-release nautilus.

Gr. Stefan
