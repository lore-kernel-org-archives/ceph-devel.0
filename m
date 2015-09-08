From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [Backport] assigning a pull request when asking permission to merge
Date: Tue, 8 Sep 2015 14:30:37 +0100
Message-ID: <CAJ4mKGZ3ME5qs-H6i8_AQmVxaziyaiii3t0h__dOczYVra0Svw@mail.gmail.com>
References: <55ECB461.6020805@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36850 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbbIHNai convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 09:30:38 -0400
Received: by wicgb1 with SMTP id gb1so78388389wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Sep 2015 06:30:37 -0700 (PDT)
In-Reply-To: <55ECB461.6020805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 6, 2015 at 10:47 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Today I realized that when we ask for permission to merge [1], we don't usually assign the pull request to the person who is supposed to answer. This may not be of consequence if thre is just one pull request to look at. But it's not uncommon to have half a dozen such pull requests after a suite passed. When the person reads her/his mail, a few are addressed and more often than not the rest is postponed for when there is time.
>
> Only they don't show up anywhere in the person list of TODO things, therefore it's frequent that we have to send a reminder. Instead, it's probably easier on everyone if we assign the pull request to the person next to act in that specific case. It's not something I usually do for pull requests that are assigned to me, because it's the best way for me to completely forget about such pull requests. But in this case, since each pull request is linked to an issue and since we scrub these issues at least on a weekly basis, there is no risk of us forgetting.
>
> What do you think ?

This is how I've been using PR assignment all along; sounds good to me!
