From: Guang Yang <yguang11@outlook.com>
Subject: Re: EC pool - empty files in OSD from radosgw
Date: Mon, 14 Jul 2014 17:47:46 +0800
Message-ID: <BLU436-SMTP138559DFDE12C157EC27FC7DF0A0@phx.gbl>
References: <22D2ACCA-6772-4041-8AB4-6FB331BD2AC5@outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [65.55.111.157] ([65.55.111.157]:61186 "EHLO
	BLU004-OMC4S18.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753551AbaGNJsy convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jul 2014 05:48:54 -0400
In-Reply-To: <22D2ACCA-6772-4041-8AB4-6FB331BD2AC5@outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, sam.just@inktank.com
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda and Sam,
Any suggestion on top of the below issue?

Thanks,
Guang

On Jul 12, 2014, at 12:43 AM, Guang Yang <yguang11@outlook.com> wrote:

> Hi Loic,
> I opened an issue in terms of a change brought along with EC pool plus radosgw (http://tracker.ceph.com/issues/8625), in our test cluster, we observed a large number of empty files in OSD and the root cause is that for head object from radosgw, there are a couple of transactions coming together, including create 0~0, setxattr, writefull, as EC bring the concept of the object generation, the create transaction will first create an object and the following write full transition will be taken as an update and rename the original empty file to a generation and create/write a new file. As a result, we observed quite some empty files.
> 
> There is an bug tracking the effort to remove those files with generation and is pending to be back port to firefly, that could definitely help our use case, however, I am also wondering if there is any room to improve for such case so that those empty files would not be generated in the first place (change might be at radosgw side).
> 
> Any suggestion is welcomed.
> 
> Thanks,
> Guang

