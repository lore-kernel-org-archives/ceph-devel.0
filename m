From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: An empty vptr in an raw object
Date: Fri, 23 Dec 2016 02:20:16 +0100
Message-ID: <1270ac0b-9501-1550-03fc-f6f43523b492@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <CAF-wwdHbSejTSYGDvRdYcu03Dz=22wMP619cWfCcO1sx9h+wTw@mail.gmail.com>
 <CAF-wwdH5wQP11gQKcwoh0uVQpVHQXw=8XYCj+t=mhx0rfFSJSg@mail.gmail.com>
 <16b4b953-6369-626e-8348-21bbf39ca21c@digiware.nl>
 <CAF-wwdEhQL+rBQCqRdqTgdYCXWqDTVcJBPH8jHG5eiXn8-KRHA@mail.gmail.com>
 <80d484c5-acf3-6bc9-17f6-dddbae8d3ca5@digiware.nl>
 <20161223011510.GA6408@rskikr.localdomain>
 <EB02EE10422E4A40A1EE787A4AC27FBE045A04@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:32876 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761529AbcLWBVE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 20:21:04 -0500
In-Reply-To: <EB02EE10422E4A40A1EE787A4AC27FBE045A04@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Brad Hubbard <bhubbard@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 23-12-2016 02:16, Allen Samuels wrote:
> Does the unit test run or does it actually fault out or does it just report an error?

It crashes with a seg-fail.
It tries to use a vptr that is null to reference a get_data() function
in the raw class

--WjW


