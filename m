From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: updated gmock/gtest - now a googletest submodule
Date: Mon, 18 Jul 2016 15:55:39 +0200
Message-ID: <e0317c98-8e5c-a208-d1b7-6be83440a363@digiware.nl>
References: <57865EA2.8080501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17623 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcGRN4E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jul 2016 09:56:04 -0400
In-Reply-To: <57865EA2.8080501@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 13-7-2016 17:30, Josh Durgin wrote:
> Hey folks, an updated version of gmock and gtest, which are now in a
> single shared repo, called googletest, has been merged [0].
> 
> You'll need to make sure your submodules are up to date if you build
> the latest master.
> 
> This fixes a bug with gcc 6 and unit tests as noted in that PR,
> but as with any update, may introduce bugs. If you see any new
> oddities related to gmock or gtest, this may be the cause.

Hi Josh,

I think the code is sitting wll when compiling for FreeBSD
Did not need to change the build-script, and all unittests pass.
So real nice.

Thanx,
--WjW


