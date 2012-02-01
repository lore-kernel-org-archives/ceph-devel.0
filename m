From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Wed, 1 Feb 2012 14:33:46 -0800
Message-ID: <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54907 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab2BAWdr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2012 17:33:47 -0500
Received: by iacb35 with SMTP id b35so2120900iac.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2012 14:33:46 -0800 (PST)
In-Reply-To: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 1, 2012 at 7:54 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi,
>
> FWIW, I've been trying to understand op delays under very heavy write
> load, and have been working a little with the policy throttler in hop=
es of
> using throttling delays to help track down which ops were backing up.
> Without much success, unfortunately.
>
> When I saw the wip-osd-op-tracking branch, I wondered if any of this
> stuff might be helpful. =A0Here it is, just in case.

In general these patches are dumping information to the logs, and part
of the wip-osd-op-tracking branch is actually keeping track of most of
the message queueing wait times as part of the message itself
(although not the information about number of waiters and sleep/wake
seqs). I'm inclined to prefer that approach to log dumping.
Are there any patches you recommend for merging? I'm a little curious
about the ordered wakeup one =97 do you have data about when that's a
problem?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
