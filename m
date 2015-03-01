From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS and the next firefly release
Date: Sat, 28 Feb 2015 21:00:34 -0800
Message-ID: <CAC6JEv9C0g7Kz2eXhzP8-ENVADnHvc+AiRnMvRi6-GwYerEwjA@mail.gmail.com>
References: <54F1CE4B.5020004@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33033 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbCAFAg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Mar 2015 00:00:36 -0500
Received: by iecar1 with SMTP id ar1so40464501iec.0
        for <ceph-devel@vger.kernel.org>; Sat, 28 Feb 2015 21:00:35 -0800 (PST)
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com. [209.85.223.173])
        by mx.google.com with ESMTPSA id n31sm5622122ioe.18.2015.02.28.21.00.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Feb 2015 21:00:35 -0800 (PST)
Received: by iecrp18 with SMTP id rp18so40335944iec.9
        for <ceph-devel@vger.kernel.org>; Sat, 28 Feb 2015 21:00:34 -0800 (PST)
In-Reply-To: <54F1CE4B.5020004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Feb 28, 2015 at 6:18 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The fs teuthology suite for the next firefly release as found in https://github.com/ceph/ceph/commits/firefly-backports came back with three failures : http://tracker.ceph.com/issues/10641#fs. Do you think it is ready for QE to start their own round of testing ?
>
> Cheers
>
> P.S. I'll include the fs suite as part of the pre-QE round of testing from now on, unless you think it is redundant or not useful.

It'd be nice to see those tests run on a new enough kernel that they
pass, but yes; should be good!
-Greg
