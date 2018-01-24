From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: OSD recovery priority ?
Date: Wed, 24 Jan 2018 12:17:36 +0100
Message-ID: <2721061c-b583-7ea5-8b44-b1d80aa58700@corp.ovh.com>
References: <CAL2-6bLEx-C3H_7x+JGpJUzP=BTcL5TELi4RjVaf+q7FPms+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo302.mail-out.ovh.net ([137.74.110.74]:56017 "EHLO
        1.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbeAXLRj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 06:17:39 -0500
In-Reply-To: <CAL2-6bLEx-C3H_7x+JGpJUzP=BTcL5TELi4RjVaf+q7FPms+uw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 18-01-24 10:54 AM, Vincent Godin wrote:
> I have a cluster in recovery state and i notice that few pgs are only
> hold bye one OSD and a lot hold by two OSDs (pool configured with size
> =3 & min=1). After few days, i'm surprised to see that the few pgs
> hold only by one OSD are still there. It seems there is no high
> priority for pg in critical state (1 on 3) compare to those in warn
> state (2 on 3). Am i wrong or could it be a near feature ?
> My Cluster is in Jewel 10.2.6

http://docs.ceph.com/docs/master/release-notes/#v10-2-7-jewel
https://github.com/ceph/ceph/pull/13232 might be closest to what you need. 
You'd still need to bump up min_size to 2, though.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
