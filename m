From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd and the next giant release
Date: Tue, 10 Feb 2015 08:40:01 -0800
Message-ID: <54DA3461.7070403@inktank.com>
References: <54DA210B.1000901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:49690 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbBJQkP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 11:40:15 -0500
Received: by mail-yh0-f51.google.com with SMTP id b6so6361412yha.10
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2015 08:40:14 -0800 (PST)
In-Reply-To: <54DA210B.1000901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/10/2015 07:17 AM, Loic Dachary wrote:
> Hi Josh,
>
> The rbd teuthology suite for the next giant release as found in https://github.com/ceph/ceph/commits/giant-backports came back (see http://pulpito.ceph.com/loic-2015-02-02_23:28:17-rbd-giant-backports---basic-multi) with one ceph-qa-suite error which was fixed (see http://tracker.ceph.com/issues/10501#teuthology-run-6b08a729540c61f3c8b15c5a3ce9382634bf800c-february-2015 for the details).
>
> Do you think it is ready for QE to start their own round of testing ?

Yup, looks ready to me. Thanks!

Josh

