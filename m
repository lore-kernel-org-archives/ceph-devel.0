From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #94
Date: Mon, 19 Dec 2016 16:43:00 +0100
Message-ID: <516684dd-33b1-e7d2-89d9-22f0ba74ecb8@digiware.nl>
References: <2025831951.53.1481945498160.JavaMail.jenkins@cephdev.digiware.nl>
 <93c0f8ac-a1e1-eaed-19bc-1be68b31f06f@digiware.nl>
 <20161219070242.GA1543@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:63102 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753932AbcLSPnP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Dec 2016 10:43:15 -0500
In-Reply-To: <20161219070242.GA1543@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

On 19-12-2016 08:02, Mykola Golub wrote:
> This is due to the recently added config option validators [1] (aimed
> to solve the API issue with rbd_default_features option).
> 
> It uses std::is_constructible to check if a type exists or just
> forward declared. Apparently, it does not work for clang. Using
> std::is_destructible instead looks like work [2].
> 
> [1] https://github.com/ceph/ceph/pull/12486
> [2] https://github.com/trociny/ceph/commit/bd584fe797e30d666800cd4d9b440d4b51d1d27e

Hi Mykola,

This seems to be a nice workaround.
I'll submit a PR.

--WjW

